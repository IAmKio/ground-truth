
import 'package:flutter/material.dart';
import '../../../helpers/router.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen() : super();

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
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