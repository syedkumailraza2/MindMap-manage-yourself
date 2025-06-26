// controllers/noteController.js
import Notes from '../Model/notes.model.js'; // Adjust the path if necessary
import User from '../Model/user.model.js';

// Create a new note
export const createNote = async (req, res) => {
  try {
    const { title, content, tags, userId } = req.body;
    console.log(` Title: ${title}, Content: ${content}, Tags: ${tags}, userId: ${userId}`);
    
    const existingUser = await User.findById(userId); 
    if (!existingUser) {
      res.status(400).json({ message: 'User not Found'});
    }

    const newNote = new Notes({ title, content, tags, userId });
    await newNote.save();
    res.status(201).json({ message: 'Note created successfully', note: newNote });
  } catch (error) {
    console.log('Error creating note: ',error);
    
    res.status(500).json({ message: 'Error creating note', error: error.message });
  }
};

// Get all notes
export const getAllNotes = async (req, res) => {
  try {
    const { userId } = req.params; // Destructure userId from req.params

    const notes = await Notes.find({ userId }); // Find notes that match the userId

    res.status(200).json(notes);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching notes', error: error.message });
  }
};


// Update a note
export const updateNote = async (req, res) => {
  try {
    const { title, content, tags } = req.body;
    const note = await Notes.findByIdAndUpdate(
      req.params.id,
      { title, content, tags },
      { new: true, runValidators: true }
    );

    if (!note) {
      return res.status(404).json({ message: 'Note not found' });
    }

    res.status(200).json({ message: 'Note updated successfully', note });
  } catch (error) {
    res.status(500).json({ message: 'Error updating note', error: error.message });
  }
};

// Delete a note
export const deleteNote = async (req, res) => {
  try {
    const note = await Notes.findByIdAndDelete(req.params.id);
    if (!note) {
      return res.status(404).json({ message: 'Note not found' });
    }
    res.status(200).json({ message: 'Note deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting note', error: error.message });
  }
};

export const getNote = async (req, res) => {
  try {
    const note = await Notes.findById(req.params.id)
    if (!note) {
      return res.status(404).json({ message: 'Note not found' });
    }
    res.status(200).json(note);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching a note', error: error.message });
  }
}