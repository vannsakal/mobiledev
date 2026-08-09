import 'package:flutter/material.dart';
import 'button_status.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  final ButtonRepository _repository = ButtonRepository();
  bool _isLoading = true;
  String? _errorMessage;
  ButtonStatus? _buttonStatus;

  @override
  void initState() {
    super.initState();
    _fetchButtonData();
  }

  void _fetchButtonData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final result = await _repository.getButtonStatus();
      setState(() {
        _buttonStatus = result;
        _isLoading = false;
      });
    } on RepositoryException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    }
  }

  void _toggleButtonSelection() async {
    if (_buttonStatus == null || _isLoading) return;

    final currentStatus = _buttonStatus!.selected;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _repository.updateButtonSelection(!currentStatus);

      _fetchButtonData();
    } on RepositoryException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EX 1 - Button"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchButtonData,
            tooltip: "Refresh database status",
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _errorMessage != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchButtonData,
                    child: const Text("Retry"),
                  ),
                ],
              )
            : SelectionButton(
                title: _buttonStatus?.name.toUpperCase() ?? "",
                isSelected: _buttonStatus?.selected ?? false,
                onTap: _toggleButtonSelection, 
              ),
      ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.lightBlue[300] : Colors.white,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: Colors.grey),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
