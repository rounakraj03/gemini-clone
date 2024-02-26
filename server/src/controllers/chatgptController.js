const { OpenAI } = require("openai");
const chatgpt_history_model = require("../models/chatgpt_history_model");
const chatGPThistoryModel = require("../models/chatgpt_history_model");


const openai = new OpenAI({
    apiKey: process.env.CHATGPT_API_KEY,
  });

//@desc Use to do new chat in the app
//@route POST /chatgpt/new-chat
//@access Public
const newChat = async (req, res, next) => {
    try {
        const {old_message, new_message, userId, chatId} = req.body;
        if(!old_message || !new_message || !userId) {
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

        var streamTxt = "";
        for await (const chunk of result) {
            const data = chunk.choices[0].delta.content || "";
            streamTxt += data;
            res.write(data);
        }

        old_message.push({"role": "assistant", "content": streamTxt});

        const chatHistory = {
            "heading" : `${new Date()}`,
            "conversation_List" : JSON.stringify(old_message)
        };
        console.log(`Streamed Text=> ${streamTxt}, old_message: ${old_message}, old_message.lenth => ${old_message.length}`);

        if(chatId) {
            const updatedChatGptSavedData = await chatGPThistoryModel.findByIdAndUpdate(
                chatId,
                {
                    chatHistory: JSON.stringify(chatHistory),
                },
                {new: true}
            );

            if(!updatedChatGptSavedData) {
                res.status(404);
                throw new Error("Chat history not found");
            }
            console.log("chat History Founded");
        } else {
            const newChatGptSavedData = new chatGPThistoryModel({
                userId: userId,
                chatHistory: JSON.stringify(chatHistory),
            });
            console.log("chat History Not Founded");
            const savedChatGptData = await newChatGptSavedData.save();
        }

        res.end();
    } catch (error) {
     next(error);
    }
}




//@desc Use to do signup
//@route POST /chatgpt/getChatGptHistory
//@access Public
const getChatGptHistory = async (req, res, next) => {
    try {
        const {userId} = req.body;
        if(!userId) {
            res.status(405);
            throw new Error("All fields are mandatory");  
        }
        const userChat = await chatGPThistoryModel.find({userId : userId}).sort({updatedAt : -1});
        res.status(200).json(userChat);


    } catch (error) {
        console.log(`Error:> ${error}`);
        next(error);
    }
}


//@desc Use to do signup
//@route POST /user/addChatGptHistory
//@access Public
const addChatGptHistory = async (req, res, next) => {
    try {
        const {userId, chatHistory, chatId} = req.body;
        if(!userId || !chatHistory) {
            res.status(405);
            throw new Error("All fields are mandatory");  
        }

        if(chatId) {
            const updatedChatGptSavedData = await chatGPThistoryModel.findByIdAndUpdate(
                chatId,
                {
                    chatHistory: chatHistory,
                },
                {new: true}
            );

            if(!updatedChatGptSavedData) {
                res.status(404);
                throw new Error("Chat history not found");
            }
            res.status(200).json(updatedChatGptSavedData);
        } else {
            const newChatGptSavedData = new chatgpt_history_model({
                userId: userId,
                chatHistory: chatHistory,
            });
            const savedChatGptData = await newChatGptSavedData.save();
            res.status(200).json(savedChatGptData);
        }
    } catch (error) {
        console.log(`Error: ${error}`);
        next(error);
    }
}



module.exports = {
    newChat,
    getChatGptHistory,
    addChatGptHistory
}



