import mongoose from "mongoose";

const userSchema = mongoose.Schema({
name: { type: String, },
email: { type: String, requred: true, unique:true },
password: { type: String },
provider: {type: String}
})

const User = mongoose.model('User',userSchema)
export default User