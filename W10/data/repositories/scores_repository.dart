import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/score.dart';

class ScoresRepository {
  static ScoresRepository instance = ScoresRepository();

  Future<List<Score>> getScores(String accessToken) async {
    final Uri baseUri = Uri.parse("http://localhost:3000");
    final Uri scoresUri = baseUri.replace(path: "/scores");

    // Fetch the GET /scores with the token included in the headers
    final http.Response response = await http.get(
      scoresUri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    //  If statusCode 200, decode the json body
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Convert the json to the lost of scores
      final List<Score> scores =
          jsonList.map((e) => Score.fromJSon(e)).toList();

      // Ifd success Return the scores
      return scores;
    }

    // If no success throw exception
    throw Exception("Failed to fetch scores (status ${response.statusCode})");
  }
}
