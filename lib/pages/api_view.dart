import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiViewPage extends StatefulWidget {
  final int id;
  const ApiViewPage({super.key, required this.id});

  @override
  State<ApiViewPage> createState() => _ApiViewPageState();
}

class _ApiViewPageState extends State<ApiViewPage> {
  final dio = Dio();
  Map todo = {};
  @override
  void initState() {
    super.initState();
    getTodo(widget.id);
  }

  void getTodo(int id) async {
    try {
      Response<dynamic> response =
          await dio.get("http://192.168.1.3:5000/todos/${widget.id}");
      setState(() {
        todo = response.data;
      });
    } catch (err) {
      print("ERROR is : $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api View page"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: todo.isEmpty
          ? const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      todo["title"],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(todo["description"],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                      ))
                ],
              ),
            ),
    );
  }
}
