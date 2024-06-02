import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/ViewCoursePage/Data/viewcoursedata.dart';
import 'package:streamit/utils.dart';

part 'viewcourse_event.dart';
part 'viewcourse_state.dart';

class ViewCourseBloc extends Bloc<ViewCourseEvent, ViewCourseState> {
  final int courseId;
  ViewCourseBloc(this.courseId) : super(ViewCourseLoading()) {
    on<ViewCourseLoadEvent>((event, emit) async {
      try {
        final c = await checkConnection();
        if (c) {
          final data = await loadData(courseId);
          emit(ViewCourseLoaded(data));
        } else {
          emit(NoInternet());
        }
      } catch (e) {
        emit(ViewCourse404());
      }
    });
    add(ViewCourseLoadEvent());
  }
  reset() async {
    add(ViewCourseLoadEvent());
  }
}
