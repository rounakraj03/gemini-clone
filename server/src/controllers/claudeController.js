import { BedrockRuntime } from "@aws-sdk/client-bedrock-runtime";
import multer from "multer";
import pkg from "pdf-to-text";
const { info, pdfToText } = pkg;


const textDecoder = new TextDecoder("utf-8");

const storage = multer.diskStorage({
    destination: 'uploads/',
    filename: (req, file, cb) => {
        const originalName = file.originalname;
        // const ext = extname(originalName);
        cb(null, `${Date.now()}${originalName.split(' ').join('')}`);
    } 
});

const upload = multer({ storage });

const newChat = async (req, res, next) => {
    try {
        upload.single('pdf')(req, res, async (err) => {
            if (err instanceof multer.MulterError) {
                // A Multer error occurred when uploading.
                return res.status(400).json({ error: 'File upload error' });
            } else if (err) {
                // An unknown error occurred when uploading.
                return res.status(500).json({ error: 'Unknown error occurred' });
            }
            console.log("req", req.body.question);
        const  question = req.body.question;
        if(!req.file || !question) {
            return res.status(400).json({error: 'No file uploaded or no question sent'});
        }
        console.log('file uploaded',req.file.path);
        console.log('question:', question);
        const responseData = await claudeReply({pdf_path: req.file.path, question: question})
        res.status(200).send(responseData);
        }); 
    } catch (error) {
    res.status(406);
    next(error);        
    }
};


const claudeReply = async ({pdf_path, question}) => {
    return new Promise((resolve, reject) => {
        let pages = 0;
        info(pdf_path, function(err, info) {
            if (err) {
                reject (err);
            } else {
                pages  = info["pages"];
                if(pages) {
                    var option = {from: 0, to: pages};
                    pdfToText(pdf_path, option, async function(err, data) {
                        if (err) {
                            reject(err);
                        } else {
                            const prompt = data + "\n\n " + question;
                            const response = await getTextClaude(prompt);
                            resolve(response);
                        }
                    });
                } else {
                    reject ('No Page Found');
                }
            }
        })
    });
}


const getTextClaude = async (prompt) => {
    const bedrock = new BedrockRuntime({
        credentials: {
            accessKeyId: process.env.AWS_ACCESS_KEY,
            secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
        },
        region: "us-east-1"
    });

    const params = {
        modelId: "anthropic.claude-v2:1",
        contentType: "application/json",
        accept: "application/json",
        body: JSON.stringify({
            prompt:`\n\nHuman: ${prompt} \n\nAssistant:\n`,
            max_tokens_to_sample: 120000,
            // max_tokens_to_sample: 2048,
            temperature: 0.7,
            top_k: 250,
            top_p: 1,
            // stop_sequence: ["\\n\\nHuman:"],q
        }),
    };

    const data = await bedrock.invokeModel(params);

    if(!data) {
        throw new Error("AWS Bedrock Clause Error");
    } else {
        const response_body = JSON.parse(textDecoder.decode(data.body));
        return response_body.completion;
    }
}


export {
    newChat
};