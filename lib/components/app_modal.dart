import 'package:flutter/material.dart';

class AppModel extends StatelessWidget {
  const AppModel({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade100,
      content: Container(
        height: 111,
      ),
    );
  }
}
