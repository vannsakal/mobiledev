import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 100),
            Container(height: 400, color: const Color(0xFF1A5276)),
            Row(
              children: [
                Expanded(child: Container(height: 100, color: Colors.green)),
                Container(width: 100, height: 100, color: Colors.pink),
              ],
            ),
            Container(
              height: 100,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(height: 100, color: Colors.blue)),
                  const SizedBox(width: 20),
                  Expanded(child: Container(height: 100, color: Colors.blue)),
                  const SizedBox(width: 20),
                  Expanded(child: Container(height: 100, color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: Container(color: Colors.pink)),
          ],
        ),
      ),
    ),
  );
}
