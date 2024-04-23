import 'package:flutter_application_1/pages/cubit_page/cubit_store/todo_store.dart';

bool isKey(String key, String field) {
  return key == field;
}

List<TodoModel> updateList(
    {required List<TodoModel> data,
    required int id,
    required String key,
    required dynamic value}) {
  return data.map((item) {
    if (item.id == id) {
      return TodoModel(
          title: item.title,
          id: item.id,
          description: item.description,
          is_completed: isKey(key, "is_completed") ? value : item.is_completed,
          is_deleted: isKey(key, "is_deleted") ? value : item.is_deleted);
    } else {
      return item;
    }
  }).toList();
}
