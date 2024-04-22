import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/list_container.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/todo_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoState = TodoStore();
    return Scaffold(
      body: BlocBuilder<TodoStore, List<TodoModel>>(
          bloc: todoState,
          builder: (context, todos) {
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.amber[200],
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "ASdasdsadasd",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                });
          }),
    );
  }
}
