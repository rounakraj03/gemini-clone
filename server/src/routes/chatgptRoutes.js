const express = require("express");
const { newChat } = require("../controllers/chatgptController");
const router  = express.Router();

router.route("/new-chat").post(newChat);

module.exports = router;