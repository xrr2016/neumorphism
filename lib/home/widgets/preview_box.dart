import '../../exports.dart';

class PreviewBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final AppStateProviderState provider = AppStateProvider.of(context);
    late final AppState state = provider.state;

    return Container(
      width: 400.0,
      height: 400.0,
      alignment: Alignment.center,
      child: Container(
        width: state.size,
        height: state.size,
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: state.color,
          borderRadius: BorderRadius.circular(state.radius),
          // gradient: RadialGradient(
          //   colors: [
          //     Color(0xff23a450).withOpacity(1.0),
          //     Color(0xff23a450).withOpacity(1.0)
          //   ],
          //   focal: Alignment.bottomLeft,
          //   center: Alignment.bottomRight,
          //   radius: 0.0,
          // ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000),
              offset: Offset(
                -state.size / 10,
                -state.size / 10.0,
              ),
              blurRadius: state.blur,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Color(0xffffffff),
              offset: Offset(
                state.size / 10,
                state.size / 10,
              ),
              blurRadius: state.blur,
              spreadRadius: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
