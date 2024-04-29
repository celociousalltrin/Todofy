import 'package:flutter_application_1/service/api_config.dart';

getTodos() => DioClient.instance.get("/todos");

getSingleTodo(dynamic id) => DioClient.instance.get("/todos/$id");

toggleCompleteTodo(dynamic id, Map payload) =>
    DioClient.instance.put("/todos/$id", data: payload);

deleteTodo(dynamic id, Map payload) =>
    DioClient.instance.put("/todos/$id", data: payload);

createTodo(Map payload) => DioClient.instance.post("/todos", data: payload);
