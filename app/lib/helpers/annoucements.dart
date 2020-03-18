import 'dart:convert';

import 'package:http/http.dart' as http;

class AnnouncementsHelper {
  static final AnnouncementsHelper _singleton = new AnnouncementsHelper._internal();

  Map<String, dynamic> announcements;
  bool loaded = false;
  
  factory AnnouncementsHelper() {
    return _singleton;
  }

  Future<dynamic> fetchAnnouncements() async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/announcements';
    var response = await http.get(url);
    print(response.statusCode);

    announcements = jsonDecode(response.body);
    loaded = true;

    return Future.value(announcements);
  }

  AnnouncementsHelper._internal();
}