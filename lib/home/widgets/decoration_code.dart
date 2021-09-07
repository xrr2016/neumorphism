import '../../exports.dart';

class DecorationCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final AppStateProviderState provider = AppStateProvider.of(context);
    late final AppState state = provider.state;

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: 400.0,
          color: state.color,
          child: HighlightView(
            state.code,
            language: 'dart',
            theme: githubTheme,
            padding: EdgeInsets.all(12.0),
            textStyle: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
