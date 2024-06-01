import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/MyCoursePage/Data/mycoursedata.dart';
import 'package:streamit/utils.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseLoading()) {
    on<CourseLoadEvent>((event, emit) async {
      final c = await checkConnection();
      if (c) {
        final data = await loadData();
        if (data.isNotEmpty) {
          emit(CourseLoaded(data));
        } else {
          emit(Course404());
        }
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
