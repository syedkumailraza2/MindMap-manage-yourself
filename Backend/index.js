import express from "express";
import dotenv from "dotenv";
dotenv.config();
import connectDB from "./DB/database.js";
import noteRoutes from "./router/notes.router.js"
import userRoutes from "./router/user.router.js";
const app = express()
const port = process.env.PORT || 3000


// Middleware
app.use(express.json());

connectDB();

// Use note routes
app.use('/notes', noteRoutes);
app.use('/user', userRoutes)

app.get('/',(req,res)=>{
    console.log('Hello in console');
    
    res.send("Hello world!")
})

app.listen(port,()=>{
    console.log(`Server is running on port ${port}`)
})

