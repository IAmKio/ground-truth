import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:location/location.dart';

class UserHelper {
  static final UserHelper _singleton = new UserHelper._internal();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  
  FirebaseUser firebaseUser;
  String fcmToken;
  LocationData lastKnownLocation;

  factory UserHelper() {
    return _singleton;
  }

  UserHelper._internal();

  Future<dynamic> signInAnonymously() async {
    try {
      AuthResult authResult = await FirebaseAuth.instance.signInAnonymously();
      firebaseUser = authResult.user;

      print('Successfully signed in anonymously: ${firebaseUser.uid}');
    } catch (e) {
      print('There was a problem signing in anonymously: $e');
    }

    Future.value(firebaseUser);
  }

  Future<dynamic> getFcmTokenId() async {
    fcmToken = await _firebaseMessaging.getToken()
    .then((onValue) {
      print('FCM Token found: $onValue');
      return onValue;
    })
    .catchError((onError) {
      print('There was an issue getting an FCM Token: $onError');
    });
  
    Future.value(fcmToken);
  }

  askForNotificationPermissons() {
    _firebaseMessaging.requestNotificationPermissions();
  }
}