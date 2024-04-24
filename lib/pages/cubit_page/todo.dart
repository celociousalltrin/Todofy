import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/list_container.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/todo_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<int> todoIds = [];
  @override
  Widget build(BuildContext context) {
    final todoState = TodoStore();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TODO LIST",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                AppButton(
                  onPressed: () {
                    print("Add TODO Button is CLicked");
                  },
                  btnName: "ADD TODO",
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoStore, List<TodoModel>>(
                bloc: todoState,
                builder: (context, todos) {
                  return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        TodoModel todo = todos[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: todos[index].is_completed
                                  ? Colors.lightGreen[500]
                                  : Colors.amber[200],
                              border:
                                  Border.all(width: 1.0, color: Colors.black)),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todo.title,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print("The Is Completed is Clicked");
                                        },
                                        child: Icon(
                                          todos[index].is_completed
                                              ? Icons.check_circle
                                              : Icons
                                                  .check_circle_outline_outlined,
                                          size: 28.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: () {
                                          print("Delete Button is Clicked");
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          size: 26.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: todo.description.length > 80
                                          ? "${todo.description.substring(0, 80)}..."
                                          : todo.description,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    if (todo.description.length > 80)
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: GestureDetector(
                                          onTap: () {
                                            print(todo.toMap());
                                            setState(() {
                                              if (todoIds.contains(todo.id)) {
                                                todoIds = todoIds
                                                    .where(
                                                        (id) => id != todo.id)
                                                    .toList();
                                              } else {
                                                todoIds.add(todo.id);
                                              }
                                            });
                                            print(todoIds);
                                          },
                                          child: Icon(
                                            todoIds.contains(todo.id)
                                                ? Icons.arrow_upward
                                                : Icons.arrow_downward,
                                            size: 22,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
