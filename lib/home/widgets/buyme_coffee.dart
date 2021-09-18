import '../../exports.dart';

class BuymeCoffee extends StatelessWidget {
  const BuymeCoffee({Key? key}) : super(key: key);

  void _launchURL() async {
    if (await canLaunch(buymeCoffeeUrl)) {
      await launch(buymeCoffeeUrl);
    } else {
      throw 'Could not launch $buymeCoffeeUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Container(
        width: 174.0,
        height: 41.0,
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Image.asset(
          'images/default-yellow.webp',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
