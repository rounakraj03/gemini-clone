import { Router } from "express";
import { newChat, dummyChat, getGeminiHistory, addGeminiHistory } from "../controllers/geminiController.js";
const geminiRoutes  = Router();

geminiRoutes.route("/new-chat").post(newChat);
geminiRoutes.route("/dummy-chat").post(dummyChat);



geminiRoutes.route("/getGeminiHistory").post(getGeminiHistory);
geminiRoutes.route("/addGeminiHistory").post(addGeminiHistory);


export default geminiRoutes;