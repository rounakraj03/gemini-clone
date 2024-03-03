import user_model from "../models/user_model.js";
//@desc Use to do login
//@route POST /user/login
//@access Public

const login = async (req, res, next) => {
    try {
        const {email, password} = req.body;
        if(!email || !password) {
            res.status(405);
            throw new Error("All fields are mandatory");  
        }
        const user = await user_model.findOne({email: email});
        if(!user) {
            res.status(404);
            throw new Error("No User Found");  
        }
        if(user) {
            if(user.password == password) {
                res.status(200).json(user); 
            } else {
                res.status(404);
            throw new Error("Incorrect Password");
            }
        }

    } catch (error) {
        res.status(406);
     next(error);
    }
}



//@desc Use to do signup
//@route POST /user/signup
//@access Public
const signup = async (req, res, next) => {
    try {
        const {email, password} = req.body;
        if(!email || !password) {
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
        res.status(406);
        console.log(`Error:> ${error}`);
        next(error);
    }
}







export { login, signup}