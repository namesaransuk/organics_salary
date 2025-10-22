import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/emp_attendance_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';

class TimeHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());

  RxString c_startDate = ''.obs;
  RxString c_endDate = ''.obs;

  RxString searchStartDate = ''.obs;
  RxString searchEndDate = ''.obs;

  RxString monthName = 'เดือน'.obs;
  RxString yearName = 'ปี'.obs;
  RxString ddMonthName = 'เดือน'.obs;
  RxString ddYearName = 'ปี'.obs;
  var timeHistoryList = RxList<dynamic>();
  var empAttendanceList = RxList<EmpAttendanceModel>();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.find<GetConnect>();
  final box = GetStorage();

  RxList flowLeaveList = RxList<dynamic>([]);
  RxList workTimeList = RxList<dynamic>([]);
  RxList holidaysList = RxList<dynamic>([]);

  void printLongJson(String text, {int chunkSize = 800}) {
    for (var i = 0; i < text.length; i += chunkSize) {
      print(text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }

  Future<void> loadFlowLeave() async {
    try {
      var response = await connect.post(
        '$baseUrl/select/flow/of/leave',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'whereData': {
            "approve_type": 1,
            "approve_type_name": "อนุมัติใบลา",
            "step_approve_number": 1
          },
        },
      );

      var responseBody = response.body;
      flowLeaveList.assignAll(
          (responseBody['data']['approveFlowList'] as List).cast<dynamic>());
      workTimeList.assignAll([responseBody['data']['worktime']]);
      holidaysList.assignAll(
          (responseBody['data']['holidaysData'] as List).cast<dynamic>());
    } catch (e) {
      print(e);
    }
  }

  void getMonthName(String mName) {
    ddMonthName.value = mName;
    monthName.value = mName;
  }

  Future<void> loadInitial() async {
    await loadFlowLeave(); // ✅ โหลดวันหยุดให้พร้อมก่อน
    await loadData(); // แล้วค่อยโหลดรายการเวลา
  }

  void getYear(String yName) {
    ddYearName.value = yName;
    yearName.value = yName;
  }

  void loadStatus(BuildContext context) async {
    loadingController.dialogLoading();

    // Get.back();
    try {
      final now = DateTime.now();
      var response = await connect.post(
        '$baseUrl/schedule/refresh/zk/time/attendance',
        // 'https://organicsplusapi.organicscosme.com/api/app/schedule/refresh/zk/time/attendance',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          // 'emp_id': 43, //kn
          'day': now.day.toString().padLeft(2, '0'),
          'month': now.month.toString().padLeft(2, '0'),
          'year': now.year.toString(),
        },
      );
      Get.back();

      var responseBody = response.body;
      print(responseBody);

      if (responseBody['status_code'] == '200') {
        loadData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'])),
        );
        print('failed with status code: ${responseBody['status_code']}');
      }
    } catch (e) {
      // Get.back();
      print(e);
      alertEmptyData(
          'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> loadData() async {
    loadingController.dialogLoading();
    timeHistoryList.clear();
    try {
      final response = await connect.post(
        '$baseUrl/workRecord/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'start_date': searchStartDate.value,
          'end_date': searchEndDate.value,
        },
      );

      final Map<String, dynamic> responseBody = response.body;
      printLongJson(jsonEncode(responseBody));

      if (response.statusCode == 200) {
        final list = responseBody['data']['data'];
        timeHistoryList.assignAll(list);
      } else {
        timeHistoryList.clear();
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      print(e);
    } finally {
      // ✅ ปิด dialog แค่ครั้งเดียวเสมอ
      Get.back();
    }
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
