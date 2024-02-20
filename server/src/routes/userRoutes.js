const express = require("express");
const { newUser } = require("../controllers/userController");
const router  = express.Router();

router.route("/new-user").post(newUser);

module.exports = router;