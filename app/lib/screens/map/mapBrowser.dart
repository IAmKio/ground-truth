import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/router.dart';
import '../../helpers/hotspots.dart';

class MapBrowserScreen extends StatefulWidget {
  Map<String, dynamic> routeData;
  MapBrowserScreen({this.routeData}) : super();

  @override
  _MapBrowserScreenState createState() => _MapBrowserScreenState();
}

class _MapBrowserScreenState extends State<MapBrowserScreen> {
  var routerHelper = RouterHelper();
  var hotspotsHelper = HotspotHelper();

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
    });

    widget = GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(-33.852, 151.211),
        zoom: 11.0,
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