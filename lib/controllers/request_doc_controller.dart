import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:flutter/material.dart';

class RequestDocController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();

  final RxList<Map<String, dynamic>> requestList = <Map<String, dynamic>>[].obs;
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  final connect = Get.put(GetConnect());

  final emp_id = GetStorage().read('id');

  var transectionSuccessList = <Map<String, dynamic>>[].obs;

  RxString inputCause = ''.obs; // note1
  RxBool salaryCert = false.obs; // หนังสือรับรองเงินเดือน
  RxBool workCert = false.obs; // หนังสือรับรองการทำงาน

  File file = File('/path/to/json_output.json');

  final inputCauseController = TextEditingController();

  String lastMessage = ''; // ✅ เก็บข้อความล่าสุดจาก API

  void printLongJson(String text, {int chunkSize = 800}) {
    for (var i = 0; i < text.length; i += chunkSize) {
      print(text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }

  Future<bool> sendRequest() async {
    loadingController.dialogLoading();
    final empId = box.read('id');
    List<Map<String, dynamic>> requestList = [];

    if (salaryCert.value) {
      requestList.add({
        "emp_id": empId,
        "doc_type": 1,
        "detail": inputCause.value,
      });
    }
    if (workCert.value) {
      requestList.add({
        "emp_id": empId,
        "doc_type": 2,
        "detail": inputCause.value,
      });
    }

    bool success = true;

    try {
      for (var req in requestList) {
        var response = await connect.post(
          "$baseUrl/request/certificate",
          req,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        );
        final responseBody = response.body; // Map<String, dynamic>
        printLongJson(jsonEncode(responseBody));

        if (response.statusCode == 200) {
          lastMessage = response.body?['message'] ?? "สำเร็จ";
          success = true;
        } else if (response.statusCode == 409) {
          lastMessage =
              response.body?['message'] ?? "มีการส่งคำร้องซ้ำในเดือนนี้";
          success = false;
        } else if (response.statusCode == 404) {
          lastMessage =
              response.body?['message'] ?? "ส่งคำขอไม่สำเร็จ";
          success = false;
        } else {
          lastMessage = "เกิดข้อผิดพลาด\nไม่สามารถบันทึกได้ กรุณาติดต่อแอดมิน";
          success = false;
        }
      }
    } catch (e) {
      lastMessage = e.toString();
      success = false;
    } finally {
      Get.back();
      clear();
    }

    return success;
  }

  @override
  void onClose() {
    inputCauseController.dispose();
    super.onClose();
  }

  void clear() {
    salaryCert.value = false;
    workCert.value = false;
    inputCauseController.clear(); // เคลียร์ข้อความ
  }

// void printLongJson(String text, {int chunkSize = 800}) {
//   for (var i = 0; i < text.length; i += chunkSize) {
//     print(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
//   }
// }

  Future<void> loadDataSuccess() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/status/certificate/list',
        {
          'emp_id': box.read('id'),
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      Get.back();

      // final responseBody = response.body; // Map<String, dynamic>
      // printLongJson(jsonEncode(responseBody));
      // ตรวจสอบว่า response.body['data'] มีค่า
      if (response.body != null && response.body['data'] != null) {
        transectionSuccessList.assignAll(
          List<Map<String, dynamic>>.from(response.body['data']),
        );
      } else {
        transectionSuccessList.clear();
        print("No data found in response");
      }
    } catch (e) {
      Get.back();
      print("ERROR: $e");
      transectionSuccessList.clear();
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadData() {}
}

//-------------------------------------------------------------------------------------
Future<bool> alertConfirmExit(String title, String detail) async {
  final result = await Get.dialog<bool>(
    AlertDialog(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        width: double.infinity,
        color: AppTheme.ognSmGreen,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      content: Text(detail, textAlign: TextAlign.center),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(result: false),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          child: const Text(
            "ยกเลิก",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: true),
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ognSmGreen),
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
  return result ?? false;
}

void alertEmptyData(String title, String detail) {
  Get.dialog(
    AlertDialog(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        width: double.infinity,
        color: AppTheme.ognSmGreen,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      content: Text(
        detail,
        textAlign: TextAlign.center,
      ),
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
