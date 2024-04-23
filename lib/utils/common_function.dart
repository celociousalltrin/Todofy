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
