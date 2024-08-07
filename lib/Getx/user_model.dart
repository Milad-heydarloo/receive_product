import 'dart:convert';

class User {
  String id;
  String username;
  String password;
  bool verified;
  String email;
  String name;
  String avatar;
  String family;
  List<String> availability;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.verified,
    required this.email,
    required this.name,
    required this.avatar,
    required this.family,
    required this.availability,
  });

  // تبدیل نقشه به مدل User
  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'] ?? '',
    username: map['username'] ?? '',
    password: map['password'] ?? '',
    verified: map['verified'] == 1,
    email: map['email'] ?? '',
    name: map['name'] ?? '',
    avatar: map['avatar'] ?? '',
    family: map['family'] ?? '',
    availability: List<String>.from(jsonDecode(map['availability'] ?? '[]')),
  );

  // تبدیل مدل User به نقشه
  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'password': password,
    'verified': verified ? 1 : 0,
    'email': email,
    'name': name,
    'avatar': avatar,
    'family': family,
    'availability': jsonEncode(availability),
  };

  // تبدیل مدل User به JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password,
    'verified': verified,
    'email': email,
    'name': name,
    'avatar': avatar,
    'family': family,
    'availability': availability,
  };

  @override
  String toString() => jsonEncode(toJson());
}
