import 'package:flutter/material.dart';

import '../data/services/auth_service.dart';
import 'theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? errorMessage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidUsername(String value) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9_]{3,}$');
    return regex.hasMatch(value);
  }

  bool isValidPassword(String value) {
    final RegExp regex = RegExp(r'^\S{4,}$');
    return regex.hasMatch(value);
  }

  void onLoginPressed() async {
    // Wrap all the code with a try/catch on AuthException: if exception, disaplyer error with the exception
    try {
      // Get the name + password from controllers
      final String name = nameController.text.trim();
      final String password = passwordController.text;

      // Validate the name+password => if empty display error :  "Name and password shall be entered"
      if (name.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = "Name and password shall be entered";
        });
        return;
      }

      if (!isValidUsername(name)) {
        setState(() {
          errorMessage = "Username must be at least 3 letters/numbers, no spaces";
        });
        return;
      }

      if (!isValidPassword(password)) {
        setState(() {
          errorMessage = "Password must be at least 4 characters, no spaces";
        });
        return;
      }

      // Call AuthenticationService instance to login
      await AuthenticationService.instance.login(name: name, password: password);

      // Iff success, notify the parent (use the callback) and refresh the state
      widget.onLogin();
      setState(() {
        errorMessage = null;
      });
    } on AuthException catch (e) {
      // If failure disaply the error and refresh
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const SizedBox(height: 20),

            // Login image
            Image.asset("assets/auth/login.png", height: 250),

            const SizedBox(height: 40),

            // Username
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            // Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 30),

            // Login button
            GestureDetector(
              onTap: onLoginPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text("LOGIN", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),

            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
