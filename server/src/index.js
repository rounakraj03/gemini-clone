import express from "express";
import 'dotenv/config';
import cors from "cors";
import urlInformation from "./middleware/urlInformation.js"
import errorHandler from "./middleware/errorHandler.js";
import mongoose from "mongoose";
import userRoutes from './routes/userRoutes.mjs';
import geminiRoutes from './routes/geminiRoutes.mjs';
import chatgptRoutes from './routes/chatgptRoutes.mjs';
import claudeRoutes from './routes/claudeRoutes.mjs';



const app = express();
const port =  process.env.PORT || 3002;

app.use(express.json());
app.use(cors());


app.use(urlInformation);

app.use("/user", userRoutes);
app.use("/gemini", geminiRoutes);
app.use("/chatgpt", chatgptRoutes);
app.use("/claude", claudeRoutes);


app.get("/", (req, res) => {
    res.send("Hello world");
});


app.use(errorHandler);


mongoose.connect(
    `mongodb+srv://${process.env.MONGOOSE_USERNAME}:${process.env.MONGOOSE_PASSWORD}@ai-chats.mhctans.mongodb.net/?retryWrites=true&w=majority&appName=ai-chats`)
    .then((result) => {
    // app.listen(port, "192.168.29.234",  () => {
    // app.listen(port, "192.168.2.192",  () => {
    app.listen(port, () => {
        let date_ob = new Date();
    
        //current hours 
        let hours = date_ob.getHours();
    
        //current minutes
        let minutes  = date_ob.getMinutes();
    
        //current seconds
        let seconds = date_ob.getSeconds();
    
        console.log(`server is running in port ${port} // mongoose server connected // time-> ${hours} : ${minutes} : ${seconds}`);
    
    });
    
}).catch((err) => {
    console.log(`Error in running server ${err}`);    
});
