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

    return SizedBox(
      width: 480.0,
      height: double.infinity,
      child: SingleChildScrollView(
        child: HighlightView(
          state.code,
          theme: theme,
          padding: const EdgeInsets.only(top: 20.0),
          language: 'dart',
          textStyle: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }
}
