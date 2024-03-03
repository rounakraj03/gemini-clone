import { Router } from "express";
import  { login, signup } from "../controllers/userController.js";
const userRoutes  = Router();

userRoutes.route("/login").post(login);
userRoutes.route("/signup").post(signup);

export default userRoutes;