const express = require("express");
const cors = require("cors");
const { urlInformation } = require("./middleware/urlInformation");
const errorHandler = require("./middleware/errorHandler");
const dotenv = require("dotenv").config();

const app = express();
const port =  process.env.PORT || 3002;

app.use(express.json());
app.use(cors());


app.use(urlInformation);

// app.use("/user");
app.use("/chat", require("./routes/chatRoutes"));
app.use("/chatgpt", require("./routes/chatgptRoutes"));


app.get("/", (req, res) => {
    res.send("Hello world");
});


app.use(errorHandler);


app.listen(port, "192.168.2.192",  () => {
    let date_ob = new Date();

    //current hours 
    let hours = date_ob.getHours();

    //current minutes
    let minutes  = date_ob.getMinutes();

    //current seconds
    let seconds = date_ob.getSeconds();

    console.log(`server is running in port ${port} // time-> ${hours} : ${minutes} : ${seconds}`);

});