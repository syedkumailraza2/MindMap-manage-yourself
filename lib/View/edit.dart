import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindmap/Controller/notes.controller.dart';
import 'package:mindmap/Theme/theme.dart';

class EditPage extends StatelessWidget {
  final String noteId;
  final String initialTitle;
  final String initialContent;
  final List<String> initialTags;

  const EditPage({
    super.key,
    required this.noteId,
    required this.initialTitle,
    required this.initialContent,
    required this.initialTags,
  });

  @override
  Widget build(BuildContext context) {
    final NoteController noteController = Get.find();

    final TextEditingController titleController = TextEditingController(text: initialTitle);
    final TextEditingController contentController = TextEditingController(text: initialContent);
    final TextEditingController tagsController = TextEditingController(text: initialTags.join(', '));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Edit Note',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter note title',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Content',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter note content',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tags (comma separated)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: tagsController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter tags',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary, // Background color
    foregroundColor: Colors.white, // Text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Set your desired border radius here
    ),
  ),
  onPressed: () {
    try {
      // Get the values from the controllers
    String title = titleController.text;
    String content = contentController.text;
    List<String> tags = tagsController.text.split(',').map((tag) => tag.trim()).toList();

    // Call the editNote method from the controller
    noteController.editNote(noteId, title, content, tags);

    Get.back(); // Navigate back after editing
    // Show success Snackbar
    Get.snackbar(
      'Success',
      'Note edited successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );

  
    } catch (e) {
      Get.snackbar(
      'Error',
      'Failed to edit note: ${e.toString()}',
      snackPosition: SnackPosition.BOTTOM,
    );
    }
    
  },
  child: Text('Save Changes'),
),

            ),
          ],
        ),
      ),
    );
  }
}
