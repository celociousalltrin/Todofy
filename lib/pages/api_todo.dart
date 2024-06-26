import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_drawer.dart';
import 'package:flutter_application_1/components/app_modal.dart';
import 'package:flutter_application_1/pages/api_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ApiTodoPage extends StatefulWidget {
  const ApiTodoPage({super.key});

  @override
  State<ApiTodoPage> createState() => _ApiTodoPageState();
}

class _ApiTodoPageState extends State<ApiTodoPage> {
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ApiTodoStore>(context).getTodoList();
    });
  }

  void handleCloseModal(ApiTodoStore apiState) {
    Navigator.of(context).pop();
    apiState.triggervalidate(false);
  }

  void onCreate(StateSetter stflbrSetState, ApiTodoStore apiState) {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      apiState.addApiTodo();
      handleCloseModal(apiState);
    } else {
      stflbrSetState(() {
        apiState.triggervalidate(true);
      });
    }
  }

  String formatCustomDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM HH:mm');
    return formatter.format(dateTime);
  }

  void handleOpenModal(ApiTodoStore apiState) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, StateSetter stflbrSetState) {
            return AppModel(
                handleClose: () {
                  handleCloseModal(apiState);
                },
                formKey: formkey,
                handleSave: apiState.hanldeSave,
                onCreate: () {
                  onCreate(stflbrSetState, apiState);
                },
                inputPropsData: inputPropsData,
                modelTitle: "Add Api Todo",
                isTrigerValidate: apiState.state.isTriggerValidate);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final apiTodoState = BlocProvider.of<ApiTodoStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API TODO Page",
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppButton(
                  onPressed: () {
                    handleOpenModal(apiTodoState);
                  },
                  btnName: "ADD API TODOD"),
            ),
            Expanded(child: BlocBuilder<ApiTodoStore, ApiTodoModel>(
                builder: (context, todos) {
              return ListView.builder(
                  itemCount: todos.todoList.length,
                  itemBuilder: (context, index) {
                    SingleTodoModel todo = todos.todoList[index];
                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: GestureDetector(
                        onTap: () {
                          context.goNamed("api-todo-id",
                              pathParameters: {"id": todo.id});
                        },
                        child: Container(
                            height: 82,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: todo.is_completed
                                    ? Colors.greenAccent
                                    : Colors.amber[300],
                                border: Border.all(
                                    width: 1.0, color: Colors.black)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todo.title,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        formatCustomDateTime(
                                            DateTime.parse(todo.created_at)),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                apiTodoState.completeTodo(
                                                    todo.id, todo);
                                              },
                                              child: Icon(
                                                todo.is_completed
                                                    ? Icons.check_circle
                                                    : Icons
                                                        .check_circle_outline_outlined,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              apiTodoState.deleteTodo(todo.id);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              size: 28,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ])),
                      ),
                    );
                  });
            })),
          ],
        ),
      ),
    );
  }
}
