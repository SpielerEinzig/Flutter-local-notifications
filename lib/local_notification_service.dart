import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final _localNotificationService = FlutterLocalNotificationsPlugin();

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    _localNotificationService.initialize(initializationSettings);
  }

  onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("ID: $id");
  }

  onSelectNotification(String? payload) {
    print("Payload: $payload");

    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }

  _notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "channel_id",
      "channel_name",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails();

    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
  }

  showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();

    await _localNotificationService.show(id, title, body, details);
  }

  showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
  }) async {
    final details = await _notificationDetails();

    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        DateTime.now().add(
          Duration(seconds: seconds),
        ),
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  showNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final details = await _notificationDetails();

    await _localNotificationService.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
}
