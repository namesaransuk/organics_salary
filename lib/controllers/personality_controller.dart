import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

import 'package:organics_salary/theme.dart';

class PersonalityController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());

  var message = ''.obs;
  var character = {}.obs;

  void printLongJson(String text, {int chunkSize = 800}) {
    for (var i = 0; i < text.length; i += chunkSize) {
      print(text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }

  void loadData() async {
    loadingController.dialogLoading();
    try {
      var response = await connect.post(
        '$baseUrl/employee/character',
        {
          'emp_id': box.read('id'),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      Get.back();

      final responseBody = response.body;
      printLongJson(jsonEncode(responseBody));

      if (responseBody['statusCode'] == 200) {
        final data = response.body['data'];
        character.value = data['character'] ?? {};
        message.value = '';
      } else {
        // เอา message ที่ได้จาก API มาเก็บไว้
        message.value = responseBody['message'] ?? 'ไม่พบข้อมูล';
        character.clear();
      }
    } catch (e, stackTrace) {
      Get.back();
      print('Error: $e');
      debugPrintStack(stackTrace: stackTrace);
      message.value = 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งภายหลัง';
      character.clear();
    }
  }

// ================================================================

  void alertEmptyData(String title, String detail) {
    Get.dialog(
      AlertDialog(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: AppTheme.ognSmGreen,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Text(detail),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.ognSmGreen,
            ),
            child: const Text(
              "ตกลง",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
