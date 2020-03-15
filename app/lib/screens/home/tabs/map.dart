
import 'package:flutter/material.dart';
import '../../../helpers/router.dart';

class MapScreen extends StatefulWidget {
  const MapScreen() : super();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var routerHelper = RouterHelper();

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    setState(() {});
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];

    return widgets;
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildWidgets(),
        )
      )
    );
  }
}