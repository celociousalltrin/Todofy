import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ApiTodoPage extends StatefulWidget {
  const ApiTodoPage({super.key});

  @override
  State<ApiTodoPage> createState() => _ApiTodoPageState();
}

class _ApiTodoPageState extends State<ApiTodoPage> {
  final dio = Dio();

  List<dynamic> myList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final response = await dio.get("http://192.168.1.3:5000/todos");

      setState(() {
        myList = response.data;
      });
    } catch (err) {
      print("ERROR is : $err");
    }
  }

  void toggleComplete(dynamic id, Map data) async {
    try {
      final response = await dio.put("http://192.168.1.3:5000/todos/$id",
          data: {...data, "is_completed": !data["is_completed"]});
      setState(() {
        myList = myList.map((item) {
          if (item["id"] == id) {
            return response.data;
          } else {
            return item;
          }
        }).toList();
      });
    } catch (err) {
      print("Error is :$err");
    }
  }

  String formatCustomDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API TODO Page",
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            AppButton(onPressed: () {}, btnName: "ADD API TODOD"),
            Expanded(
              child: ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> todo = myList[index];
                    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    // final String formatted = formatter.format(todo["created_at"]);
                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed("api-todo-id",
                              pathParameters: {"id": todo["id"]});
                        },
                        child: Container(
                            height: 82,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: todo["is_completed"]
                                    ? Colors.greenAccent
                                    : Colors.amber[300],
                                border: Border.all(
                                    width: 1.0, color: Colors.black)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todo["title"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        formatCustomDateTime(
                                            DateTime.parse(todo["created_at"])),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                toggleComplete(
                                                    todo["id"], todo);
                                              },
                                              child: Icon(
                                                todo["is_completed"]
                                                    ? Icons.check_circle
                                                    : Icons
                                                        .check_circle_outline_outlined,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print("Delete Icon is Pressed");
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              size: 28,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ])),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
