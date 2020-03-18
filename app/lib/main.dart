import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './classes/home.dart';

import './screens/home/home.dart';
import './helpers/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var routerHelper = RouterHelper();
  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    routerHelper.init();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quarantined',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      theme: ThemeData(
        fontFamily: GoogleFonts.robotoMono().fontFamily,
        cardTheme: CardTheme(
          margin: EdgeInsets.only(bottom: 20)
        ),
        primarySwatch: Colors.yellow,
        
      ),
      home: ChangeNotifierProvider(
        create: (_) => new Home(),
        child: HomeScreen(routeData: {}),
      )
    );
  }
}
