import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_modal.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/todo_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final formkey = GlobalKey<FormState>();

  void handleCloseModal(TodoStore todoState) {
    Navigator.of(context).pop();
    todoState.triggerValidate(false);
  }

  void onCreate(StateSetter stflbrSetState, TodoStore todoState) {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      todoState.addTodo();
      handleCloseModal(todoState);
    } else {
      stflbrSetState(() {
        todoState.triggerValidate(true);
      });
    }
  }

  void handleOpenModal(TodoStore todoState) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, StateSetter stflbrSetState) {
            return AppModel(
                handleClose: () {
                  handleCloseModal(todoState);
                },
                formKey: formkey,
                handleSave: todoState.handleSave,
                onCreate: () {
                  onCreate(stflbrSetState, todoState);
                },
                inputPropsData: todoState.state.inputPropsData!,
                modelTitle: "Cubit Add To do",
                isTrigerValidate: todoState.state.isTriggerValidate);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final todoState = BlocProvider.of<TodoStore>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "CUBIT TODO LIST",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                AppButton(
                  onPressed: () {
                    handleOpenModal(todoState);
                  },
                  btnName: "ADD TODO",
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoStore, CubitTododModel>(
                builder: (context, todos) {
              return ListView.builder(
                  itemCount: todos.todoList.length,
                  itemBuilder: (context, index) {
                    TodoModel todo = todos.todoList[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: todo.is_deleted
                              ? Colors.red[400]
                              : todo.is_completed
                                  ? Colors.lightGreen[500]
                                  : Colors.amber[200],
                          border: Border.all(width: 1.0, color: Colors.black)),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      todoState.toggleCompleteTodo(
                                          todo.id, todo.is_completed);
                                    },
                                    child: Icon(
                                      todo.is_completed
                                          ? Icons.check_circle
                                          : Icons.check_circle_outline_outlined,
                                      size: 28.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: () {
                                      todoState.deleteTodo(todo.id);
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
                                  text: todo.description.length > 80 &&
                                          !todos.todoIds.contains(todo.id)
                                      ? "${todo.description.substring(0, 80)}..."
                                      : todo.description,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                if (todo.description.length > 80)
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: GestureDetector(
                                      onTap: () {
                                        todoState.viewDescription(todo.id);
                                      },
                                      child: Icon(
                                        todos.todoIds.contains(todo.id)
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
