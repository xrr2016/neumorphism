import './exports.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      state: AppState(),
      child: MaterialApp(
        title: 'Neumorphism',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
