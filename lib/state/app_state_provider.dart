import '../exports.dart';
import 'package:universal_html/html.dart' as html;

class AppStateProvider extends StatefulWidget {
  final Widget child;
  final AppState state;

  const AppStateProvider({
    Key? key,
    required this.state,
    required this.child,
  }) : super(key: key);

  static AppStateProviderState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()!
        .data;
  }

  @override
  AppStateProviderState createState() => AppStateProviderState();
}

class AppStateProviderState extends State<AppStateProvider> {
  late AppState state;
  final ScreenshotController screenshotController = ScreenshotController();

  changeRadius(double val) {
    state.radius = val;
    setCode();
    setState(() {});
  }

  changeSize(double val) {
    state.size = val;
    state.blur = val / 10 * 2;
    setCode();
    setState(() {});
  }

  changeBlur(double val) {
    state.blur = val;
    setCode();
    setState(() {});
  }

  changeDistance(double val) {
    state.distance = val;
    // state.blur = val * 2;
    setCode();
    setState(() {});
  }

  changeColor(Color color) {
    // debugPrint(color.value.toRadixString(16));

    state.color = color;
    setCode();
    setState(() {});
  }

  changeIntensity(double val) {
    state.intensity = val;
    setCode();
    setState(() {});
  }

  changeDirection(Direction direction) {
    state.direction = direction;
    setCode();
    setState(() {});
  }

  changeType(CurveType type) {
    state.type = type;
    setCode();
    setState(() {});
  }

  changePreview(Widget widget) {
    state.preview = widget;
  }

  setCode() {
    final int depth = state.intensity.toInt();
    final Color darkColor = getAdjustColor(state.color, depth);
    final Color lightColor = getAdjustColor(state.color, -depth);

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

    String code = '''
      Container(
        width: 500.0,
        height: 500.0,
        color: ${state.color},
        alignment: Alignment.center,
        transformAlignment: Alignment.center,
        child: Container(
          color: ${state.color},
          child: Container(
            width: ${state.size.round()},
            height: ${state.size.round()},
            child: Icon(
              Icons.star,
              size: ${(state.size / 3).round()},
              color: Colors.amber,
            ),
            decoration: BoxDecoration(
              color: ${state.color},
              borderRadius: BorderRadius.circular(${state.radius.round()}),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ${gradientColors.first},
                  ${gradientColors.last},
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: $darkColor,
                  offset: $darkOffset,
                  blurRadius: ${state.blur.round()},
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: $lightColor,
                  offset: $lightOffset,
                  blurRadius: ${state.blur.round()},
                  spreadRadius: 0.0,
                ),
              ],
            ),
          ),
        ),
      )
  ''';
    state.code = code;
    setState(() {});
  }

  void _capturedImage(Uint8List image) async {
    final base64data = base64Encode(image);
    final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');
    a.download = 'Neumorphism.jpg';
    a.click();
    a.remove();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.download),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.amber,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _catchError(onError) {
    print(onError);
  }

  void downloadImage() async {
    try {
      final double pixelRatio = MediaQuery.of(context).devicePixelRatio;

      screenshotController
          .captureFromWidget(
            state.preview,
            pixelRatio: pixelRatio,
          )
          .then(_capturedImage)
          .catchError(_catchError);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    state = widget.state;
    setCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppStateProviderState data;

  const _InheritedStateContainer({
    required this.data,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
