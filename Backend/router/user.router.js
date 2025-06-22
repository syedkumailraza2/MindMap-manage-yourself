import express from "express";
import { login, register } from "../Controller/user.controller.js";

const userRoutes = express.Router()

userRoutes.post('/register', register)
userRoutes.post('/login',login)

export default userRoutes