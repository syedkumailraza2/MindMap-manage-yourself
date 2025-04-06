import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mindmap/Controller/notes.controller.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.put(NoteController());
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final TextEditingController tagsController = TextEditingController();

    return Scaffold(
       backgroundColor: Color(0xFFE8DDCB),
      appBar: AppBar(
        backgroundColor: Color(0xFFE8DDCB),
        title: Text(
          'Create Note',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              backgroundColor: Color(0xFF907257), // Background color
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
              noteController.addNote( title, content, tags);
          
              Get.back(); // Navigate back after editing
              // Show success Snackbar
              Get.snackbar(
                'Success',
                'Note added successfully!',
                snackPosition: SnackPosition.BOTTOM,
              );
          
            
              } catch (e) {
                Get.snackbar(
                'Error',
                'Failed to add note: ${e.toString()}',
                snackPosition: SnackPosition.BOTTOM,
              );
              }
              
            },
            child: Text('Add Note'),
          ),
          
              ),
            ],
          ),
        ),
      ),
    );
  }
}