const { GoogleGenerativeAI } = require("@google/generative-ai");

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
        const {old_message, new_message} = req.body;
        if(!old_message || !new_message) {
            res.status(405);
            throw new Error("All fields are mandatory");  
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


        let text = '';
        for await (const chunk of result.stream) {
            const data =  chunk.text() || "" ;
            const formattedData = `data: ${JSON.stringify({ data })}\n\n`;
            res.write(formattedData);
        }

        res.end();

    } catch (error) {
     next(error);
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



module.exports = {
    newChat,
    dummyChat
}