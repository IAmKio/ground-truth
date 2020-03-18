import 'package:flutter/material.dart';

import '../../../helpers/router.dart';
import '../../../helpers/statistics.dart';

class DataBrowserScreen extends StatefulWidget {
  const DataBrowserScreen() : super();

  @override
  _DataBrowserScreenState createState() => _DataBrowserScreenState();
}

class _DataBrowserScreenState extends State<DataBrowserScreen> with TickerProviderStateMixin {
  var routerHelper = RouterHelper();
  var statisticsHelper = StatisticsHelper();

  bool loaded = true;
  bool showStatsCards = false;

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    await statisticsHelper.fetchStatistics();

    setState(() {
      loaded = true;
      showStatsCards = true;
    });
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];
    List<dynamic> stats = statisticsHelper.statistics['statistics'];

    stats.forEach((stat) {
      widgets.add(
        AnimatedSize(
          duration: Duration(milliseconds: 500),
          vsync: this,
          curve: Curves.fastOutSlowIn,
          child: Container(
            height: showStatsCards ? null : 0,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${stat['name']}: ${stat['count']}' ,
                      style: Theme.of(context).textTheme.title
                    ),
                    subtitle: Text(stat['description']),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    });

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