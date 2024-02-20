//@desc Use to do chat in the app
//@route POST /user/new-user
//@access Public
const newUser = async (req, res) => {
    try {
        // const {messages} = req.body;
        // if(!messages) {
        //     res.status(400);
        //     // throw new Error("All fields are mandatory");  
        // }

     res.send("Hello world rounak");

    } catch (error) {
     console.log(error);
     res.status(400);
    //  throw new Error(`${error}`);
    }
}


module.exports = {
    newUser
}