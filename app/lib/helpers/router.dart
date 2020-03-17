import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../screens/home/home.dart';
import '../screens/report/report.dart';
import '../screens/report/geolocate.dart';
import '../screens/map/mapBrowser.dart';

class RouterHelper {
  static final RouterHelper _singleton = new RouterHelper._internal();
  final router = Router();
  bool initialised = false;

  var homeScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return HomeScreen(routeData: params);
  });

  var reportScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return ReportScreen(routeData: params);
  });

  var reportGeolocateScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return ReportGeolocateScreen(routeData: params);
  });

  factory RouterHelper() {
    print('Helpers: Router');

    return _singleton;
  }

  RouterHelper._internal();
   init() {
    print('Helpers: Router - initialising...');

    if (initialised != true) {
      router.define(
        '/home',
        handler: homeScreenHandler,
        transitionType: TransitionType.native
      );

      router.define(
        '/report',
        handler: reportScreenHandler,
        transitionType: TransitionType.native
      );

      router.define(
        '/report-geolocation/:layerId',
        handler: reportGeolocateScreenHandler,
        transitionType: TransitionType.native
      );

      print('Helpers: Router - Finished initialised routing.');  
      initialised = true;
    } else {
      print('Helpers: Router - already initalised.');
    }
  }
}