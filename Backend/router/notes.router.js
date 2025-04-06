import express from 'express';
import {
  createNote,
  getAllNotes,
  updateNote,
  deleteNote,
  getNote,
} from '../Controller/notes.controller.js';

const router = express.Router();

router.post('/notes', createNote);          // Create a new note
router.get('/notes', getAllNotes);          // Get all notes
router.put('/notes/:id', updateNote);       // Update a note
router.delete('/notes/:id', deleteNote);    // Delete a note
router.get('/notes/:id',getNote)

export default router;
