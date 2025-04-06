import 'dart:convert';

// Function to parse a list of notes from JSON
List<Note> notesFromJson(String str) {
  final jsonData = json.decode(str) as List<dynamic>; // Ensure the response is a List
  return List<Note>.from(jsonData.map((noteJson) => Note.fromJson(noteJson))); // Map each item to a Note
}

// Function to parse a single note from JSON
Note noteFromJson(String str) {
  final jsonData = json.decode(str) as Map<String, dynamic>; // Ensure the response is a Map
  return Note.fromJson(jsonData); // Return the Note object
}

String noteToJson(List<Note> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
    String? id;
    String? title;
    String? content;
    List<String>? tags;

    Note({
        this.id,
        this.title,
        this.content,
        this.tags,
    });

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        tags: json["tags"] != null 
            ? List<String>.from(json["tags"].map((x) => x)) 
            : null,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "tags": tags != null 
            ? List<dynamic>.from(tags!.map((x) => x)) 
            : null,
    };
}
