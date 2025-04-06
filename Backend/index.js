import express from "express";
import dotenv from "dotenv";
dotenv.config();
import connectDB from "./DB/database.js";
import noteRoutes from "./router/notes.router.js"
const app = express()


// Middleware
app.use(express.json());

connectDB();

// Use note routes
app.use('/api', noteRoutes);

app.listen(3000,()=>{
    console.log("Server is running on port 3000")
})

