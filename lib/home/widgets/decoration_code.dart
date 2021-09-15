import '../../exports.dart';

class DecorationCode extends StatelessWidget {
  const DecorationCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final AppStateProviderState provider = AppStateProvider.of(context);
    late final AppState state = provider.state;

    Map<String, TextStyle> theme = {};
    theme.addAll(atomOneDarkTheme);

    theme.update(
      'root',
      (value) => value.copyWith(
        backgroundColor: state.color,
      ),
    );

    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Container(
        width: 500.0,
        margin: const EdgeInsets.only(top: 20.0),
        height: constraints.maxHeight,
        child: SingleChildScrollView(
          child: HighlightView(
            state.code,
            theme: theme,
            language: 'dart',
            textStyle: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
        ),
      );
    });
  }
}
