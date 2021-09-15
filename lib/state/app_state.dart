import '../exports.dart';

enum Direction {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class AppState {
  Color color;
  double size;
  double radius;
  double distance;
  double intensity;
  double blur;
  Direction direction;
  String code;

  AppState({
    this.color = const Color(0xff333333),
    this.size = 200.0,
    this.radius = 10.0,
    this.distance = 25,
    this.intensity = 0.3,
    this.blur = 60.0,
    this.direction = Direction.topLeft,
    this.code = '',
  });
}
