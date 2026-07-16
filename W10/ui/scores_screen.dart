import 'package:flutter/material.dart';

import '../data/repositories/scores_repository.dart';
import '../data/services/auth_service.dart';
import '../model/score.dart';
import 'theme.dart';

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
        return const Center(
          child: Text("No scores yet", style: TextStyle(color: Colors.white)),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.only(top: 4),
        itemCount: scores!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
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
    return const Center(child: CircularProgressIndicator(color: Colors.white));
  }

  String get welcomeLabel => "Welcome ${userName != null ? userName! : ""} !";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    welcomeLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app, color: Colors.white),
                    onPressed: onLogoutPressed,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Your scores",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreTile extends StatelessWidget {
  const ScoreTile({super.key, required this.score});

  final Score score;

  Color get scoreColor {
    if (score.value >= 70) return Colors.green;
    if (score.value >= 40) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            score.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "${score.value.toString().padLeft(2, '0')}/100",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: scoreColor,
            ),
          ),
        ],
      ),
    );
  }
}
