import 'package:flutter/material.dart';

import '../../exports.dart';

class PreviewBox extends StatelessWidget {
  const PreviewBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final AppStateProviderState provider = AppStateProvider.of(context);
    late final AppState state = provider.state;
    final int depth = state.intensity.toInt();
    final Color darkColor = getAdjustColor(state.color, depth);
    final Color lightColor = getAdjustColor(state.color, -depth);
    final double iconSize = state.size / 3;

    Offset darkOffset = Offset(state.distance, state.distance);
    Offset lightOffset = Offset(-state.distance, -state.distance);

    switch (state.direction) {
      case Direction.topLeft:
        darkOffset = Offset(-state.distance, -state.distance);
        lightOffset = Offset(state.distance, state.distance);
        break;
      case Direction.topRight:
        darkOffset = Offset(state.distance, -state.distance);
        lightOffset = Offset(-state.distance, state.distance);
        break;
      case Direction.bottomLeft:
        darkOffset = Offset(state.distance, state.distance);
        lightOffset = Offset(-state.distance, -state.distance);
        break;
      case Direction.bottomRight:
        darkOffset = Offset(-state.distance, state.distance);
        lightOffset = Offset(state.distance, -state.distance);
        break;
      default:
    }

    List<Color> gradientColors = [];

    switch (state.type) {
      case CurveType.flat:
        gradientColors = getFlatGradients(state.color, depth);
        break;
      case CurveType.concave:
        gradientColors = getConcaveGradients(state.color, depth);
        break;
      case CurveType.convex:
        gradientColors = getConvexGradients(state.color, depth);
        break;
    }

    List<BoxShadow> shadowList = [
      BoxShadow(
        color: lightColor,
        offset: lightOffset,
        blurRadius: state.blur,
        spreadRadius: 0.0,
      ),
      BoxShadow(
        color: darkColor,
        offset: darkOffset,
        blurRadius: state.blur,
        spreadRadius: 0.0,
      ),
    ];

    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      final double pos = constraints.maxWidth / 4;

      return Stack(
        children: [
          Container(
            height: 400.0,
            alignment: Alignment.center,
            color: state.color,
            child: Container(
              width: state.size,
              height: state.size,
              child: Icon(
                Icons.star,
                size: iconSize,
                color: Colors.amber,
              ),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                color: state.color,
                borderRadius: BorderRadius.circular(state.radius),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                boxShadow: shadowList,
              ),
            ),
          ),
          Positioned(
            top: 25.0,
            left: pos,
            child: Transform.rotate(
              angle: -45.0,
              child: IconButton(
                onPressed: () {
                  provider.changeDirection(Direction.topLeft);
                },
                icon: Icon(
                  Icons.light,
                  color: state.direction == Direction.topLeft
                      ? Colors.amber
                      : Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 25.0,
            right: pos,
            child: Transform.rotate(
              angle: 45.0,
              child: IconButton(
                onPressed: () {
                  provider.changeDirection(Direction.topRight);
                },
                icon: Icon(
                  Icons.light,
                  color: state.direction == Direction.topRight
                      ? Colors.amber
                      : Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: pos,
            child: Transform.rotate(
              angle: 90.0,
              child: IconButton(
                onPressed: () {
                  provider.changeDirection(Direction.bottomLeft);
                },
                icon: Icon(
                  Icons.light,
                  color: state.direction == Direction.bottomLeft
                      ? Colors.amber
                      : Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: pos,
            child: Transform.rotate(
              angle: -90.0,
              child: IconButton(
                onPressed: () {
                  provider.changeDirection(Direction.bottomRight);
                },
                icon: Icon(
                  Icons.light,
                  color: state.direction == Direction.bottomRight
                      ? Colors.amber
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
