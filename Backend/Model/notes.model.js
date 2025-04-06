import mongoose from "mongoose";

const notesSchema = mongoose.Schema({
    title: {
        type: String,
        required: true,
        trim: true,
        maxlength: 100,
      },
      content: {
        type: String,
        required: true,
      },
      tags: {
        type: [String],
        default: [],
      },
})
const Notes = mongoose.model('Notes', notesSchema);
export default Notes