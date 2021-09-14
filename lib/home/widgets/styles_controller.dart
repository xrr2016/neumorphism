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
            padding: const EdgeInsets.all(20.0),
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

  ListTile _buildListTile(
    String leading,
    double min,
    double max,
    double value,
    String trailing,
    Function(double) onChanged,
  ) {
    return ListTile(
      leading: Text(
        leading,
        style: const TextStyle(color: Colors.white),
      ),
      title: Slider(
        min: min,
        max: max,
        value: value,
        // divisions: 1,
        label: value.toString(),
        activeColor: Colors.amber,
        inactiveColor: Colors.white70,
        onChanged: onChanged,
      ),
      trailing: Text(
        trailing,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text(
                  AppLocalizations.of(context)!.primary,
                  style: const TextStyle(color: Colors.white),
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
              _buildListTile(
                AppLocalizations.of(context)!.size,
                100.0,
                300.0,
                state.size,
                state.size.round().toString(),
                provider.changeSize,
              ),
              _buildListTile(
                AppLocalizations.of(context)!.blur,
                0.0,
                100.0,
                state.blur,
                state.blur.round().toString(),
                provider.changeBlur,
              ),
              _buildListTile(
                AppLocalizations.of(context)!.radius,
                0.0,
                200.0,
                state.radius,
                state.radius.round().toString(),
                provider.changeRadius,
              ),
              _buildListTile(
                AppLocalizations.of(context)!.distance,
                5.0,
                50.0,
                state.distance,
                state.distance.round().toString(),
                provider.changeDistance,
              ),
              _buildListTile(
                AppLocalizations.of(context)!.intensity,
                0.1,
                0.6,
                state.intensity,
                state.intensity.toStringAsFixed(1),
                provider.changeIntensity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
