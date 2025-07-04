import express from "express";
import { login, register, signInwithGoogle } from "../Controller/user.controller.js";

const userRoutes = express.Router()

userRoutes.post('/register', register)
userRoutes.post('/login',login)
userRoutes.post('/google', signInwithGoogle)

export default userRoutes