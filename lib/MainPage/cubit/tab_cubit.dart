import 'package:bloc/bloc.dart';

class TabCubit extends Cubit<int> {
  TabCubit() : super(0);
  void changetab(int index) {
    emit(index);
  }
  reset(){
   emit(0);
  }
}
