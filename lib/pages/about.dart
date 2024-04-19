import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Page"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "This is About Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
