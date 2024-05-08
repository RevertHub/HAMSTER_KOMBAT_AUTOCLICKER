//import 'package:disaster_admin/screen/notification_detail_screem.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppNotificationsScreen extends StatefulWidget {
  const AppNotificationsScreen({Key? key}) : super(key: key);

  @override
  _AppNotificationsScreenState createState() => _AppNotificationsScreenState();
}

class _AppNotificationsScreenState extends State<AppNotificationsScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<String> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.notification?.title}");
      setState(() {
        _notifications.add(_getMessageText(message));
        _saveNotifications();
      });
    });

    

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification?.title}");
      setState(() {
        _notifications.add(_getMessageText(message));
        _saveNotifications();
      });
    });

    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });
  }

  Future<void> _loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifications = prefs.getStringList('notifications') ?? [];
    });
  }

  Future<void> _saveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notifications', _notifications);
  }

  String _getMessageText(RemoteMessage message) {
    // Extract notification text from message
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';
    return '$title: $body';
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => NotificationDetailScreen(
            //         title: _notifications[index].split(":")[0],
            //         content: _notifications[index].split(":")[1].trim(),
            //       ),
            //     ),
            //   );
            // },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                height: 100,
                width: 360,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.blueGrey[200]!.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _notifications[index].split(":")[0], // Custom text
                            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _notifications[index].split(":")[1].trim(),
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}