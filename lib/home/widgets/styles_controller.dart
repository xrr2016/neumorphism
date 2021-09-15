import 'package:flutter/material.dart';

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

    colors.asMap().forEach((key, color) {
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

  void _openDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          title: Text(AppLocalizations.of(context)!.color),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
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

  Widget _buildListTile(
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

  Widget _buildTypeRadio(CurveType type, String text) {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Radio<CurveType>(
            value: type,
            groupValue: state.type,
            activeColor: Colors.amber,
            onChanged: (CurveType? value) {
              setState(() {
                provider.changeType(type);
              });
            },
          ),
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ],
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
                leading: Text(
                  AppLocalizations.of(context)!.color,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: InkWell(
                  onTap: () {
                    _openDialog();
                  },
                  child: Container(
                    width: 24.0,
                    height: 24.0,
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
                  AppLocalizations.of(context)!.shape,
                  style: const TextStyle(color: Colors.white),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTypeRadio(
                        CurveType.flat,
                        AppLocalizations.of(context)!.flat,
                      ),
                      _buildTypeRadio(
                        CurveType.concave,
                        AppLocalizations.of(context)!.concave,
                      ),
                      _buildTypeRadio(
                        CurveType.convex,
                        AppLocalizations.of(context)!.convex,
                      ),
                    ],
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
                150.0,
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
                10.0,
                50.0,
                state.intensity,
                state.intensity.round().toString(),
                provider.changeIntensity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
