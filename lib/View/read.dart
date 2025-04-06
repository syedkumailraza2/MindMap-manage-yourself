import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mindmap/Controller/notes.controller.dart';
import 'package:mindmap/View/edit.dart';
import 'package:mindmap/View/home.dart';

class ReadPage extends StatelessWidget {
NoteController noteController = Get.put(NoteController());

  final noteId;
  final String noteTitle;
  final String noteContent;
  final String tag1;
  final String tag2;

  ReadPage({
    super.key,
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.tag1,
    required this.tag2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8DDCB),
      appBar: AppBar(
        backgroundColor: Color(0xFFE8DDCB),
        title: Text(
          noteTitle,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
  icon: Icon(Icons.delete),
  onPressed: () {
    // Show confirmation dialog
    Get.defaultDialog(
      title: "Confirm Deletion",
      content: Text("Are you sure you want to delete this note?"),
      confirm: TextButton(
        onPressed: () {
          // Call the delete function when the user confirms
          noteController.deleteNote(noteId);
          Get.offAll(Home()); // Close the dialog
        },
        child: Text("Delete", style: TextStyle(color: Colors.red)),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(); // Close the dialog without doing anything
        },
        child: Text("Cancel"),
      ),
    );
  },
),

          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.to(EditPage(noteId: noteId, initialTitle: noteTitle, initialContent: noteContent, initialTags: [tag1, tag2]));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
  onRefresh: () async {
    await noteController.fetchNoteById(noteId); // Add this method in your controller
  },
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noteContent,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
  ),
),

    );
  }
}
