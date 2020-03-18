import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../helpers/router.dart';
import '../../helpers/layers.dart';
import '../../helpers/hotspots.dart';
import '../../helpers/user.dart';

class ReportGeolocateScreen extends StatefulWidget {
  Map<String, dynamic> routeData;
  ReportGeolocateScreen({this.routeData}) : super();

  @override
  _ReportGeolocateScreenState createState() => _ReportGeolocateScreenState();
}

class _ReportGeolocateScreenState extends State<ReportGeolocateScreen> with TickerProviderStateMixin {
  var routerHelper = RouterHelper();
  var layerHelper = LayersHelper();
  var hotspotsHelper = HotspotHelper();
  var userHelper = UserHelper();
  
  bool loaded = false;
  bool showLocationCard = false;
  bool showGeolocatedCard = false;
  bool showReadyCard = false;
  bool showSubmissionInformation = false;

  Map<String, dynamic> layers;
  String layerId;
  List<dynamic> fetchedLayers;
  Map<String, dynamic> selectedLayer;
  Location location = new Location();
  LocationData discoveredLocation;

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
      findGeolocation();

      setState(() {
        showLocationCard = true;
      });
    });

    setState(() {
      loaded = true;
    });
  }

  findGeolocation() async {
    discoveredLocation = await location.getLocation();

    Timer(Duration(seconds: 2), () {
      setState(() {
        showSubmissionInformation = true;
      });
    });

    setState(() {
      showGeolocatedCard = true;
      showReadyCard = true;
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
              title: Text(
                '${selectedLayer['friendlyName']} (${selectedLayer['technicalName']})',
                style: Theme.of(context).textTheme.title,
              ),
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
                    title: Text(
                      'Getting a rough location...',
                      style: Theme.of(context).textTheme.title
                    ),
                    subtitle: Text('This allows Quarantined to track the rough location of this hotspot...'),
                  ),
                ],
              ),
            ),
          ),
        )
      );

      widgets.add(
        AnimatedSize(
          duration: Duration(milliseconds: 500),
          vsync: this,
          curve: Curves.fastOutSlowIn,
          child: Container(
            height: showGeolocatedCard ? null : 0,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.location_on, size: 50),
                    title: Text(
                      'We\'ve got it!',
                      style: Theme.of(context).textTheme.title
                    ),
                    subtitle: Text('Thank you. This allows us to map this data.'),
                  ),
                ],
              ),
            ),
          ),
        )
      );

      widgets.add(
        AnimatedSize(
          duration: Duration(milliseconds: 500),
          vsync: this,
          curve: Curves.fastOutSlowIn,
          child: Container(
            height: showReadyCard ? null : 0,
            child: GestureDetector(
              onTap: () async {
                var r = await hotspotsHelper.pushHotspot(
                  anonymousUserId: userHelper.firebaseUser.uid,
                  layerId: layerId,
                  latitude: discoveredLocation.latitude,
                  longitude: discoveredLocation.longitude
                );
                
                print('r: $r');
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Card(
                color: Colors.greenAccent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.check, size: 50),
                      title: Text(
                        'Ready to report.',
                        style: Theme.of(context).textTheme.title
                      ),
                      subtitle: Text(
                        'Tap here to submit this hotspot.'
                      ),
                    ),
                  ],
                ),
              ),
            ),
            )
        )
      );

      widgets.add(
        AnimatedSize(
          duration: Duration(milliseconds: 500),
          vsync: this,
          curve: Curves.fastOutSlowIn,
          child: Container(
            height: showSubmissionInformation ? null : 0,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Just a reminder...',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text(
                      'You are anonymous and we cannot identity you. This data will be used to build a global map of infections, that can be used by you, emergency services, educational institutions and governments for the greater good.',
                      style: TextStyle(
                        color: Colors.green
                      ),
                    ),
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