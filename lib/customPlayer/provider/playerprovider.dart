import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool isplaying) {
    _isPlaying = isplaying;
    notifyListeners();
  }
}
