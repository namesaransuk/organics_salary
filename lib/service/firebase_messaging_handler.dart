import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/notification_controller.dart';
import 'package:organics_salary/main.dart';

class FirebaseMessagingHandler {
  static Map<String, dynamic>? pendingNotificationData;

  static Future<void> initialize() async {
    // ตั้งค่า Firebase Messaging
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // RemoteMessage? initialMessage = await messaging.getInitialMessage();

    // ขออนุญาตแจ้งเตือน (iOS)
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // กำหนดฟังก์ชันเมื่อกด Notification (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // แสดง Notification เมื่อแอพเปิดอยู่
      _showNotification(message);
    });

    // กำหนดฟังก์ชันเมื่อกด Notification (Background/Closed App)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationNavigation(message.data);
    });

    // จัดการ Notification เมื่อแอพปิดอยู่ (Terminate)
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      pendingNotificationData = initialMessage.data;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed('/pin');
      });
      // handleNotificationNavigation(initialMessage.data);
    }
  }

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    // ✅ Combine settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidSettings,
      iOS: iosSettings, // 👈 ต้องเพิ่มตรงนี้
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        print('Test payloadddddddddd ${payload}');

        if (payload != null) {
          final data = jsonDecode(payload);
          handleNotificationNavigation(
              data); // 👈 นำทางตามข้อมูลจาก notification
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    final payload = response.payload;
    print('Test payloadddddddddd ${payload}');

    if (payload != null) {
      final data = jsonDecode(payload);
      handleNotificationNavigation(data);
    }
  }

  static void handleNotificationNavigation(Map<String, dynamic> data) async {
    // ตรวจสอบ payload และนำทาง
    print('Test Notiiiiiiiiiiii ${data['route']}');
    if (data['route'] != null) {
      final NotificationController notificationController =
          Get.put(NotificationController());
      await notificationController.readUpdate(data['id']);
      Get.offAllNamed('/home');

      Future.delayed(Duration(milliseconds: 100), () {
        Get.toNamed(
          data['route'],
          arguments: data['module_id'] != null ? data['module_id'] : null,
        );
      });
    }
  }

  static void _showNotification(RemoteMessage message) async {
    final notification = message.notification;
    // final data = message.data;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'General Notifications',
      channelDescription: 'แสดงแจ้งเตือนทั่วไป',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      notification?.title ?? 'แจ้งเตือน',
      notification?.body ?? '',
      platformChannelSpecifics,
      payload:
          jsonEncode(message.data), // 👈 ส่งข้อมูลไปให้ใช้ตอนกด notification
    );
  }
}
