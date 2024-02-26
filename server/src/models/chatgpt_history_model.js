const {mongoose} = require("mongoose");
const userSchema = require("./user_model");

const Schema = mongoose.Schema;

// chatgptListSchema = new Schema({
//     heading: {
//         type: String,
//     },
//     conversation_List : []
// });

const chatGPThistorySchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId, // Reference to the user model's ObjectId
        ref: userSchema, // Referencing the 'User' model
        required: true
    },

    chatHistory: {
        heading: {
            type: String,
        },
        conversation_List : []
    },
    
    lastUpdated: {
        type: Date,
        required: true
    }
});


module.exports = mongoose.model("chatgptHistory", chatGPThistorySchema, "chatgptHistory");