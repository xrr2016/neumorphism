import '../exports.dart';

enum Shape {
  Top,
  Bottom,
  Left,
  Right,
}

class AppState {
  Color color;
  double size;
  double radius;
  double distance;
  double intensity;
  double blur;
  Shape shape;
  String code;

  AppState({
    this.color = Colors.blueAccent,
    this.size = 300.0,
    this.radius = 50.0,
    this.distance = 25,
    this.intensity = 0.6,
    this.blur = 20.0,
    this.shape = Shape.Top,
    this.code = '''
      decoration: BoxDecoration(
        color: state.color,
        borderRadius: BorderRadius.circular(state.radius),
        boxShadow: [
          BoxShadow(
            color: state.color.withOpacity(state.intensity),
            offset: Offset(-state.size / 10, -state.size / 10.0),
            blurRadius: state.blur,
            spreadRadius: 0.0,
          ),
          BoxShadow(
            color: state.color.withOpacity(state.intensity),
            offset: Offset(state.size / 10, state.size / 10),
            blurRadius: state.blur,
            spreadRadius: 0.0,
          ),
        ],
      )
    ''',
  });
}
