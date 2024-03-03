import { mongoose } from "mongoose";
import userSchema from "./user_model.js";

const Schema = mongoose.Schema;

const geminiHistorySchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: userSchema,
        required: true
    },
    heading: String,
    chatHistory: []
}, {timestamps: true});

const geminiHistoryModel = mongoose.model("geminiHistory", geminiHistorySchema, "geminiHistory");

export default geminiHistoryModel;