import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mindmap/Model/note.model.dart';

class RemoteServices {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://mind-map-manage-yourself.vercel.app/api',
    ),
  );

  

  static Future<List<Note>> fetchNotes() async {
    try {
      final response = await dio.get('/notes');
      print('📦 fetchNotes response: ${response.data}');
      return notesFromJson(jsonEncode(response.data));
    } catch (e) {
      print('❌ fetchNotes error: $e');
      throw Exception('❌ Failed to fetch notes');
    }
  }

  static Future<Note> fetchNoteById(String id) async {
    try {
      final response = await dio.get('/notes/$id');
      return noteFromJson(jsonEncode(response.data));
    } catch (e) {
      print("❌ fetchNoteById error: $e");
      throw Exception('❌ Failed to fetch note by ID');
    }
  }

  static Future<void> deleteNotes(String noteId) async {
    try {
      final response = await dio.delete('/notes/$noteId');
      if (response.statusCode != 200) {
        throw Exception('❌ Error deleting note: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ deleteNotes error: $e");
      throw Exception('❌ Failed to delete note');
    }
  }

  static Future<Note> editNote(String noteId, String title, String content, List<String> tags) async {
    try {
      final response = await dio.put(
        '/notes/$noteId',
        data: {
          "title": title,
          "content": content,
          "tags": tags,
        },
      );
      return noteFromJson(jsonEncode(response.data));
    } catch (e) {
      print("❌ editNote error: $e");
      throw Exception('❌ Failed to edit note');
    }
  }

  static Future<Note> createNote(String title, String content, List<String> tags) async {
    try {
      final response = await dio.post(
        '/notes/',
        data: {
          "title": title,
          "content": content,
          "tags": tags,
        },
      );
      return noteFromJson(jsonEncode(response.data));
    } catch (e) {
      print("❌ createNote error: $e");
      throw Exception('❌ Failed to create note');
    }
  }
}
