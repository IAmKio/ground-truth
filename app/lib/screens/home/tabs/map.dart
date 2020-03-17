import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helpers/router.dart';
import '../../../helpers/hotspots.dart';

class MapScreen extends StatefulWidget {
  const MapScreen() : super();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var routerHelper = RouterHelper();
  var hotspotsHelper = HotspotHelper();

  bool loaded = false;

  @override
  void initState() {
    super.initState();

    start();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void start() async {
    var r = await hotspotsHelper.getHotspots();
    print(r);

    if (this.mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];

    if (!loaded) {
      widgets.add(Text(
        'Just a second...',
        style: Theme.of(context).textTheme.title,
      ));
      widgets.add(Text(
        'Fetching all the hotspots...',
        style: Theme.of(context).textTheme.subtitle,
      ));
      widgets.add(SizedBox(height: 40));
      widgets.add(new CircularProgressIndicator());
    } else {
      widgets.add(Text(
        'We\'re ready for you!',
        style: Theme.of(context).textTheme.title,
      ));
      widgets.add(
        FlatButton.icon(
          onPressed: () {

          },
          icon: Icon(Icons.map),
          label: new Text(
            'Launch Map',
            style: Theme.of(context).textTheme.title,
          ))
      );
    }

    return widgets;
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding: Map Pane');

    return new Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildWidgets(),
        ),
      )
    );
  }
}