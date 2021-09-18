import '../exports.dart';
import './widgets/styles_controller.dart';
import './widgets/preview_box.dart';
import './widgets/decoration_code.dart';
import './widgets/buyme_coffee.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';

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

  void _copyCode() async {
    try {
      await Clipboard.setData(ClipboardData(text: state.code));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.copied),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.amber,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const BuymeCoffee(),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: provider.downloadImage,
            icon: const Icon(Icons.download, color: Colors.white),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            onPressed: _copyCode,
            icon: const Icon(Icons.copy, color: Colors.white),
          ),
          const SizedBox(width: 10.0),
          InkWell(
            onTap: _launchURL,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/github.svg',
                width: 24.0,
                height: 24.0,
                color: Colors.white,
                semanticsLabel: 'Github',
              ),
            ),
          ),
          const SizedBox(width: 10.0),
        ],
        backgroundColor: state.color,
        title: const Text('Neumorphism'),
        centerTitle: false,
        elevation: 2.0,
      ),
      // drawer: Drawer(),
      backgroundColor: state.color,
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(color: state.color),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PreviewBox(),
                    SizedBox(height: 20.0),
                    StylesController(),
                  ],
                ),
              ),
              const VerticalDivider(thickness: 2.0),
              const DecorationCode(),
            ],
          ),
        ),
      ),
    );
  }
}
