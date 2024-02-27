const {mongoose} = require("mongoose");
const userSchema = require("./user_model");

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

module.exports = geminiHistoryModel;