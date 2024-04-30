import 'package:flutter_application_1/pages/api_store.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/todo_store.dart';

List<TodoModel> updateList({
  required List<TodoModel> data,
  required int id,
  required Map<String, dynamic> todo,
}) {
  return data.map((item) {
    if (item.id == id) {
      return TodoModel(
        id: item.id,
        title: todo["title"] ?? item.title,
        description: todo["description"] ?? item.description,
        is_completed: todo["is_completed"] ?? item.is_completed,
        is_deleted: todo["is_deleted"] ?? item.is_deleted,
      );
    } else {
      return item;
    }
  }).toList();
}

List<SingleTodoModel> updateApiTodoList({
  required List<SingleTodoModel> data,
  required dynamic id,
  required Map todo,
}) {
  return data.map((item) {
    if (item.id == id) {
      return SingleTodoModel(
        id: item.id,
        title: todo["title"] ?? item.title,
        description: todo["description"] ?? item.description,
        created_at: todo["created_at"] ?? item.created_at,
        is_completed: todo["is_completed"] ?? item.is_completed,
        is_deleted: todo["is_deleted"] ?? item.is_deleted,
      );
    } else {
      return item;
    }
  }).toList();
}
