import { Router } from "express";
import { newChat } from "../controllers/claudeController.js";
const claudeRoutes  = Router();

claudeRoutes.route("/new-chat").post(newChat);

export default claudeRoutes;