// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter_application_1/service/methods.dart';
import 'package:flutter_application_1/utils/common_function.dart';
import 'package:flutter_application_1/utils/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Map<String, dynamic>> inputPropsData = [
  {
    "id": "1",
    "name": "title",
    "validation": (String value) => value.titleValidation,
    "obscureText": false
  },
  {
    "id": "2",
    "name": "description",
    "validation": (String value) => value.descriptionvalidation,
    "obscureText": false,
    "isMultiLineText": true,
  }
];

Map init = {
  "title": "",
  "description": "",
  "created_at": DateTime.now().toString(),
  "is_completed": false,
  "is_deleted": false
};

class SingleTodoModel {
  final dynamic id;
  final String title;
  final String description;
  final String created_at;
  final bool is_deleted;
  final bool is_completed;

  SingleTodoModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.created_at,
      required this.is_completed,
      required this.is_deleted});

  Map toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "created_at": created_at,
      "is_completed": is_completed,
      "is_deleted": is_deleted
    };
  }
}

class ApiTodoModel {
  List<SingleTodoModel> todoList;
  SingleTodoModel? todo;
  bool isTriggerValidate;
  List<Map> inputPropsData;
  Map init;

  ApiTodoModel({
    required this.todoList,
    this.todo,
    this.isTriggerValidate = false,
    required this.inputPropsData,
    required this.init,
  });
}

class ApiTodoStore extends Cubit<ApiTodoModel> {
  ApiTodoStore()
      : super(ApiTodoModel(
            todoList: [], inputPropsData: inputPropsData, init: init));

  void getTodoList() async {
    try {
      final response = await getTodos();
      final todoList = (response.data as List)
          .map((item) => SingleTodoModel(
                id: item['id'],
                title: item['title'],
                description: item['description'],
                created_at: item['created_at'],
                is_completed: item['is_completed'],
                is_deleted: item['is_deleted'],
              ))
          .toList();

      emit(ApiTodoModel(
          todoList: todoList, inputPropsData: inputPropsData, init: init));
    } catch (err) {
      print("ERROR is : $err");
    }
  }

  void addApiTodo() async {
    try {
      final res = await createTodo(state.init);
      final response = res.data;
      emit(ApiTodoModel(todoList: [
        SingleTodoModel(
            id: response["id"],
            title: response["title"],
            description: response["description"],
            created_at: response["created_at"],
            is_completed: response["is_completed"],
            is_deleted: response["is_deleted"]),
        ...state.todoList
      ], inputPropsData: inputPropsData, init: init));
    } catch (err) {
      print("ERROR is $err");
    }
  }

  void completeTodo(dynamic id, SingleTodoModel data) async {
    try {
      final response = await toggleCompleteTodo(
          id, {...data.toMap(), "is_completed": !data.is_completed});

      emit(ApiTodoModel(
          todoList: updateApiTodoList(
              data: state.todoList,
              id: id,
              todo: {"is_completed": response.data["is_completed"]}),
          inputPropsData: inputPropsData,
          init: init));
    } catch (err) {
      print("ERROR is : $err");
    }
  }

  void getTodo(dynamic id) async {
    try {
      final response = await getSingleTodo(id);
      SingleTodoModel todo = response.data;
      emit(ApiTodoModel(
          todoList: state.todoList,
          todo: SingleTodoModel(
              id: todo.id,
              title: todo.title,
              description: todo.description,
              created_at: todo.created_at,
              is_completed: todo.is_completed,
              is_deleted: todo.is_deleted),
          inputPropsData: inputPropsData,
          init: init));
    } catch (err) {
      print("ERROR is :$err");
    }
  }

  void deleteTodo(dynamic id) {
    emit(ApiTodoModel(
        todoList: state.todoList.where((item) => item.id != id).toList(),
        inputPropsData: inputPropsData,
        init: init));
  }

  void triggervalidate(bool value) {
    emit(ApiTodoModel(
        todoList: state.todoList,
        inputPropsData: inputPropsData,
        init: init,
        isTriggerValidate: value));
  }

  void hanldeSave(
    String? value,
    String key,
  ) {
    emit(ApiTodoModel(
        todoList: state.todoList,
        inputPropsData: inputPropsData,
        init: {...state.init, key: value}));
  }
}
