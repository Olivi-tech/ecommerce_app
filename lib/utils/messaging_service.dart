import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/custom_notification.dart';

class MessagingService {
  static Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');
  }

  static messageListener({required BuildContext context}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification?.body}');
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return CustomNotification(
                  title: "${message.notification?.title}",
                  body: "${message.notification?.body}");
            }));
      }
    });
  }

  static sendPushMessageToWeb() async {
    try {
      await http
          .post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAAQg4vRrM:APA91bEEbQaNEjLpb4jbGChmC9LD4HlL5NElOis3ABrwVGaVM3tJwt4Vco5BoyvVFOGtGdrSIf3_Pn3vLGnTMWZMhFyV__TpbgJBJEk0kK22Y1O7Dm7fVy5tD8G3qTXJsAKJFOkDSqfN'
            },
            body: json.encode({
              'to':
                  "dXUOIIe9_7zF96yWAs4Ul5:APA91bG3v61HA7XKL5G-qDe4hoHcLYXrSk4ITRG1iKMWDhkM5Q7kWAKtC2IQfW563jskpkyjXKzAH5AdTJESX-8vxuJNSxbsNxrvnlmh07k4kMTZRazpMM2qUZDDg2zYIoD1tJVffHRN",
              "notification": {
                "title": "Push Notification",
                "body": "Firebase  push notification"
              }
            }),
          )
          .then((value) => log(value.body));
      log('FCM request for web sent!');
    } catch (e) {
      log(e.toString());
    }
  }
}
