import '../exports.dart';

class BorderPage extends StatefulWidget {
  static String routeName = 'border_page';

  const BorderPage({Key? key}) : super(key: key);

  @override
  _BorderPageState createState() => _BorderPageState();
}

class _BorderPageState extends State<BorderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: BoderClipper(),
        child: Container(),
      ),
    );
  }
}

class BoderClipper extends CustomClipper<Path> {
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
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
