import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_drawer.dart';

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
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          "This is About Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
