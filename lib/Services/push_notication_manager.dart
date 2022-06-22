import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationManager with ChangeNotifier{
  PushNotificationManager._();

  factory PushNotificationManager() => _instance;
  static final PushNotificationManager _instance = PushNotificationManager._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized == false) {
      String? token = await _firebaseMessaging.getToken();
      print("my new token ========== $token");

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: true,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: android.smallIcon,
                  // other properties...
                ),
              ));
        }
      });
      _initialized = true;
    }
  }
}
