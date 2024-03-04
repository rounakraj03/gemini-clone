import { Router } from "express";
import { newChat, nextChats } from "../controllers/claudeController.js";
const claudeRoutes  = Router();

claudeRoutes.route("/new-chat").post(newChat);
claudeRoutes.route("/next-chats").post(nextChats);

export default claudeRoutes;