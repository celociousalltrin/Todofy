import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cubit_page/counter.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/index.dart';
import 'package:flutter_application_1/pages/cubit_page/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitPage extends StatelessWidget {
  const CubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = CubitStore();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubit Page"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: BlocBuilder<CubitStore, bool>(
          bloc: cubit,
          builder: (context, cubitStore) {
            return cubitStore ? const TodoPage() : const CounterPage();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.togglePage();
        },
        backgroundColor: Colors.amber[300],
        child: const Icon(Icons.bubble_chart, size: 36),
      ),
    );
  }
}
