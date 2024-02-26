const express = require("express");
const { newChat, getChatGptHistory, addChatGptHistory } = require("../controllers/chatgptController");
const router  = express.Router();

router.route("/new-chat").post(newChat);


router.route("/getChatGptHistory").post(getChatGptHistory);
router.route("/addChatGptHistory").post(addChatGptHistory);

module.exports = router;