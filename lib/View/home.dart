import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mindmap/Controller/notes.controller.dart';
import 'package:mindmap/View/create.dart';
import 'package:mindmap/View/read.dart';

class Home extends StatelessWidget {
  NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreatePage());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF907257),
      ),
      backgroundColor: Color(0xFFE8DDCB),
      appBar: AppBar(
        backgroundColor: Color(0xFFE8DDCB),
        title: Text(
          'MindMap',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(child: Obx(() {
          if (noteController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if(noteController.notes.isEmpty){
            return Center(child: Text('No notes yet.', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),));
          }
          return RefreshIndicator(
            onRefresh: () async {
              await noteController.fetchNotes();
            },
            child: ListView.builder(
                itemCount: noteController.notes.length,
                itemBuilder: ((context, index) {
                  final note = noteController.notes[index];
                  final tags = note.tags ?? [];
                  return noteWidget(
                    note.id,
                    note.title ?? 'Untitled',
                    note.content ?? 'No content',
                    tags.isNotEmpty ? tags[0] : 'No tag',
                    tags.length > 1 ? tags[1] : '',
                  );
                })),
          );
        }))
      ]),
    );
  }
}

Widget noteWidget(noteId, String noteTitle, noteContent, noteTag1, noteTag2) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(ReadPage(
              noteId: noteId,
              noteTitle: noteTitle,
              noteContent: noteContent,
              tag1: noteTag1,
              tag2: noteTag2,
            ));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE8DDCB),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noteTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    noteContent,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF907257),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          noteTag1,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF907257),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          noteTag2,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
