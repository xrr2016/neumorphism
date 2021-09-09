import '../../exports.dart';

class DecorationCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final AppStateProviderState provider = AppStateProvider.of(context);
    late final AppState state = provider.state;

    return Column(
      children: [
        Container(
          width: 400.0,
          height: 500.0,
          color: state.color,
          child: SingleChildScrollView(
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
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: OutlinedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: state.code));
            },
            icon: Icon(Icons.copy),
            label: Text('Copy'),
          ),
        )
      ],
    );
  }
}
