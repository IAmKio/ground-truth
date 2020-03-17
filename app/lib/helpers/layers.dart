import 'dart:convert';

import 'package:http/http.dart' as http;

class LayersHelper {
  static final LayersHelper _singleton = new LayersHelper._internal();

  Map<String, dynamic> layers;
  
  factory LayersHelper() {
    return _singleton;
  }

  Future<dynamic> fetchLayers() async {
    var url = 'https://us-central1-wearequarantined.cloudfunctions.net/layers';
    var response = await http.get(url);
    print(response.body);
    print(response.statusCode);

    layers = jsonDecode(response.body);

    return Future.value(layers);
  }

  Map<String, dynamic> getLayerById(String layerId) {
    List<dynamic> innerLayers = layers['layers'];
    return innerLayers.firstWhere((l) => (l['layerId'] == layerId));
  }

  LayersHelper._internal();
}