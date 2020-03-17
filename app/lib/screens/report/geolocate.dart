import 'dart:async';

import 'package:flutter/material.dart';

import '../../helpers/router.dart';
import '../../helpers/layers.dart';

class ReportGeolocateScreen extends StatefulWidget {
  Map<String, dynamic> routeData;
  ReportGeolocateScreen({this.routeData}) : super();

  @override
  _ReportGeolocateScreenState createState() => _ReportGeolocateScreenState();
}

class _ReportGeolocateScreenState extends State<ReportGeolocateScreen> with TickerProviderStateMixin{
  var routerHelper = RouterHelper();
  var layerHelper = LayersHelper();
  
  bool loaded = false;
  bool showLocationCard = false;
  Map<String, dynamic> layers;
  String layerId;
  List<dynamic> fetchedLayers;
  Map<String, dynamic> selectedLayer;

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    print('Report Geolocate Screen starting...');
    print(this.widget.routeData);

    layerId = this.widget.routeData['layerId'][0];
    print('Layer ID: $layerId');

    fetchedLayers = layerHelper.layers['layers'];
    print('Layers from cache: $fetchedLayers');

    selectedLayer = layerHelper.getLayerById(layerId);
    print('selectedLayer $selectedLayer');

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        showLocationCard = true;
      });
    });

    setState(() {
      loaded = true;
    });
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];

    if (loaded == true) {
      widgets.add(Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.bug_report, size: 50),
              title: Text('${selectedLayer['friendlyName']} (${selectedLayer['technicalName']})'),
              subtitle: Text(selectedLayer['shortDescription']),
            ),
          ],
        ),
      ));

      widgets.add(
        AnimatedSize(
          duration: Duration(milliseconds: 500),
          vsync: this,
          curve: Curves.fastOutSlowIn,
          child: Container(
            height: showLocationCard ? null : 0,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.location_searching, size: 50),
                    title: Text('Getting a rough location...'),
                    subtitle: Text('This allows Quarantined to track the rough location of this hotspot...'),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    } else {
      widgets.add(new LinearProgressIndicator());
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: buildActions(),
        elevation: 0,
        title: new Text(
          'Location',
        ),
      ),
      body: new Container(
        child: new SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildWidgets(),
          )
        )
      ),
    );
  }
}