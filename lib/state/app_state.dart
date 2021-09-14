import '../exports.dart';

enum Direction {
  top,
  bottom,
  left,
  right,
}

class AppState {
  Color color;
  double size;
  double radius;
  double distance;
  double intensity;
  double blur;
  Direction shape;
  String code;

  AppState({
    this.color = const Color(0xff333333),
    this.size = 300.0,
    this.radius = 50.0,
    this.distance = 25,
    this.intensity = 0.3,
    this.blur = 60.0,
    this.shape = Direction.top,
    this.code = '',
  });
}
