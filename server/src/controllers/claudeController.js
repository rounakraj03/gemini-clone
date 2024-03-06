import { BedrockRuntime } from "@aws-sdk/client-bedrock-runtime";
import multer from "multer";
import pdfToText from "pdf-to-text";
import claudeHistoryModel from "../models/claude_history_model.js";


const textDecoder = new TextDecoder("utf-8");

const storage = multer.diskStorage({
    destination: 'uploads/',
    filename: (req, file, cb) => {
        const originalName = file.originalname;
        // const ext = extname(originalName);
        cb(null, `${Date.now()}-rounak-${originalName.split(' ').join('')}`);
    } 
});

const upload = multer({ storage });

const newChat = async (req, res, next) => {
    try {
        upload.single('pdf')(req, res, async (err) => {
            if (err instanceof multer.MulterError) {
                // A Multer error occurred when uploading.
                return res.status(400).json({ status: 400,
                    errorMessage: 'File upload error' });
            } else if (err) {
                // An unknown error occurred when uploading.
                return res.status(500).json({ status: 400,
                    errorMessage: 'Unknown error occurred' });
            }
            console.log("req", req.body.question);
        const  {question, userId} = req.body;
        if(!req.file || !question || !userId) {
            return res.status(400).json({
                status: 400,
                errorMessage: 'No file uploaded or no question sent or No userId found'});
        }
        console.log('file uploaded',req.file.path);
        console.log('question:', question);
        const responseData = await claudeReply({pdf_path: req.file.path, question: question})
        .then(async (value) => {
            const fileHeading = (req.file.path).split("-rounak-")[1];
            const result = await addOrUpdateChatHistory({userId: userId, bookData: value["bookData"], chatHistory: [{role: "Human", content: question}, {role:"Assistant", content: value["response"]}], filename: fileHeading});
            res.status(200).send({
                userId: result["userId"],
                chatHistory: result["chatHistory"]  ,
                chatId: result["_id"]    
            });
        })
        .catch((errValue) => {
            return res.status(400).json({
                status: 400,
                errorMessage: errValue});
        });
        // .catch((e) => {
        //     if(e.name == "ValidationException") {
        //         return res.status(400).json({
        //             status: 400,
        //             errorMessage: e.name});
        //     }
        //     return res.status(400).json({
        //         status: 400,
        //         errorMessage: e});
        // });
        // if(responseData) {
        //     const fileHeading = (req.file.path).split("-rounak-")[1];
        //     const result = await addOrUpdateChatHistory({userId: userId, bookData: responseData["bookData"], chatHistory: [{role: "Human", content: question}, {role:"Assistant", content: responseData["response"]}], filename: fileHeading});
        //     res.status(200).send({
        //         userId: result["userId"],
        //         chatHistory: result["chatHistory"]  ,
        //         chatId: result["_id"]    
        //     });
        // }
        }); 
    } catch (error) {
        console.log("ewwwwaaa");
        return res.status(400).json({
            status: 400,
            errorMessage: error});
    // res.status(406);
    // next(error);        
    }
};

const addOrUpdateChatHistory = async ({chatId=null, userId, bookData, chatHistory, filename}) => {
    if (chatId) {
        const updateClaudeSavedData = await claudeHistoryModel.findByIdAndUpdate(chatId, {
            chatHistory: chatHistory
        }, {new: true});
    if (!updateClaudeSavedData) {
        throw new Error("Chat history not found");
    }
    return updateClaudeSavedData;
    } else {
     const newClaudeSavedData = new claudeHistoryModel({
        userId: userId,
        chatHistory: chatHistory,
        bookData: bookData,
        heading: filename
     });
     const savedClaudeData = await newClaudeSavedData.save();
     return savedClaudeData;
    }
}


