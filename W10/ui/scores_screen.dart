import 'package:flutter/material.dart';

import '../data/repositories/scores_repository.dart';
import '../data/services/auth_service.dart';
import '../model/score.dart';

class ScoresScreen extends StatefulWidget {
  const ScoresScreen({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  List<Score>? scores;
  String? error;

  @override
  void initState() {
    super.initState();

    fetchSCores();
  }

  void fetchSCores() async {
    final session = AuthenticationService.instance.session;
    if (session == null) {
      setState(() {
        error = "Not authenticated";
      });
      return;
    }

    try {
      // Ask the ScoresRepository instance to fetch the scores
      final result = await ScoresRepository.instance.getScores(session.token);

      // if succes, update the scores list and refresh
      setState(() {
        scores = result;
        error = null;
      });
    } catch (e) {
      // If failure, update the error and refresh
      setState(() {
        error = "Failed to load scores";
      });
    }
  }

  void onLogoutPressed() async {
    await AuthenticationService.instance.logout();
    widget.onLogout();
  }

  String? get userName {
    // Ask the AuthenticationService instance the current user nale (if any)
    return AuthenticationService.instance.session?.user.name;
  }

  Widget get content {
    // If scores list => dispaly the list using the ScoreTile
    if (scores != null) {
      if (scores!.isEmpty) {
        return const Center(child: Text("No scores yet"));
      }
      return ListView.builder(
        itemCount: scores!.length,
        itemBuilder: (context, index) => ScoreTile(score: scores![index]),
      );
    }

    // if error, dispaly the erro in red, centered
    if (error != null) {
      return Center(
        child: Text(
          error!,
          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
        ),
      );
    }

    // otherwise, we disaply the  CircularProgressIndicator
    return const Center(child: CircularProgressIndicator());
  }

  String get welcomeLabel => "Welcome ${userName != null ? userName! : ""} !";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(welcomeLabel),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogoutPressed,
          ),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(20.0), child: content),
    );
  }
}

class ScoreTile extends StatelessWidget {
  const ScoreTile({super.key, required this.score});

  final Score score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(score.title),
        trailing: Text(
          "${score.value}/100",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
