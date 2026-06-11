import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableButton(),
            SizedBox(height: 10),
            SelectableButton(),
            SizedBox(height: 10),
            SelectableButton(),
            SizedBox(height: 10),
            SelectableButton(),
          ],
        ),
      ),
    ),
  ),
);

class SelectableButton extends StatefulWidget {
  const SelectableButton({super.key});

  @override
  State<SelectableButton> createState() => _SelectableButtonState();
}

class _SelectableButtonState extends State<SelectableButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    String buttonText = "";
    Color textColor = Colors.black;
    Color backgroundColor = Colors.blue;

    if (isSelected == true) {
      buttonText = "Selected";
      textColor = Colors.white;
      backgroundColor = Colors.blue[500]!;
    } else {
      buttonText = "Not selected";
      textColor = Colors.black;
      backgroundColor = Colors.blue[50]!;
    }

    return SizedBox(
      width: 400,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
        ),
        onPressed: () {
          setState(() {
            if (isSelected == true) {
              isSelected = false;
            } else {
              isSelected = true;
            }
          });
        },
        child: Center(child: Text(buttonText)),
      ),
    );
  }
}
