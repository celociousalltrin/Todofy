import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cubit_page/counter.dart';
import 'package:flutter_application_1/pages/cubit_page/todo.dart';

class CubitPage extends StatefulWidget {
  const CubitPage({super.key});

  @override
  State<CubitPage> createState() => _CubitPageState();
}

class _CubitPageState extends State<CubitPage> {
  bool isToogle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubit Page"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Center(child: isToogle ? TodoPage() : CounterPage()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isToogle = !isToogle;
          });
        },
        child: const Icon(Icons.bubble_chart, size: 36),
        backgroundColor: Colors.amber[300],
      ),
    );
  }
}
