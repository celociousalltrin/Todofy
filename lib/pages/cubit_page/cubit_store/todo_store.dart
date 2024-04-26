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

class CubitTododModel {
  List<TodoModel> todoList;
  List<int> todoIds;

  CubitTododModel({required this.todoList, required this.todoIds});
}

class TodoStore extends Cubit<CubitTododModel> {
  TodoStore()
      : super(CubitTododModel(
          todoList: [
            TodoModel(
              title: "First Task",
              description: "Test Description",
              id: Random().nextInt(1000),
            ),
            TodoModel(
              title: "Second Task",
              is_completed: true,
              description:
                  "You can wrap your existing Padding widget with another Padding widget to add margins around the existing widget. Here's how you can do it:",
              id: Random().nextInt(1000),
            ),
          ],
          todoIds: [],
        ));

  void addTodo(Map<String, String> input) {
    TodoModel data = TodoModel(
        title: input["title"]!,
        description: input["description"]!,
        id: Random().nextInt(1000));

    emit(CubitTododModel(
      todoList: [...state.todoList, data],
      todoIds: state.todoIds,
    ));
  }

  void deleteTodo(int id) {
    emit(CubitTododModel(
        todoList: updateList(
            data: state.todoList, id: id, todo: {"is_deleted": true}),
        todoIds: state.todoIds));
  }

  void toggleCompleteTodo(int id, bool value) {
    emit(CubitTododModel(
        todoList: updateList(
            data: state.todoList, id: id, todo: {"is_completed": !value}),
        todoIds: state.todoIds));
  }

  void updateTodo({required int id, required Map<String, String> data}) {
    emit(CubitTododModel(
        todoList: updateList(data: state.todoList, id: id, todo: data),
        todoIds: state.todoIds));
  }

  void viewDescription(int id) {
    if (state.todoIds.contains(id)) {
      emit(CubitTododModel(
          todoList: state.todoList,
          todoIds: state.todoIds.where((element) => element != id).toList()));
    } else {
      emit(CubitTododModel(
          todoList: state.todoList, todoIds: [...state.todoIds, id]));
    }
  }
}
