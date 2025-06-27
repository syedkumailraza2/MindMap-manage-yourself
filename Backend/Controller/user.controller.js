import User from "../Model/user.model.js";
import bcrypt from "bcrypt"

const register = async (req,res)=>{
    try {
        const {name, email, password} = req.body
        if(!name){
            res.status(400).json({ message: 'Name is required'});
        }
        if(!email){
            res.status(400).json({ message: 'Email is required'});
        }
        if(!password){
            res.status(400).json({ message: 'Password is required'});
        }

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            res.status(400).json({ message: 'User already exist'});
        }

        const hashedPassword = await bcrypt.hash(password, 10)

        const newUser = new User({
            email,
            name,
            password: hashedPassword,
            provider: 'Custom'
        })
        await newUser.save()

        res.status(201).json({ message: 'User registered successfully', user: newUser });
    } catch (error) {
        console.log('error while register:',error);
        res.status(500).json({ message: 'Error registering user', error: error.message });
    }
}

const login = async (req,res)=>{
    try {
        const { email, password } = req.body
        const existingUser = await User.findOne({ email });
        if (!existingUser) {
            res.status(400).json({ message: 'User not Found'});
        }
        const decryptPass = await bcrypt.compare(password, existingUser.password)
        if (!decryptPass) {
            res.status(400).json({ message: 'Invalid password'});
        }

        res.status(200).json({ message: 'User Login successfully', user: existingUser });

    } catch (error) {
        console.log('error while login:',error);
        res.status(500).json({ message: 'Error login user', error: error.message });
    }
}

const signInwithGoogle = async (req,res)=>{
    try {
        const { email, name } = req.body
        console.log(`email: ${email}, name:${name}`);
        
        const existingUser = await User.findOne({ email });
        if (!existingUser) {
            const newUser = new User({
            email,
            name,
            provider: 'Google'
        })
        await newUser.save()
        console.log('User registered successfully')
        res.status(201).json({ message: 'User registered successfully', user: newUser });
        }
        res.status(200).json({ message: 'User Login successfully', user: existingUser });

    } catch (error) {
        console.log('error while signin with google:',error);
        res.status(500).json({ message: 'Error signin with google', error: error.message });
    }
}

export {register, login, signInwithGoogle}