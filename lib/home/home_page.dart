import '../exports.dart';
import './widgets/styles_controller.dart';
import './widgets/preview_box.dart';
import './widgets/decoration_code.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppStateProviderState provider = AppStateProvider.of(context);
  late final AppState state = provider.state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.gite),
          )
        ],
        backgroundColor: state.color,
        title: Text('Neumorphism'),
        centerTitle: false,
        // elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          color: state.color,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PreviewBox(),
                    StylesController(),
                  ],
                ),
              ),
              DecorationCode(),
            ],
          ),
        ),
      ),
    );
  }
}
