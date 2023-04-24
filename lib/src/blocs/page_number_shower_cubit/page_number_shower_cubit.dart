import 'package:bloc/bloc.dart';

class PageNumberShowerCubit extends Cubit<bool> {
  PageNumberShowerCubit() : super(true);

  void showPageNumber() {
    emit(true);
  }

  void hidePageNumber() {
    emit(false);
  }
}
