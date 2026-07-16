import 'package:flutter/material.dart';

import '../data/services/auth_service.dart';
import 'auth_screen.dart';
import 'scores_screen.dart';

enum AuthenticationState { authenticated, unauthenticated }

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  AuthenticationState authState = AuthenticationState.unauthenticated;

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final bool restored = await AuthenticationService.instance.restoreSession();
    if (restored) {
      setState(() {
        authState = AuthenticationState.authenticated;
      });
    }
  }

  void onLogin() {
    setState(() {
      authState = AuthenticationState.authenticated;
    });
  }

  void onLogout() {
    setState(() {
      authState = AuthenticationState.unauthenticated;
    });
  }

  Widget get content {
    // if logged in -> Display ScoresScreen
    if (authState == AuthenticationState.authenticated &&
        AuthenticationService.instance.isLoggedIn) {
      return ScoresScreen(onLogout: onLogout);
    }

    // otherwise -> DisplayAuthScreen
    return AuthScreen(onLogin: onLogin);
  }

  @override
  Widget build(BuildContext context) {
    return content;
  }
}
