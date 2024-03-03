import { mongoose } from "mongoose";
import userSchema from "./user_model.js";

const Schema = mongoose.Schema;

const chatGPThistorySchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId, // Reference to the user model's ObjectId
        ref: userSchema, // Referencing the 'User' model
        required: true
    },
    heading: String,
    chatHistory: [] 
}, {timestamps: true});


const chatGPThistoryModel = mongoose.model("chatgptHistory", chatGPThistorySchema, "chatgptHistory");


export default chatGPThistoryModel;