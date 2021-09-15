import '../../exports.dart';

final backgroundColor = Color(0xFF2c3135);
final highlightColor = Colors.white.withOpacity(0.05);
final shadowColor = Colors.black87;

class CircleInnerHighlight extends StatelessWidget {
  final Color highlightColor;
  final Color backgroundColor;

  const CircleInnerHighlight({
    required this.highlightColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(12.0),
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            highlightColor,
          ],
          center: AlignmentDirectional(-0.05, -0.05),
          focal: AlignmentDirectional(-0.05, -0.05),
          radius: 0.6,
          focalRadius: 0.1,
          stops: [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.55, 1],
            colors: [backgroundColor, backgroundColor.withOpacity(0)],
          ),
        ),
      ),
    );
  }
}

class CircleInnerShadow extends StatelessWidget {
  final Color shadowColor;
  final Color backgroundColor;

  const CircleInnerShadow({
    required this.shadowColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            shadowColor,
          ],
          center: AlignmentDirectional(0.05, 0.05),
          focal: AlignmentDirectional(0, 0),
          radius: 0.5,
          focalRadius: 0,
          stops: [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.45],
            colors: [backgroundColor.withOpacity(0), backgroundColor],
          ),
        ),
      ),
    );
  }
}

class ShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HighlightClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
}

class NeuomorphicCircle extends StatelessWidget {
  final bool innerShadow;
  final bool outerShadow;
  final Color highlightColor;
  final Color shadowColor;
  final Color backgroundColor;
  final Widget child;

  NeuomorphicCircle({
    required this.innerShadow,
    required this.outerShadow,
    required this.highlightColor,
    required this.shadowColor,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      color: backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipPath(
            clipper: HighlightClipper(),
            child: CircleInnerHighlight(
              highlightColor: highlightColor,
              backgroundColor: backgroundColor,
            ),
          ),
          ClipPath(
            clipper: ShadowClipper(),
            child: CircleInnerShadow(
              shadowColor: shadowColor,
              backgroundColor: backgroundColor,
            ),
          ),
          child
        ],
      ),
    );
  }
}
