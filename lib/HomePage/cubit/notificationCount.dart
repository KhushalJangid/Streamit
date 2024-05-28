import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String key = 'notiCount';

class NotificationCountCubit extends Cubit<int> {
  SharedPreferences? prefs;
  NotificationCountCubit() : super(0) {
    debugPrint('notification count initiated');
    initPref();
  }
  initPref() async {
    prefs = await SharedPreferences.getInstance();
    emit(prefs!.getInt(key) ?? 0);
  }

  clearCount() {
    prefs!.setInt(key, 0);
    emit(0);
  }

  increaseCount() {
    prefs!.setInt(key, state + 1);
    emit(state + 1);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    debugPrint('notification count cubit closed successfully');
    return super.close();
  }

  reset() {
    emit(0);
  }
}
