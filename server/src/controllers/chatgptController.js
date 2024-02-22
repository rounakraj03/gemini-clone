const { OpenAI } = require("openai");


const openai = new OpenAI({
    apiKey: process.env.CHATGPT_API_KEY,
  });

//@desc Use to do new chat in the app
//@route POST /chatgpt/new-chat
//@access Public
const newChat = async (req, res, next) => {
    try {
        const {old_message, new_message} = req.body;
        if(!old_message || !new_message) {
            res.status(405);
            throw new Error("All fields are mandatory");  
        }

        const result = await openai.chat.completions.create({
            model: "gpt-3.5-turbo-16k",
            messages: old_message,
            temperature: 1,
            max_tokens: 256,
            top_p: 1,
            frequency_penalty: 0,
            presence_penalty: 0,
            stream: true
        });

        res.set({"Content-Type": "text/event-stream"});


        for await (const chunk of result) {
            const data = chunk.choices[0].delta.content || "";
            res.write(data);
        }
        res.end();
    } catch (error) {
     next(error);
    }
}


module.exports = {
    newChat
}



