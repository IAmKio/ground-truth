
import 'package:flutter/material.dart';
import '../../../helpers/router.dart';

class DataBrowserScreen extends StatefulWidget {
  const DataBrowserScreen() : super();

  @override
  _DataBrowserScreenState createState() => _DataBrowserScreenState();
}

class _DataBrowserScreenState extends State<DataBrowserScreen> {
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
    print('Rebuilding: Data Browser Pane');

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