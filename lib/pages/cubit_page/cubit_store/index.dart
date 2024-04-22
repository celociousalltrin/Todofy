import 'package:flutter_bloc/flutter_bloc.dart';

class CubitStore extends Cubit<bool> {
  CubitStore() : super(true);

  void togglePage() {
    emit(!state);
  }
}
