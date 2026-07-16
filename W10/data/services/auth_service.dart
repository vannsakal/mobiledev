import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/auth_session.dart';
import '../../model/user.dart';

class AuthenticationService {
  static AuthenticationService instance = AuthenticationService();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _tokenStorageKey = "auth_token";

  AuthSession? session;

  bool get isLoggedIn => session != null && !session!.isExpired;

  Future<void> login({required String name, required String password}) async {
    final Uri baseUri = Uri.parse("http://localhost:3000");
    final Uri loginUrl = baseUri.replace(path: "login");

    // 1- Create the JSON body with the name and password
    final String body = jsonEncode({"name": name, "password": password});

    // 2- Fetch the POST/login
    final http.Response response = await http.post(
      loginUrl,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    // 3- Decode the json
    final Map<String, dynamic> json = jsonDecode(response.body);

    // 4 - If failed, throw a AuthException
    if (response.statusCode != 200) {
      throw AuthException(json["error"] ?? "Login failed");
    }

    // 5 -  Get the token
    final String token = json["token"];
    // 5 -  Get the user
    final Map<String, dynamic> userJson = json["user"];

    final DateTime expiresAt = JwtDecoder.getExpirationDate(token);
    final User user = User(
      id: userJson["id"],
      name: userJson["name"],
      role: UserRole.values.firstWhere((e) => e.name == userJson["role"]),
      expiresAt: expiresAt,
    );

    // 6 - Update the session
    session = AuthSession(token: token, user: user);

    await _storage.write(key: _tokenStorageKey, value: token);
  }

  Future<void> logout() async {
    session = null;
    await _storage.delete(key: _tokenStorageKey);
  }

  Future<bool> restoreSession() async {
    final String? token = await _storage.read(key: _tokenStorageKey);
    if (token == null) return false;

    if (JwtDecoder.isExpired(token)) {
      await _storage.delete(key: _tokenStorageKey);
      return false;
    }

    final Map<String, dynamic> decoded = JwtDecoder.decode(token);
    final User user = User(
      id: decoded["userId"],
      name: decoded["name"],
      role: UserRole.values.firstWhere((e) => e.name == decoded["role"]),
      expiresAt: JwtDecoder.getExpirationDate(token),
    );

    session = AuthSession(token: token, user: user);
    return true;
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
  @override
  String toString() {
    return message;
  }
}
