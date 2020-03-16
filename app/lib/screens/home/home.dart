import 'package:flutter/material.dart';

import 'package:location/location.dart';

import '../../helpers/user.dart';
import '../../helpers/router.dart';

import '../home/tabs/information.dart';
import '../home/tabs/data-browser.dart';
import '../home/tabs/map.dart';

class HomeScreen extends StatefulWidget {
  Map<String, dynamic> routeData;

  HomeScreen({this.routeData}) : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userHelper = UserHelper();
  var routerHelper = RouterHelper();

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  InformationScreen informationScreen = new InformationScreen();
  MapScreen mapScreen = new MapScreen();
  DataBrowserScreen dataBrowserScreen = new DataBrowserScreen();

  @override
  void initState() {
    super.initState();

    start();
    setupGeolocation();
  }

  void start() async {
    userHelper.signInAnonymously();
    userHelper.getFcmTokenId();

    setState(() {});
  }

  void setupGeolocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      print('Service not enabled - requesting service...');
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Location service not enabled.');
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      print('Location permission denied - requesting...');
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        print('Location OK!');
        return;
      } else {
        print('Location permission denied.');
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.my_location),
          onPressed: () {
            routerHelper.router.navigateTo(context, '/report');
          }
        ),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.data_usage)),
              Tab(icon: Icon(Icons.map)),
            ],
          ),
          title: Text('Quarantined'),
        ),
        body: TabBarView(
          children: [
            informationScreen,
            dataBrowserScreen,
            mapScreen,
          ],
        ),
      ),
    );
  }
}