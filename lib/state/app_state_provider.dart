import '../exports.dart';

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

  setCode() {
    final String colorString = state.color.value.toRadixString(16);
    final Color darkColor = colorLuminance(colorString, lum: state.intensity);
    final Color lightColor = colorLuminance(colorString, lum: -state.intensity);
    final Color baseColor =
        Color(int.parse('0x${state.color.value.toRadixString(16)}'));

    String code = '''
  Container(
    width: 500.0,
    height: 500.0,
    color: $baseColor,
    alignment: Alignment.center,
    child: Container(
      color: $baseColor,
      child: Container(
        width: ${state.size.round()},
        height: ${state.size.round()},
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: state.color,
          borderRadius: BorderRadius.circular(${state.radius.round()}),
          boxShadow: [
            BoxShadow(
              color: $darkColor,
              offset: Offset(
                ${-state.distance.round()},
                ${-state.distance.round()},
              ),
              blurRadius: ${state.blur.round()},
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: $lightColor,
              offset: Offset(
                ${state.distance.round()},
                ${state.distance.round()},
              ),
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
