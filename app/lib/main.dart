import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './classes/home.dart';

import './screens/home/home.dart';
import './helpers/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var routerHelper = RouterHelper();

  @override
  Widget build(BuildContext context) {
    routerHelper.init();

    return MaterialApp(
      title: 'Quarantined',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
