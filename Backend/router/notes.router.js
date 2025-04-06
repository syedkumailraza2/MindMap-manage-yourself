import express from 'express';
import {
  createNote,
  getAllNotes,
  updateNote,
  deleteNote,
  getNote,
} from '../Controller/notes.controller.js';

const router = express.Router();

router.post('/', createNote);          // Create a new note
router.get('/', getAllNotes);          // Get all notes
router.put('/:id', updateNote);       // Update a note
router.delete('/:id', deleteNote);    // Delete a note
router.get('/:id',getNote)

export default router;
