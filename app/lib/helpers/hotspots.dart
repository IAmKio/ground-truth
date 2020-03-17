import 'dart:convert';

import 'package:http/http.dart' as http;

class HotspotHelper {
  static final HotspotHelper _singleton = new HotspotHelper._internal();

  Map<String, dynamic> latestHotspotReference;
  
  factory HotspotHelper() {
    return _singleton;
  }

  Future<dynamic> pushHotspot({String anonymousUserId, String layerId, double latitude, double longitude}) async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/ingest';
    var response = await http.post(
      url,
      body: {
        'anonymousUserId': anonymousUserId,
        'layerId': layerId,
        'latitude': latitude.toString(),
        'longitude': longitude.toString()
      }
    );

    print(response.body);
    print(response.statusCode);

    latestHotspotReference = jsonDecode(response.body);

    return Future.value(latestHotspotReference);
  }

  HotspotHelper._internal();
}