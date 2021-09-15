import './exports.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppState state = AppState();

    return AppStateProvider(
      state: state,
      child: MaterialApp(
        title: 'Neumorphism',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.amber,
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        // locale: AppLocalizations.supportedLocales.last,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
        routes: appRoutes,
      ),
    );
  }
}
