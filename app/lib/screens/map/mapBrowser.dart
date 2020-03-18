import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/router.dart';
import '../../helpers/hotspots.dart';
import '../../helpers/user.dart';

class MapBrowserScreen extends StatefulWidget {
  Map<String, dynamic> routeData;
  MapBrowserScreen({this.routeData}) : super();

  @override
  _MapBrowserScreenState createState() => _MapBrowserScreenState();
}

class _MapBrowserScreenState extends State<MapBrowserScreen> {
  var routerHelper = RouterHelper();
  var hotspotsHelper = HotspotHelper();
  var userHelpers = UserHelper();

  List<dynamic> fetchedHotspots;
  GoogleMapController mapsController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  bool loaded = false;

  @override
  void initState() {
    super.initState();

    start();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.mapsController = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void start() async {
    fetchedHotspots = hotspotsHelper.latestHotspots['hotspots'];

    print(fetchedHotspots);
    setState(() {
      loaded = true;
    });
  }

  Widget buildWidgets() {
    Widget widget;

    fetchedHotspots.forEach((hotspot) {
      Map<String, dynamic> thisHotspot = hotspot;
      Map<String, dynamic> geolocation = thisHotspot['geopoint'];

      MarkerId markerId = new MarkerId(thisHotspot['hotspotId']);
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(geolocation['_latitude'], geolocation['_longitude'])
      );

      markers[markerId] = marker;
    });

    widget = GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(userHelpers.lastKnownLocation.latitude, userHelpers.lastKnownLocation.longitude),
        zoom: 5.0,
      ),
      markers: Set<Marker>.of(markers.values),
    );

    return widget;
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding: Map Pane');

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Container(
        child: buildWidgets()
      ),
    );
  }
}