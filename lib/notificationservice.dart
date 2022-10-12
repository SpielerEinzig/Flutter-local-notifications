import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await fln.show(0, title, body, not);
  }

  scheduleNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin fln,
    required DateTime dateTime,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await fln.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      not,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAllNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
