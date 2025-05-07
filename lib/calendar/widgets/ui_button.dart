import 'package:flutter/material.dart';

class UiButton extends StatelessWidget {
  const UiButton({super.key, required this.text, required this.function});
  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              textStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          onPressed: function,
          child: Text(text)),
    );
  }
}
