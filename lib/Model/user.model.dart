class AppUser {
  final String name;
  final String email;
  final String id;

  AppUser({required this.name, required this.email, required this.id});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      name: json['name'],
      email: json['email'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "_id": id,
  };
}
