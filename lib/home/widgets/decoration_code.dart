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

    void _copyCode() async {
      try {
        await Clipboard.setData(ClipboardData(text: state.code));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.copied),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return SizedBox(
        width: 400.0,
        height: constraints.maxHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20.0),
              SizedBox(
                width: constraints.maxWidth,
                child: HighlightView(
                  state.code,
                  theme: theme,
                  language: 'dart',
                  textStyle: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 60.0,
                width: constraints.maxWidth,
                color: Colors.amber,
                child: OutlinedButton.icon(
                  onPressed: _copyCode,
                  icon: const Icon(Icons.copy, color: Colors.white),
                  label: Text(
                    AppLocalizations.of(context)!.copy,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
