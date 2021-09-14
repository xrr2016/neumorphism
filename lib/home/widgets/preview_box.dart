import '../../exports.dart';

// gradient: RadialGradient(
//   colors: [
//     Color(0xff23a450).withOpacity(1.0),
//     Color(0xff23a450).withOpacity(1.0)
//   ],
//   focal: Alignment.bottomLeft,
//   center: Alignment.bottomRight,
//   radius: 0.0,
// ),
class PreviewBox extends StatelessWidget {
  const PreviewBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final AppStateProviderState provider = AppStateProvider.of(context);
    late final AppState state = provider.state;
    late final String colorString = state.color.value.toRadixString(16);
    final Color darkColor = colorLuminance(colorString, lum: state.intensity);
    final Color lightColor = colorLuminance(colorString, lum: -state.intensity);
    final iconSize = state.size / 3;

    return Container(
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
          // image: const DecorationImage(
          //   // fit: BoxFit.cover,
          //   scale: 3.0,
          //   image: AssetImage('assets/images/moon.jpg'),
          //   alignment: Alignment.center,
          // ),
          boxShadow: [
            BoxShadow(
              color: darkColor,
              offset: Offset(-state.distance, -state.distance),
              blurRadius: state.blur,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: lightColor,
              offset: Offset(state.distance, state.distance),
              blurRadius: state.blur,
              spreadRadius: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
