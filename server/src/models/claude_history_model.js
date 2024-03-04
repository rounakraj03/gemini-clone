import mongoose from "mongoose";

const Schema = mongoose.Schema;


const claudeHistorySchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: userSchema,
        required: true
    },
    heading: String,
    bookData: String,
    chatHistory: []
}, {timestamps: true});

const claudeHistoryModel = mongoose.model("claudeHistory", claudeHistorySchema, "claudeHistory");

export default claudeHistoryModel;