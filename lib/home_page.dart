import 'package:flutter/material.dart';
import 'package:flutter_notifications/custom_button.dart';
import 'package:flutter_notifications/local_notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //NotificationService notificationService = NotificationService();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  ///Coding Orbit
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
    //notificationService.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlutterLogo(size: size.width * 0.3),
              const Text(
                "Flutter Notification",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  CustomButton(
                    iconData: Icons.notifications,
                    text: "Show Notification",
                    onPressed: () async {
                      await service.showNotification(
                          id: 0, title: "title", body: 'body');
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    iconData: Icons.notifications_active,
                    text: "Schedule Notification",
                    onPressed: () async {
                      print("Setting notification");

                      await service.showScheduledNotification(
                          id: 0,
                          title: "Notification title",
                          body: "Notification body",
                          seconds: 10);

                      print("Done showing notification");
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    iconData: Icons.delete,
                    text: "Remove Notification",
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
