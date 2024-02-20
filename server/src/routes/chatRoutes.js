const express = require("express");
const { newChat, dummyChat } = require("../controllers/chatController");
const router  = express.Router();

router.route("/new-chat").post(newChat);
router.route("/dummy-chat").post(dummyChat);

module.exports = router;