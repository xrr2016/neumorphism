import './exports.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppState state = AppState();

    return MaterialApp(
      title: 'Neumorphism',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      // locale: AppLocalizations.supportedLocales.last,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: AppStateProvider(
        state: state,
        child: const HomePage(),
      ),
      routes: appRoutes,
    );
  }
}
