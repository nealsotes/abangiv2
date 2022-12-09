import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notif {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //show notification to a specific user with a specific id

  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      //     actions: <AndroidNotificationAction>[
      //   AndroidNotificationAction('your channel i', title),
      // ]
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var approvedUser = localStorage.getString('approvedUser');
    var currentUser = localStorage.getString('user');
    if (approvedUser == currentUser) {
      await fln.show(id, title, body, platformChannelSpecifics,
          payload: payload);
    }

    //show if user is on the app
  }
}
