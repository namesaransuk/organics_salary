import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LogoutController extends GetxController {
  LoadingController loadingController = LoadingController();
  final box = GetStorage();
  var connect = Get.find<GetConnect>();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];

  void logout() async {
    loadingController.dialogLoading();

    await connect.post(
      '$baseUrl/employee/change/devicekey',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      {
        'emp_id': box.read('id'),
        'device_key': null,
      },
    );

    Get.deleteAll();
    GetStorage().erase();

    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    const String topic = 'news';

    try {
      // ข้ามบน iOS Simulator (ไม่มี APNs)
      final bool isIosSimulator = Platform.isIOS &&
          (await FirebaseMessaging.instance.getAPNSToken()) == null;

      // เอา deviceKey ที่คุณได้มาก่อนหน้านี้มาใช้ (เก็บใน box แล้ว)
      final String deviceKey = (box.read('deviceKey') ?? '').toString();

      if (!isIosSimulator && deviceKey.isNotEmpty) {
        await messaging.unsubscribeFromTopic(topic);
        debugPrint('Subscribed to topic: $topic');
      } else {
        debugPrint(
            'Skip subscribeToTopic: isIosSimulator=$isIosSimulator, deviceKey="$deviceKey"');
      }
    } catch (e) {
      debugPrint(
          'subscribeToTopic failed: $e'); // กัน [firebase_messaging/unknown]
    }

    print('Subscribed to topic: $topic');

    print('Unsubscribed to topic: $topic');

    await Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed('/login');
    });
  }
}
