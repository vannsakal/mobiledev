import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() async {
  // 1. Create the API URL for the user endpoint
  Uri url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');

  // 2. Send the HTTP GET request
  Response response = await http.get(url);

  // 3. Check that the status code is 200
  if (response.statusCode != 200) {
    throw Exception('Failed to fetch user (HTTP ${response.statusCode})');
  }

  Map<String, dynamic> jsonUserData = jsonDecode(response.body);

  User user = User.fromJson(jsonUserData);
  print(user);
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  static User fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int);
    assert(json['name'] is String);
    assert(json['username'] is String);
    assert(json['email'] is String);

    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return "User: ID=$id, Name=$name, Username=$username, Email=$email";
  }
}