const claudeReply = async ({pdf_path, question}) => {

    try {
        return new Promise((resolve, reject) => {
            let pages = 0;
            pdfToText.info(pdf_path, function(err, info) {
                if (err) {
                    reject (err);
                } else {
                    pages  = info["pages"];
                    if(pages) {
                        // if(pages > 100){
                        //     pages = 100;
                        // }
                        var option = {from: 0, to: pages};
                        pdfToText.pdfToText(pdf_path, option, async function(err, data) {
                            if (err) {
                                reject(err);
                            } else {
                                    const prompt = data + "\n\n " + question;
                                    const response = await getTextClaude(prompt)
                                    .then((data2) => {
                                        resolve({bookData: data, response: data2});    
                                    }).catch((error) => {
                                    reject(error);
                                    });
                                }
                        });
                    } else {
                        reject ('No Page Found');
                    }
                }
            })
        });
    } catch (error) {
        return Promise.reject(error);
    }
}


const getTextClaude = async (prompt) => {
        return new Promise(async (resolve, reject) => {
    try {

            const bedrock = new BedrockRuntime({
                credentials: {
                    accessKeyId: process.env.AWS_ACCESS_KEY,
                    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
                },
                region: "us-east-1"
            });

            const params = {
                modelId: "anthropic.claude-v2:1",
                // modelId: "anthropic.claude-3-sonnet-20240229-v1:0",
                contentType: "application/json",
                accept: "application/json",
                body: JSON.stringify({
                    prompt:`\n\nHuman: ${prompt} \n\nAssistant:\n`,
                    max_tokens_to_sample: 130000,
                    // anthropic_version: "bedrock-2023-05-31",
                    // max_tokens_to_sample: 2048,
                    temperature: 0.7,
                    top_k: 250,
                    top_p: 1,
                    // stop_sequence: ["\\n\\nHuman:"],q
                }),
            };


        const data = await bedrock.invokeModel(params);
    
        if(!data) {
            reject("AWS Bedrock Clause Error");
        } else {
            const response_body = JSON.parse(textDecoder.decode(data.body));
            resolve(response_body.completion);
        }   
    } catch (error) {
        if(error.name == "ValidationException") {
            reject (error.name);
        } else {
            reject(error);
        }
    }  
    });
}


const nextChats = async (req, res, next) => {
    try{
    const {userId, chatId, question} = req.body;

    if(!userId || !chatId || !question) {
        return res.status(400).json({error: 'Send all fields'});
    }
    //getDataFromMongooseForSpecificId;
    const data = await claudeHistoryModel.findOne({_id: chatId});
    if(data["chatHistory"] && data["bookData"]) {
        data["chatHistory"].push({role: "Human", content: question});
        let stringPrompt = "Human: " + data["bookData"];
        for(const d in data["chatHistory"]) {
            if(d == 0) {
                stringPrompt += data["chatHistory"][d]["content"];
            } else {
                if(data["chatHistory"][d]["role"] == "Human") {
                    stringPrompt += " Human: " + data["chatHistory"][d]["content"];
                } else {
                    stringPrompt += " Assistant: " + data["chatHistory"][d]["content"];
                }
            }
        }
        stringPrompt += " Assistant: ";
        const response = await getTextClaude(stringPrompt);
        data["chatHistory"].push({role: "Assistant", content: response});
        const result = await addOrUpdateChatHistory({userId: userId, chatHistory: data["chatHistory"], chatId: chatId});
    }

    // console.log(`data => ${data}`)
    res.status(200).json({
        chatId : data["_id"],
        userId: data["userId"],
        chatHistory: data["chatHistory"],
        heading: data["heading"]
     });
    } catch(e) {
        console.log("error", e);
        next(e);
    }
}

//@desc Use to do signup
//@route POST /claude/getClaudeHistory
//@access Public
const getClaudeHistory = async (req, res, next) => {
    try {
        const {userId} = req.body;
        if(!userId) {
            res.status(405);
            throw new Error("All fields are mandatory");  
        }
        const userChat = await claudeHistoryModel.find({userId : userId}).sort({updatedAt : -1});
        let tempList = [];
        for (const chat of userChat) {
            tempList.push({
                chatId: chat["_id"],
                heading: chat["heading"],
                chatHistory: chat["chatHistory"],
                updatedAt: chat["updatedAt"]
            });
        }
        res.status(200).json(tempList);

    } catch (error) {
        res.status(406);
        console.log(`Error:> ${error}`);
        next(error);
    }
}



export {
    newChat,
    nextChats,
    getClaudeHistory
};