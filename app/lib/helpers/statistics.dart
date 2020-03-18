import 'dart:convert';

import 'package:http/http.dart' as http;

class StatisticsHelper {
  static final StatisticsHelper _singleton = new StatisticsHelper._internal();

  Map<String, dynamic> statistics;
  bool loaded = false;
  
  factory StatisticsHelper() {
    return _singleton;
  }

  Future<dynamic> fetchStatistics() async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/statistics';
    var response = await http.get(url);
    print(response.body);
    print(response.statusCode);

    statistics = jsonDecode(response.body);
    loaded = true;

    return Future.value(statistics);
  }

  StatisticsHelper._internal();
}