import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class OrientationProvider with ChangeNotifier {
  Orientation _orientation = Portrait();
  Orientation get orientation => _orientation;
  set orientation(Orientation orientation) {
    _orientation = orientation;
    notifyListeners();
  }
}

@sealed
abstract class Orientation {
  Size size(BuildContext context) => Size.zero;
}

class Portrait implements Orientation {
  @override
  Size size(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Size(width, width * 0.5625);
  }
}

class Landscape implements Orientation {
  @override
  Size size(BuildContext context) {
    final height = MediaQuery.of(context).size.width;
    return Size(height / 0.5625, height);
  }
}
