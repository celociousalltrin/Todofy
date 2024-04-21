import 'package:flutter_bloc/flutter_bloc.dart';

class CounterStore extends Cubit<int> {
  CounterStore() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state != 0) {
      emit(state - 1);
    }
  }

  void reset() {
    emit(0);
  }
}
