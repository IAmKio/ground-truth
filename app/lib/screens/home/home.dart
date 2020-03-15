import 'package:flutter/material.dart';

import '../../helpers/user.dart';

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

  InformationScreen informationScreen = new InformationScreen();
  MapScreen mapScreen = new MapScreen();
  DataBrowserScreen dataBrowserScreen = new DataBrowserScreen();

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    userHelper.signInAnonymously();
    userHelper.getFcmTokenId();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.my_location),
          onPressed: () {

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