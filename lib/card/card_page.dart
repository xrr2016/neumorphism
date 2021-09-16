import 'dart:ui';
import '../exports.dart';

class CardPage extends StatefulWidget {
  static String routeName = 'card_page';

  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
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

    double _width;
    double _height;
    double _blur;
    double _radius;
    double _opacity;
    double _padding;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.copy, color: Colors.white),
          ),
          const SizedBox(width: 10.0),
          InkWell(
            onTap: () {},
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
        title: const Text('Glassmorphism'),
        centerTitle: false,
        elevation: 2.0,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ResizeImage(
                    NetworkImage(
                      'https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_960_720.jpg',
                    ),
                    width: 960,
                    height: 720,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 30.0,
                    sigmaY: 30.0,
                    tileMode: TileMode.clamp,
                  ),
                  child: Container(
                    width: 720.0,
                    height: 400.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.01),
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Card',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              ),
                              Icon(
                                Icons.credit_card_sharp,
                                color: Colors.white.withOpacity(0.75),
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TL Templates',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              ),
                              Text(
                                '07/25',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '5555 5555 5555 4444',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 480.0,
            constraints: const BoxConstraints.tightForFinite(),
            color: state.color,
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
          ),
        ],
      ),
    );
  }
}
