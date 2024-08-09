import 'dart:convert';
import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_course/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleMessage(RemoteMessage message) async {
  developer.log('Title: ${message.notification?.title}', name: 'handleMessage');
  developer.log('Body: ${message.notification?.body}', name: 'handleMessage');
  developer.log('Payload: ${message.data}', name: 'handleMessage');
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for imp. notif.',
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  String fCMToken = '';
  Future<void> firebaseInit() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    fCMToken = await _firebaseMessaging.getToken() ?? '';
    developer.log('Token: $fCMToken', name: 'FirebaseToken');

    initLocalNotifications();

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleMessage(message);
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }
}
