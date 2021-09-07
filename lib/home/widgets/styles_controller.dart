import '../../exports.dart';

class StylesController extends StatefulWidget {
  const StylesController({Key? key}) : super(key: key);

  @override
  _StylesControllerState createState() => _StylesControllerState();
}

class _StylesControllerState extends State<StylesController> {
  late final AppStateProviderState provider = AppStateProvider.of(context);
  late final AppState state = provider.state;

  List<Widget> _buildColorItems() {
    List<Widget> items = [];

    Colors.primaries.asMap().forEach((key, color) {
      items.add(
        InkWell(
          onTap: () {
            provider.changeColor(color);
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
              crossAxisCount: 10,
              children: _buildColorItems(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 300.0,
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
                style: TextStyle(color: Colors.white54, fontSize: 12.0),
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
            ListTile(
              leading: Text(
                'Radius',
                style: TextStyle(color: Colors.white),
              ),
              title: Slider(
                min: 0.0,
                max: 200.0,
                label: state.radius.toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.white70,
                value: state.radius,
                onChanged: provider.changeRadius,
              ),
              trailing: Text(
                state.radius.floor().toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Text(
                'Size',
                style: TextStyle(color: Colors.white),
              ),
              title: Slider(
                min: 50.0,
                max: 300.0,
                label: state.size.toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.white70,
                value: state.size,
                onChanged: provider.changeSize,
              ),
              trailing: Text(
                state.size.floor().toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Text(
                'Blur',
                style: TextStyle(color: Colors.white),
              ),
              title: Slider(
                min: 0.0,
                max: 100.0,
                label: state.blur.toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.white70,
                value: state.blur,
                onChanged: provider.changeBlur,
              ),
              trailing: Text(
                state.blur.floor().toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Text(
                'Distance',
                style: TextStyle(color: Colors.white),
              ),
              title: Slider(
                min: 5.0,
                max: 50.0,
                label: state.distance.toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.white70,
                value: state.distance,
                onChanged: provider.changeDistance,
              ),
              trailing: Text(
                state.distance.floor().toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Slider(
            //   min: 0.01,
            //   max: 1.0,
            //   label: state.intensity.toString(),
            //   activeColor: Colors.amber,
            //   inactiveColor: Colors.white70,
            //   value: state.intensity,
            //   onChanged: provider.changeIntensity,
            // ),
          ],
        ),
      ),
    );
  }
}
