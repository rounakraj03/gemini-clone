import { Router } from "express";
import {newChat, getChatGptHistory, addChatGptHistory} from "../controllers/chatgptController.js";
const chatgptRoutes  = Router();

chatgptRoutes.route("/new-chat").post(newChat);


chatgptRoutes.route("/getChatGptHistory").post(getChatGptHistory);
chatgptRoutes.route("/addChatGptHistory").post(addChatGptHistory);

export default chatgptRoutes;