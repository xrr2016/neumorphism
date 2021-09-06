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
    setState(() {});
  }

  changeSize(double val) {
    state.size = val;
    state.blur = val / 10 * 2;
    setState(() {});
  }

  changeBlur(double val) {
    state.blur = val;
    setState(() {});
  }

  changeDistance(double val) {
    state.distance = val;
    state.blur = val * 2;
    setState(() {});
  }

  changeColor(Color color) {
    state.color = color;
    setState(() {});
  }

  changeIntensity(double val) {
    state.intensity = val;
    setState(() {});
  }

  @override
  void initState() {
    state = widget.state;
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
