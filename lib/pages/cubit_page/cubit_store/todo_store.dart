// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:flutter_application_1/utils/common_function.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoModel {
  final int id;
  final String title;
  final bool is_completed;
  final bool is_deleted;

  TodoModel(
      {required this.title,
      required this.id,
      this.is_completed = false,
      this.is_deleted = false});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "is_completed": is_completed,
      "is_deleted": is_deleted
    };
  }
}

class TodoStore extends Cubit<List<TodoModel>> {
  TodoStore() : super([]);

  void addTodo(String input) {
    TodoModel data = TodoModel(title: input, id: Random().nextInt(1000));
    emit([...state, data]);
  }

  void deleteTodo(int id) {
    emit(updateList(data: state, id: id, key: "is_deleted", value: true));
  }

  void completeTodo(int id) {
    emit(updateList(data: state, id: id, key: "is_completed", value: true));
  }
}
