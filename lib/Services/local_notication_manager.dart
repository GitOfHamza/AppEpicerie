import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initilize

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("app_logo");

    IOSInitializationSettings iosInitializationSettings =
        const IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Instant Notifications
  Future instantNofitication() async {
    var android = const AndroidNotificationDetails("id", "channel");

    var ios = const IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo instant notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Image notification
  Future imageNotification() async {
    var bigPicture = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("app_logo"),
        largeIcon: DrawableResourceAndroidBitmap("app_logo"),
        contentTitle: "image Logo Notification",
        summaryText: "Welcome in NiceShop",
        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails("id", "channel",
        styleInformation: bigPicture);

    var platform = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "image Logo Notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

  //Stylish Notification
  Future stylishNotification() async {
    var android = const AndroidNotificationDetails("id", "channel",
        color: Colors.deepOrange,
        enableLights: true,
        enableVibration: true,
        largeIcon: DrawableResourceAndroidBitmap("app_logo"),
        styleInformation: MediaStyleInformation(
            htmlFormatContent: true, htmlFormatTitle: true));

    var platform = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Demo Stylish notification", "Tap to do something", platform);
  }

  //Sheduled Notification

  Future sheduledNotification() async {
    var interval = RepeatInterval.everyMinute;
    var bigPicture = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("app_logo"),
        largeIcon: DrawableResourceAndroidBitmap("app_logo"),
        contentTitle: "Demo image notification",
        summaryText: "This is some text",
        htmlFormatContent: true,
        htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails("id", "channel",
        styleInformation: bigPicture);

    var platform = NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        "Demo Sheduled notification",
        "Tap to do something",
        interval,
        platform);
  }

  //Cancel notification

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
