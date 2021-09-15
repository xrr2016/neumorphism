import 'package:neumorphism/home/home_page.dart';

import './exports.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  HomePage.routeName: (BuildContext context) => const HomePage(),
  CardPage.routeName: (BuildContext context) => const CardPage(),
  BorderPage.routeName: (BuildContext context) => const BorderPage(),
};
