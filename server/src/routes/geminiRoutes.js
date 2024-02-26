const express = require("express");
const { newChat, dummyChat, getGeminiHistory, addGeminiHistory } = require("../controllers/geminiController");
const router  = express.Router();

router.route("/new-chat").post(newChat);
router.route("/dummy-chat").post(dummyChat);



router.route("/getGeminiHistory").post(getGeminiHistory);
router.route("/addGeminiHistory").post(addGeminiHistory);


module.exports = router;