const express = require("express");
const cors = require("cors");
const { urlInformation } = require("./middleware/urlInformation");
const errorHandler = require("./middleware/errorHandler");
const {mongoose} = require("mongoose");
const dotenv = require("dotenv").config();

const app = express();
const port =  process.env.PORT || 3002;

app.use(express.json());
app.use(cors());


app.use(urlInformation);

app.use("/user", require("./routes/userRoutes"));
app.use("/gemini", require("./routes/geminiRoutes"));
app.use("/chatgpt", require("./routes/chatgptRoutes"));


app.get("/", (req, res) => {
    res.send("Hello world");
});


app.use(errorHandler);


mongoose.connect(
    `mongodb+srv://${process.env.MONGOOSE_USERNAME}:${process.env.MONGOOSE_PASSWORD}@ai-chats.mhctans.mongodb.net/?retryWrites=true&w=majority&appName=ai-chats`)
    .then((result) => {
    // app.listen(port, "192.168.2.192",  () => {
    app.listen(port, "192.168.29.234",  () => {
    // app.listen(port, () => {
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
