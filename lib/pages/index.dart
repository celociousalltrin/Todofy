import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_drawer.dart';

class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key});

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main App Bar"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
    );
  }
}
