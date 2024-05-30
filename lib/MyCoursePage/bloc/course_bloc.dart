import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamit/utils.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseLoading()) {
    on<CourseLoadEvent>((event, emit) async {
      final c = await checkConnection();
      print(c);
      if (c) {
        // CourseScreenData? CourseScreenData = await CourseDataBaseQuery().initData();
        // if (CourseScreenData != null) {
        //   emit(CourseLoaded(CourseScreenData));
        // } else {
        emit(Course404());
        // }
      } else {
        emit(NoInternet());
      }
    });
    add(CourseLoadEvent());
  }
  reset() async {
    add(CourseLoadEvent());
  }
}
