// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:flutter_application_1/utils/common_function.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoModel {
  final int id;
  final String title;
  final String description;
  final bool is_completed;
  final bool is_deleted;

  TodoModel(
      {required this.title,
      required this.description,
      required this.id,
      this.is_completed = false,
      this.is_deleted = false});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "is_completed": is_completed,
      "is_deleted": is_deleted
    };
  }
}

class TodoStore extends Cubit<List<TodoModel>> {
  TodoStore() : super([]);

  void addTodo(Map<String, String> input) {
    TodoModel data = TodoModel(
        title: input["title"]!,
        description: input["description"]!,
        id: Random().nextInt(1000));
    emit([...state, data]);
  }

  void deleteTodo(int id) {
    emit(updateList(data: state, id: id, todo: {"is_deleted": true}));
  }

  void completeTodo(int id) {
    emit(updateList(data: state, id: id, todo: {"is_completed": true}));
  }

  void updateTodo({required int id, required Map<String, String> data}) {
    emit(updateList(data: state, id: id, todo: data));
  }
}
