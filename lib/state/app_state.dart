import '../exports.dart';

enum Direction { topLeft, topRight, bottomLeft, bottomRight }

enum CurveType { concave, convex, flat }

class AppState {
  Color color;
  double size;
  double radius;
  double distance;
  double intensity;
  double blur;
  Direction direction;
  CurveType type;
  String code;

  AppState({
    this.color = const Color(0xff333333),
    this.size = 200.0,
    this.radius = 10.0,
    this.distance = 25,
    this.intensity = 0.3,
    this.blur = 60.0,
    this.direction = Direction.topLeft,
    this.type = CurveType.flat,
    this.code = '',
  });
}
