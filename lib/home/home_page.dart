import '../exports.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppStateProviderState provider = AppStateProvider.of(context);
  late final AppState state = provider.state;

  List<Widget> _buildColorItems() {
    List<Widget> items = [];

    Colors.primaries.asMap().forEach((key, color) {
      items.add(
        InkWell(
          onTap: () {
            state.color = color;
            setState(() {});
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    });

    return items.toList();
  }

  void _openDialog(String title) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20.0),
            child: GridView.count(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 6,
              children: _buildColorItems(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Container(
                  width: state.size,
                  height: state.size,
                  transformAlignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: state.color,
                    // gradient: RadialGradient(
                    //   colors: [
                    //     Color(0xff23a450).withOpacity(1.0),
                    //     Color(0xff23a450).withOpacity(1.0)
                    //   ],
                    //   focal: Alignment.bottomLeft,
                    //   center: Alignment.bottomRight,
                    //   radius: 0.0,
                    // ),
                    borderRadius: BorderRadius.circular(state.radius),
                    boxShadow: [
                      BoxShadow(
                        color: state.color.withOpacity(state.intensity),
                        offset: Offset(-state.size / 10, -state.size / 10.0),
                        blurRadius: state.blur,
                        spreadRadius: 0.0,
                      ),
                      BoxShadow(
                        color: state.color.withOpacity(state.intensity),
                        offset: Offset(state.size / 10, state.size / 10),
                        blurRadius: state.blur,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(),
                  child: HighlightView(
                    state.code,
                    language: 'dart',
                    theme: githubTheme,
                    padding: EdgeInsets.all(12),
                    textStyle: TextStyle(
                      fontFamily: 'My awesome monospace font',
                      fontSize: 16,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            color: Colors.pink,
            width: 500.0,
            height: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Primary Color',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Choose primary color',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _openDialog("Main Color picker");
                    },
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state.color,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Slider(
                  min: 0.0,
                  max: 100.0,
                  label: state.radius.toString(),
                  activeColor: Colors.amber,
                  inactiveColor: Colors.white70,
                  value: state.radius,
                  onChanged: provider.changeRadius,
                ),
                Slider(
                  min: 50.0,
                  max: 500.0,
                  label: state.size.toString(),
                  activeColor: Colors.amber,
                  inactiveColor: Colors.white70,
                  value: state.size,
                  onChanged: provider.changeSize,
                ),
                Slider(
                  min: 0.0,
                  max: 100.0,
                  label: state.blur.toString(),
                  activeColor: Colors.amber,
                  inactiveColor: Colors.white70,
                  value: state.blur,
                  onChanged: provider.changeBlur,
                ),
                Slider(
                  min: 5.0,
                  max: 50.0,
                  label: state.blur.toString(),
                  activeColor: Colors.amber,
                  inactiveColor: Colors.white70,
                  value: state.distance,
                  onChanged: provider.changeDistance,
                ),
                Slider(
                  min: 0.01,
                  max: 1.0,
                  label: state.intensity.toString(),
                  activeColor: Colors.amber,
                  inactiveColor: Colors.white70,
                  value: state.intensity,
                  onChanged: provider.changeIntensity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
