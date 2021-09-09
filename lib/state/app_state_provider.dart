import '../exports.dart';

class AppStateProvider extends StatefulWidget {
  final Widget child;
  final AppState state;

  const AppStateProvider({
    required this.child,
    required this.state,
  });

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
    String code = '''
  Container(
    width: 500.0,
    height: 500.0,
    color: Colors.amber,
    alignment: Alignment.center,
    child: Container(
      color: '${state.color.toString()}',
      child: Container(
        width: '${state.size}',
        height: '${state.size}',
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: state.color,
          borderRadius: BorderRadius.circular('${state.radius}'),
          boxShadow: [
            BoxShadow(
              color: state.color.withOpacity(state.intensity),
              offset: Offset(
                ${-state.size / 10.0},
                ${-state.size / 10.0},
              ),
              blurRadius: ${state.blur},
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: state.color.withOpacity(state.intensity),
              offset: Offset(
                ${state.size / 10.0},
                ${state.size / 10.0},
              ),
              blurRadius: ${state.blur},
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

  _InheritedStateContainer({
    required this.data,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
