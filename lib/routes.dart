import 'package:neumorphism/home/home_page.dart';

import './exports.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  HomePage.routeName: (BuildContext context) => const HomePage(),
};
