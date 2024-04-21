import 'package:flutter_bloc/flutter_bloc.dart';

class CubitStore extends Cubit<bool> {
  CubitStore() : super(false);

  void togglePage() {
    emit(!state);
  }
}
