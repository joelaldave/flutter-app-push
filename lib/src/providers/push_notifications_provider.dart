import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajeStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream => _mensajeStreamController.stream;

  static Future<dynamic> onbackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();

    final token = await _firebaseMessaging.getToken();

    print('====================FCM Token ==================');
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onbackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('==========================onmesage');
    //print('mensaje : $message');

    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajeStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('==========================onLaunch');
    //print('mensaje : $message');
    final argumento = message['data']['comida'];
    _mensajeStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('==========================onResume');
    //print('mensaje : $message');
    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajeStreamController.sink.add(argumento);
  }

  dispose() {
    _mensajeStreamController?.close();
  }
}
