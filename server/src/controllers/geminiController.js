const { GoogleGenerativeAI } = require("@google/generative-ai");
const geminiHistoryModel = require("../models/gemini_history_model");

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);


//@desc Use to do chat in the app
//@route POST /chat/new-chat
//@access Public

/* sample 

old_message = [
              {
                role: "user",
                parts: "Hello, I have 2 dogs in my house.",
              },
              {
                role: "model",
                parts: "Great to meet you. What would you like to know?",
              },
            ],

new_message = "Can you use internet and if yes whats 1 USD = INR?"
*/
const newChat = async (req, res, next) => {
    try {
      const {old_message, new_message, userId, chatId} = req.body;
      if(!old_message || !new_message || !userId) {
            res.status(405);
            throw new Error("All fields are mandatory");  
        }

        const new_message_json = {
          role:'user',
          parts:new_message
        } 
        const chatHistory1 = [...old_message, new_message_json];
        let new_chat_id = chatId;

        if(!chatId) {
          const addedChatDataInfo = await addOrUpdateChatHistory({chatId : chatId, userId: userId, chatHistory: chatHistory1});
          new_chat_id = addedChatDataInfo.id;
      }

        const model = genAI.getGenerativeModel({ model: "gemini-pro"});
        const chat = model.startChat({
            history: old_message,
            generationConfig: {
              maxOutputTokens: 2000,
            },
          });

          const msg = new_message;

          const result = await chat.sendMessageStream(msg);

        res.set({"Content-Type": "text/event-stream"});

        var streamTxt = "";
        for await (const chunk of result.stream) {
            const data =  chunk.text() || "" ;
            streamTxt += data;
            const formattedText = {
              chatId: new_chat_id,
              data: data
          };
          res.write(JSON.stringify(formattedText));
        }

        console.log(`Streamed Text=> ${streamTxt}`);
        chatHistory1.push({ "role": "model", "parts": streamTxt });
        addOrUpdateChatHistory({chatId : new_chat_id, userId: userId, chatHistory: chatHistory1});
        res.end();

    } catch (error) {
     next(error);
    }
}


const addOrUpdateChatHistory = async ({chatId=null, userId,  chatHistory}) => {
  if(chatId) {
      const updatedGeminiSavedData = await geminiHistoryModel.findByIdAndUpdate(
          chatId,
          {
              chatHistory: chatHistory,
          }, {new: true}
      );
      if(!updatedGeminiSavedData) {
          throw new Error("Chat history not found");
      }
      return updatedGeminiSavedData; 
  } else {
      //generate a heading here
      const newGeminiSavedData = new geminiHistoryModel({
          userId: userId,
          chatHistory: chatHistory,
          heading: (chatHistory.length > 2) ? `${chatHistory[2]["parts"]}` :`${new Date()}`
      });
      const savedChatGptData = await newGeminiSavedData.save();
      return savedChatGptData;
  }
}

//@desc Use to do dummy chat in the app
//@route POST /chat/dummy-chat
//@access Public
const dummyChat = async (req, res, next) => {
    try {
        const {messages} = req.body;
        if(!messages) {
            res.status(405);
            throw new Error("All fields are mandatory");  
        }
        run(req, res);

    } catch (error) {
     next(error);
    }
}


async function run(req, res) {
  // For text-only input, use the gemini-pro model
  const model = genAI.getGenerativeModel({ model: "gemini-pro"});

  const chat = model.startChat({
    history: [
      {
        role: "user",
        parts: "Hello, I have 2 dogs in my house.",
      },
      {
        role: "model",
        parts: "Great to meet you. What would you like to know?",
      },
    ],
    generationConfig: {
      maxOutputTokens: 100,
    },
  });

  const msg = "How many paws are in my house?";

  const result = await chat.sendMessage(msg);
  const response = await result.response;
  const text = response.text();
  console.log(text);
  res.send(text);
}


//@desc Use to do signup
//@route POST /user/getGeminiHistory
//@access Public
const getGeminiHistory = async (req, res, next) => {
  try {
    const {userId} = req.body;
    if(!userId) {
        res.status(405);
        throw new Error("All fields are mandatory");  
    }
    const userChat = await geminiHistoryModel.find({userId : userId}).sort({updatedAt : -1});
    res.status(200).json(userChat);
} catch (error) {
    console.log(`Error:> ${error}`);
    next(error);
}
}




//@desc Use to do signup
//@route POST /user/addGeminiHistory
//@access Public
const addGeminiHistory = async (req, res, next) => {
  try {
      const {id} = req.body;
      if(!id) {
          res.status(405);
          throw new Error("All fields are mandatory");  
      }
      const user = new user_model({
          email: email,
          password: password
      });
      const savedUser = await user.save();
      res.status(200).json(savedUser);
  } catch (error) {
      console.log(`Error:> ${error}`);
      next(error);
  }
}



module.exports = {
    newChat,
    dummyChat,
    getGeminiHistory,
    addGeminiHistory
}