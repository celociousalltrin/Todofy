import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cubit_page/counter.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/counter_store.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/todo_store.dart';
import 'package:flutter_application_1/pages/cubit_page/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitPage extends StatefulWidget {
  const CubitPage({super.key});

  @override
  State<CubitPage> createState() => _CubitPageState();
}

class _CubitPageState extends State<CubitPage> {
  bool isToggle = true;

  void updateToggle() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TodoStore()),
        BlocProvider(create: (_) => CounterStore())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cubit Page"),
          backgroundColor: Colors.yellow,
          centerTitle: true,
        ),
        body: isToggle ? const TodoPage() : const CounterPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: updateToggle,
          backgroundColor: Colors.amber[300],
          child: const Icon(Icons.bubble_chart, size: 36),
        ),
      ),
    );
  }
}
