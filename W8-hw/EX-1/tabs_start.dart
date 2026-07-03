import 'package:flutter/material.dart';

class RedScreen extends StatelessWidget {
  const RedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(child: Text("Red Screen")),
    );
  }
}

class GreenScreen extends StatelessWidget {
  const GreenScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(child: Text("Green Screen")),
    );
  }
}

class BlueScreen extends StatelessWidget {
  const BlueScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(child: Text("Blue Screen")),
    );
  }
}
enum AppTabs { red, green, blue }

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AppTabs _currentTab = AppTabs.red;

  Widget get content {
    switch (_currentTab) {
      case AppTabs.red:
        return const RedScreen();
      case AppTabs.blue:
        return const BlueScreen();
      case AppTabs.green:
        return const GreenScreen();
    }
  }

  void _onTabTap(AppTabs tab) {
    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tabs navigation")),
      body: content,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.red),
              onPressed: () => _onTabTap(AppTabs.red),
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.blue),
              onPressed: () => _onTabTap(AppTabs.blue),
            ),
            IconButton(
              icon: const Icon(Icons.home, color: Colors.green),
              onPressed: () => _onTabTap(AppTabs.green),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: App()));
}
