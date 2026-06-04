import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, disabled }

enum IconPosition { left, right }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom buttons')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                label: 'Submit',
                icon: Icons.check,
                iconPosition: IconPosition.left,
                buttonType: ButtonType.primary,
              ),
              SizedBox(height: 12),
              CustomButton(
                label: 'Time',
                icon: Icons.access_time,
                iconPosition: IconPosition.right,
                buttonType: ButtonType.secondary,
              ),
              SizedBox(height: 12),
              CustomButton(
                label: 'Account',
                icon: Icons.supervisor_account,
                iconPosition: IconPosition.right,
                buttonType: ButtonType.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconPosition iconPosition;
  final ButtonType buttonType;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    this.iconPosition = IconPosition.left,
    this.buttonType = ButtonType.primary,
  });

  Color _getBackgroundColor() {
    switch (buttonType) {
      case ButtonType.primary:
        return Colors.blue;
      case ButtonType.secondary:
        return Colors.green;
      case ButtonType.disabled:
        return Colors.grey.shade300;
    }
  }

  Color _getContentColor() {
    return buttonType == ButtonType.disabled ? Colors.grey : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final contentColor = _getContentColor();

    final List<Widget> rowChildren = [
      Icon(icon, color: contentColor, size: 18),
      const SizedBox(width: 8),
      Text(label, style: TextStyle(color: contentColor, fontSize: 16)),
    ];

    if (iconPosition == IconPosition.right) {
      rowChildren.clear();
      rowChildren.addAll([
        Text(label, style: TextStyle(color: contentColor, fontSize: 16)),
        const SizedBox(width: 8),
        Icon(icon, color: contentColor, size: 18),
      ]);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      ),
    );
  }
}
