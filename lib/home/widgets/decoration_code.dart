import 'package:flutter/material.dart';

import '../../exports.dart';

class DecorationCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final AppStateProviderState provider = AppStateProvider.of(context);
    late final AppState state = provider.state;

    void _copyCode() async {
      try {
        await Clipboard.setData(ClipboardData(text: state.code));

        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text('Copyed'),
            leading: Icon(
              Icons.done,
              color: Colors.white,
            ),
            backgroundColor: state.color,
            contentTextStyle: TextStyle(
              color: Colors.white,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                },
              ),
            ],
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Container(
        width: 400.0,
        height: constraints.maxHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 20.0),
              Container(
                width: constraints.maxWidth,
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
              SizedBox(height: 20.0),
              Container(
                height: 60.0,
                width: constraints.maxWidth,
                color: Colors.amber,
                child: OutlinedButton.icon(
                  onPressed: _copyCode,
                  icon: Icon(Icons.copy, color: Colors.white),
                  label: Text('Copy', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
