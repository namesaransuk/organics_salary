import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/theme.dart';

class LeaveApproveController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());

  var leaveApproveList = RxList([]);
  var leaveApproveHistoryList = RxList([]);
  var leaveApproveSectionList = RxList([]);
  var leaveTotalUsedList = RxList([]);

  RxString c_startDate = RxString('');
  RxString c_endDate = RxString('');
  RxString searchStartDate = RxString('');
  RxString searchEndDate = RxString('');
  RxString diffTime = RxString('');

  RxList flowLeaveList = RxList<dynamic>([]);
  RxList workTimeList = RxList<dynamic>([]);
  RxList holidaysList = RxList<dynamic>([]);
  RxList dataList = RxList<dynamic>([]);

  RxString detailApprove = RxString('');
  RxString userAprove = RxString('');

  Future<void> loadLeaveTotalUsed(empId) async {
    try {
      var response = await connect.post(
        '$baseUrl/leave/emp/limit',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': empId,
        },
      );

      var responseBody = response.body;

      leaveTotalUsedList
          .assignAll(responseBody['data']['leaveSummary'] as List<dynamic>);
    } catch (e) {
      print(e);
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

  Future<void> loadData(
    String startDate,
    String endDate,
  ) async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/select/flow/of/leave/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          "emp_id": box.read('id'),
          "company_id": box.read('companyId'),
          "department_id": box.read('departmentId'),
          'start_date': startDate,
          'end_date': endDate,
        },
      );
      Get.back();

      var responseBody = response.body;

      if (responseBody['statusCode'] == '200') {
        dataList.value = responseBody['data'] as List<dynamic>;

        leaveApproveHistoryList.assignAll(
          dataList
              .where((item) =>
                  item['status_logs']['status_number'] == 4 ||
                  item['status_logs']['status_number'] == 5)
              .toList(),
        );

        leaveApproveList.assignAll(
          dataList
              .where((item) =>
                  item['status_logs']['status_number'] != 4 &&
                  item['status_logs']['status_number'] != 5)
              .toList(),
        );
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      // Get.back();
      print('Error: $e');
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void printLongJson(String text, {int chunkSize = 800}) {
    for (var i = 0; i < text.length; i += chunkSize) {
      print(text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }
  //แบบเก่า 03/10/68
  // Future<void> loadDataSection() async {
  //   loadingController.dialogLoading();
  //   print('${box.read('id')}');

  //   try {
  //     var response = await connect.post(
  //       '$baseUrl/select/flow/of/leave/list',
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       {
  //         "emp_id": box.read('id'),
  //         "company_id": box.read('companyId'),
  //         "department_id": box.read('departmentId'),
  //         "position_id": null,
  //         // "treId": '586',
  //         'start_date': searchStartDate.value,
  //         'end_date': searchEndDate.value,
  //       },
  //     );

  //     Get.back();

  //     var responseBody = response.body;
  //     // printLongJson(jsonEncode(responseBody));

  //     if (responseBody['statusCode'] == '200') {
  //       // dataList.value = responseBody['data'] as List<dynamic>;

  //       leaveApproveSectionList
  //           .assignAll(responseBody['data'] as List<dynamic>);
  //     } else {
  //       print('failed with status code: ${responseBody['statusCode']}');
  //       alertEmptyData('แจ้งเตือน',
  //           responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
  //     }
  //   } catch (e) {
  //     // Get.back();
  //     print('Error: $e');
  //     alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
  //   }
  // }

  Future<void> loadDataSection({dynamic treId}) async {
    loadingController.dialogLoading();

    int? treIdInt;
    if (treId is int) {
      treIdInt = treId;
    } else if (treId is String) {
      treIdInt = int.tryParse(treId);
    }

    final body = {
      "emp_id": box.read('id'),
      "company_id": box.read('companyId'),
      "department_id": box.read('departmentId'),
      "position_id": null,
      "start_date": searchStartDate.value,
      "end_date": searchEndDate.value,
      "treId": treIdInt, // ← ส่ง treId ให้ API
    };

    try {
      final response = await connect.post(
        '$baseUrl/select/flow/of/leave/list',
        body, // ← body เป็นอาร์กิวเมนต์ตัวที่ 2
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      Get.back();

      final responseBody = response.body;
      printLongJson(jsonEncode(responseBody));
      final ok = responseBody['statusCode'] == 200 ||
          responseBody['statusCode'] == '200';

      if (ok && responseBody['data'] is List) {
        leaveApproveSectionList.assignAll(responseBody['data'] as List);
      } else {
        leaveApproveSectionList.clear();
        alertEmptyData('แจ้งเตือน',
            '${responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง'}');
      }
    } catch (e) {
      Get.back();
      leaveApproveSectionList.clear();
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
      print('Error loadDataSection: $e');
    }
  }

  Future<void> sendData(mode, item) async {
    print(searchStartDate.value);
    print(searchEndDate.value);
    loadingController.dialogLoading();
    // Get.back();
    // Get.back();
    // await loadData(
    //   searchStartDate.value,
    //   searchEndDate.value,
    // );
    // loadLeaveTotalUsed();
    // loadFlowLeave();
    // Get.offAndToNamed('/status-success');

    try {
      final responseStatus =
          await connect.post('$baseUrl/select/flow/of/leave', headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, {
        "emp_id": box.read('id'),
        "where_data": {
          "approve_type_id": 1,
          "approve_type_name": "อนุมัติใบลา",
          "step_approve_number": 4
        }
      });
      print(responseStatus);

      if (responseStatus.statusCode == 200) {
        final configData = responseStatus.body;
        final statusData = configData['data']['approveFlowList'];

        final selectedStatus = statusData.firstWhere(
          (item) => item['flow_step'] == 2,
          orElse: () => null,
        );

        int stepApproveNumber = 0;
        String stepApproveName = '';

        if (mode == 1) {
          stepApproveNumber = selectedStatus['step_approve_number'];
          stepApproveName = selectedStatus['step_approve_name'];
        } else {
          stepApproveNumber = selectedStatus['status_reject_number'];
          stepApproveName = selectedStatus['status_reject_name'];
        }

        var response = await connect.post(
          '$baseUrl/approve/flow/requests',
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          {
            "detailLeave": {
              "id": item['id'],
              "emp_id": item['emp_id'],
            },
            mode == 1 ? "step_approve_number" : "status_reject_number":
                stepApproveNumber,
            mode == 1 ? "step_approve_name" : "status_reject_name":
                stepApproveName,
            "detail": detailApprove.value != '' ? detailApprove.value : null,
            "language": "en",
            "emp_id": box.read('id'),
            "route": "leave-section"
          },
        );

        Get.back();
        Get.back();
        // Get.back(result: true);
        // Get.back(result: true);

        print(response.body);

        var responseBody = response.body;

        if (responseBody['statusCode'] == '200') {
          print('success');
          await loadData(
            searchStartDate.value,
            searchEndDate.value,
          );
          // loadLeaveTotalUsed();
          // loadFlowLeave();
          Get.offAndToNamed('/status-success');
        } else {
          // loadData();
          Get.offAndToNamed('/status-cancel');
          // Get.toNamed(page)
        }
      } else {
        Get.back();
        print("ไม่สามารถดึงข้อมูล status ได้");
        alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      Get.offAndToNamed('/status-cancel');
      print('Error: $e');
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
