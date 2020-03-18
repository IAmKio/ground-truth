import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../helpers/router.dart';
import '../../../helpers/annoucements.dart';

import '../../../classes/home.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen() : super();

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> with TickerProviderStateMixin {
  var routerHelper = RouterHelper();
  var announcementsHelper = AnnouncementsHelper();

  bool showShareCard = false;
  bool showAnnouncementsCards = false;

  @override
  void initState() {
    super.initState();

    start();
  }

  void start() async {
    new Timer(new Duration(milliseconds: 250), () {
      setState(() {
        showShareCard = true;
      });
    });

    await announcementsHelper.fetchAnnouncements()
    .then((v) {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          showAnnouncementsCards = true;
        });
      });
    });

    if (this.mounted) {
      setState(() {});
    }
  }

  List<Widget> buildWidgets() {
    List<Widget> widgets = [];
    Home homeClass = Provider.of<Home>(context);

    double _height = 0;

    if (homeClass.online) {
      _height = null;
    }

    widgets.add(
      new AnimatedSize(
        child: new Container(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.check, size: 50),
                  title: Text('Connected.'),
                  subtitle: Text("You're anonymously connected to our network."),
                ),
              ],
            ),
          ),
          height: _height,
        ),
        duration: new Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        vsync: this
      )
    );

    widgets.add(
      new AnimatedSize(
        child: new Container(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.favorite, size: 50),
                  title: Text('Share the movement'),
                  subtitle: Text("This app works best when everyone is helping. Tap here to share this app with your friends and family."),
                ),
              ],
            ),
          ),
          height: showShareCard ? null : 0,
        ),
        duration: new Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        vsync: this
      )
    );

    if (announcementsHelper.loaded) {
      List<dynamic> announcements = announcementsHelper.announcements['announcements'];

      announcements.forEach((announcement) {
        widgets.add(
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            vsync: this,
            curve: Curves.fastOutSlowIn,
            child: Container(
              height: showAnnouncementsCards ? null : 0,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        '${announcement['title'] ?? ''}' ,
                        style: Theme.of(context).textTheme.title
                      ),
                      subtitle: Text(announcement['description'] ?? ''),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      });
    }

    return widgets;
  }

  List<Widget> buildActions() {
    List<Widget> widgets = [];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding: Information Pane');

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