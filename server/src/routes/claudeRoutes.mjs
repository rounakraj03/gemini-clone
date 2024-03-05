import { Router } from "express";
import { getClaudeHistory, newChat, nextChats } from "../controllers/claudeController.js";
import { get } from "mongoose";
const claudeRoutes  = Router();

claudeRoutes.route("/new-chat").post(newChat);
claudeRoutes.route("/next-chats").post(nextChats);

claudeRoutes.route("/getClaudeHistory").post(getClaudeHistory);

export default claudeRoutes;