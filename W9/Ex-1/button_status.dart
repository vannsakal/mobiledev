import 'dart:convert';
import 'package:http/http.dart' as http;

class ButtonStatus {
  final String name;
  final bool selected;

  ButtonStatus({required this.name, required this.selected});

  static ButtonStatus fromJson(Map<String, dynamic> json) {
    return ButtonStatus(
      name: json['name'] as String? ?? 'Unknown',
      selected: json['selected'] as bool? ?? false,
    );
  }
}

class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);
}

class ButtonRepository {
  final String _firebaseUrl =
      'https://button-4eb1b-default-rtdb.asia-southeast1.firebasedatabase.app/.json';

  Future<ButtonStatus> getButtonStatus() async {
    try {
      final response = await http.get(Uri.parse(_firebaseUrl));

      if (response.statusCode != 200) {
        throw RepositoryException("Server error: ${response.statusCode}");
      }

      if (response.body == 'null' || response.body.isEmpty) {
        throw RepositoryException("Database is empty!");
      }

      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      return ButtonStatus.fromJson(data);
    } catch (e) {
      throw RepositoryException(
        "No internet connection or invalid data structure.",
      );
    }
  }

  Future<void> updateButtonSelection(bool newSelectionState) async {
    try {
      final response = await http.patch(
        Uri.parse(_firebaseUrl),
        body: jsonEncode({'selected': newSelectionState}),
      );

      if (response.statusCode != 200) {
        throw RepositoryException(
          "Failed to update status: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw RepositoryException(
        "Could not update status. Check your connection.",
      );
    }
  }
}
