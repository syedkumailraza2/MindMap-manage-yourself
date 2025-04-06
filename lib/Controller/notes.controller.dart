import 'package:get/get.dart';
import 'package:mindmap/Model/note.model.dart';
import 'package:mindmap/Service/Remote.services.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;  // Changed variable name to lowercase for consistency
  var isLoading = true.obs;
  Rx<Note?> selectedNote = Rx<Note?>(null);

  @override
  void onInit() {
    fetchNotes();
    super.onInit();
  }

  Future<void> fetchNotes() async {
    isLoading(true);
    try {
      var fetchedNotes = await RemoteServices.fetchNotes();
      notes.value = fetchedNotes;
      print("Note Array: ${notes}");
    } finally {
      isLoading(false);
    }
  }

Future<void> fetchNoteById(String id) async {
  isLoading(true);
  try {
    Note note = await RemoteServices.fetchNoteById(id);
    selectedNote.value = note;
  } catch (e) {
    print("Error fetching note: $e");
  } finally {
    isLoading(false);
  }
}

  // Method to edit a note
  Future<void> editNote(String noteId, String title, String content, List<String> tags) async {
    isLoading(true);
    try {
      // Call the service method to update the note
      var updatedNote = await RemoteServices.editNote(noteId, title, content, tags);
      
      // Find the index of the note being updated
      final index = notes.indexWhere((note) => note.id == noteId); // Assuming note.id is the identifier

      if (index != -1) {
        // Update the existing note in the list
        notes[index] = notes.last;
      }
    } catch (e) {
      // Handle errors here (e.g., show a message to the user)
      print('Error updating note: $e');
    } finally {
      isLoading(false);
    }
  }

    void deleteNote(String noteId) async {
    try {
      await RemoteServices.deleteNotes(noteId); // Call the delete method in RemoteServices
      notes.removeWhere((note) => note.id == noteId); // Remove the note from the local list
      Get.snackbar('Success', 'Note deleted successfully', // Show a success message
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print("Error deleting note: $e"); // Handle error appropriately
      Get.snackbar('Error', 'Failed to delete note', // Show an error message
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addNote(String title, String content, List<String> tags) async {
    try {
      isLoading(true);
      Note newNote = Note(
        id: '', // Assuming the server generates this ID
        title: title,
        content: content,
        tags: tags,
      );

      // Call remote service to add note
      Note addedNote = await RemoteServices.createNote(title, content, tags);
      notes.add(addedNote); // Update local notes list
    } catch (e) {
      throw Exception('Error adding note: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

}
