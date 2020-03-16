import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../helpers/router.dart';

class ReportScreen extends StatefulWidget {
  Map<String, dynamic> routeData;
  ReportScreen({this.routeData}) : super();

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var routerHelper = RouterHelper();
  bool loaded = false;
  Map<String, dynamic> layers;

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    print('Report Screen starting...');

    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/layers';
    var response = await http.get(url);
    layers = jsonDecode(response.body);

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
      List<dynamic> innerLayers = layers['layers'];
      print(innerLayers);

      innerLayers.forEach((layer) {
        widgets.add(Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.bug_report, size: 50),
                title: Text('${layer['friendlyName']} (${layer['technicalName']})'),
                subtitle: Text(layer['shortDescription']),
              ),
            ],
          ),
        ));
      });
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
          'Report',
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