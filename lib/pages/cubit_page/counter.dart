import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/pages/cubit_page/cubit_store/counter_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterState = BlocProvider.of<CounterStore>(context);
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<CounterStore, int>(builder: (context, counter) {
          return Text(
            counter.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 36),
          );
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
                onPressed: () => counterState.increment(),
                btnName: "Increment"),
            const SizedBox(
              width: 30,
            ),
            AppButton(
                onPressed: () => counterState.decrement(), btnName: "Decrement")
          ],
        ),
        const SizedBox(height: 10),
        AppButton(
          onPressed: () => counterState.reset(),
          btnName: "Reset",
          btnStyle: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color?>(Colors.red[500])),
          btnTxtStyle: const TextStyle(color: Colors.black),
        )
      ],
    )));
  }
}
