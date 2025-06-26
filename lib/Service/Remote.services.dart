import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindmap/Model/note.model.dart';
import 'package:mindmap/Model/user.model.dart';

class RemoteServices {
  static final GetStorage storage = GetStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final Dio dio = Dio(
    // BaseOptions(baseUrl: 'https://mindmap-manage-yourself.onrender.com'),
    BaseOptions(baseUrl: 'http://10.0.2.2:4000')
  );

  static Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/user/register',
        data: {"name": name, "email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Optional: save to GetStorage if needed
        storage.write('user', response.data['user']);
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Register error: $e');
      return false;
    }
  }

  // Login
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/user/login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userJson = response.data['user'];
        final user = AppUser.fromJson(userJson);

        // Save user to GetStorage
        storage.write('user', user.toJson());

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  // Read stored user (optional)
  static AppUser? getStoredUser() {
    final userData = storage.read('user');
    if (userData != null) {
      return AppUser.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  static Future<List<Note>> fetchNotes() async {
    try {
      final user = storage.read('user');
      final userId = user['_id'];
      print('User: $userId');
      final response = await dio.get('/notes/$userId');
      print('📦 fetchNotes response: ${response.data}');
      return notesFromJson(jsonEncode(response.data));
    } catch (e) {
      print('❌ fetchNotes error: $e');
      throw Exception('❌ Failed to fetch notes');
    }
  }

  static Future<UserCredential?> signinGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null; // user canceled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final newUser = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final response = await dio.post(
        '/user/signinwithgoogle',
        data: {"email": newUser.user!.email, "name": newUser.user!.displayName},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userJson = response.data['user'];
        final user = AppUser.fromJson(userJson);

        // Save user to GetStorage
        storage.write('user', user.toJson());

        return newUser;
      }
    } catch (e) {
      print('❌ Google Sign-In Error: $e');
      return null;
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

  static Future<Note> editNote(
    String noteId,
    String title,
    String content,
    List<String> tags,
  ) async {
    try {
      final response = await dio.put(
        '/notes/$noteId',
        data: {"title": title, "content": content, "tags": tags},
      );
      return noteFromJson(jsonEncode(response.data));
    } catch (e) {
      print("❌ editNote error: $e");
      throw Exception('❌ Failed to edit note');
    }
  }

  static Future<Note> createNote(
    String title,
    String content,
    List<String> tags,
  ) async {
    try {
      final user = storage.read('user');
      final userId = user['_id'];
      print('User: $userId');
      final response = await dio.post(
        '/notes/',
        data: {"title": title, "content": content, "tags": tags, "userId": userId},
      );
      return noteFromJson(jsonEncode(response.data));
    } catch (e) {
      print("❌ createNote error: $e");
      throw Exception('❌ Failed to create note');
    }
  }
}
