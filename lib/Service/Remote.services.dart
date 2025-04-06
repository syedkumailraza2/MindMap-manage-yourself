import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mindmap/Model/note.model.dart';

class RemoteServices {
  static var client = http.Client();
  static String baseURL = 'https://notes-app-nu-lime.vercel.app/api';

 static Future<List<Note>> fetchNotes() async {
  var response = await client.get(
    Uri.parse('$baseURL/notes'),
  );
  if (response.statusCode != 200) {
    throw Exception(
        'Error while fetching Data: ' + response.statusCode.toString());
  }
  var jsonData = response.body;
  print("API RESPONSE: ${notesFromJson(jsonData)}");
  return notesFromJson(jsonData);
}

static Future<Note> fetchNoteById(String id) async {
  final response = await http.get(Uri.parse('$baseURL/notes/$id'));

  if (response.statusCode == 200) {
    return noteFromJson(response.body); // Adjust this based on your model
  } else {
    throw Exception('Failed to load note');
  }
}

  static Future<List<Note>?>? deleteNotes(noteId) async {
    var response = await client.delete(
      Uri.parse('$baseURL/notes/${noteId}'),
    );
    if (response.statusCode != 200) {
      throw Exception(
          'Error while fetching Deleting: ' + response.statusCode.toString());
    }
    return null;
  }

 static Future<Note> editNote(String noteId, String title, String content, List<String> tags) async {
    var response = await client.put(
      Uri.parse('$baseURL/notes/$noteId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "content": content,
        "tags": tags,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error while updating note: ${response.statusCode}');
    }
    
    
    return noteFromJson(response.body);
  }

static Future<Note> createNote(String title, String content, List<String> tags) async {
    var response = await client.post(
      Uri.parse('$baseURL/notes/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "content": content,
        "tags": tags,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error while Adding note: ${response.statusCode}');
    }

    
    return noteFromJson(response.body);
  }
}