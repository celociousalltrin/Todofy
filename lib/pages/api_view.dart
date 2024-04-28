import 'package:flutter/material.dart';

class ApiViewPage extends StatefulWidget {
  final int id;
  const ApiViewPage({super.key, required this.id});

  @override
  State<ApiViewPage> createState() => _ApiViewPageState();
}

class _ApiViewPageState extends State<ApiViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api View page"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Center(
        child: Text("This is Single AppBar ${widget.id}",
            style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
