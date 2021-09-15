import '../exports.dart';
import './widgets/styles_controller.dart';
import './widgets/preview_box.dart';
import './widgets/decoration_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppStateProviderState provider = AppStateProvider.of(context);
  late final AppState state = provider.state;

  void _launchURL() async {
    if (await canLaunch(githubRepoUrl)) {
      await launch(githubRepoUrl);
    } else {
      throw 'Could not launch $githubRepoUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: _launchURL,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/images/github.svg',
                width: 22.0,
                height: 22.0,
                color: Colors.white,
                semanticsLabel: 'Github',
              ),
            ),
          ),
        ],
        backgroundColor: state.color,
        title: const Text('Neumorphism'),
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
                  children: const [
                    PreviewBox(),
                    SizedBox(height: 20.0),
                    StylesController(),
                  ],
                ),
              ),
              const DecorationCode(),
            ],
          ),
        ),
      ),
    );
  }
}
