class Hotspot {
  String _layerId;
  double _latitude;
  double _longitude;
  String _anonymousUserId;
  String _geohash;

  String get layerId => _layerId;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get anonymousUserId => _anonymousUserId;
  String get geohash => _geohash;

  set layerId(String layerId) {
    _layerId = layerId;
  }

  set latitude(double latitude) {
    _latitude = latitude;
  }

  set longitude(double longitude) {
    _longitude = longitude;
  }

  set anonymousUserId(String anonymousUserUd) {
    _anonymousUserId = anonymousUserUd;
  }

  set geohash(String geohash) {
    _geohash = geohash;
  }
}