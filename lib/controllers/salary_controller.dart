import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/salary_model.dart';
import 'package:organics_salary/theme.dart';

class SalaryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var connect = Get.put(GetConnect());
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  final box = GetStorage();

  RxString c_startDate = ''.obs;
  RxString c_endDate = ''.obs;

  RxString monthSelected = ''.obs;
  RxString yearSelected = ''.obs;
  // var salaryList = RxList<dynamic>();
  var salaryList = RxString('');
  late RxList filteredSalaryList;

  var salarySectionList = RxList<SalaryModel>();

  RxList<String> selectedMonths = RxList<String>();
  RxString inputCause = RxString('');
  RxString formatDate = RxString('ยังไม่ได้เลือก');
  RxString usedDate = RxString('');

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        'https://salary.organicscosme.com/api/app/v1/pay/slip/check',
        {
          'employee_code': box.read('employeeCode'),
          // 'employee_code': 'DJ20240016',
          'month': monthSelected.toString(),
          'year': yearSelected.toString(),
        },
        headers: {
          'Authorization':
              'Bearer eyJpdiI6ImM0ZWhWY3pvK2VyeUdpS2RaVUxiU3c9PSIsInZhbHVlIjoiV3pRWWtzSHY2djgwcXArbFhNc3RvY2JjTitGenN0UVkrQVZMTWtFQ0RiT1pUc3JvRGVqV1J4QkN2Ym8yMHliViIsIm1hYyI6ImJkN2QzNGQ0ZWUyMzI4YjJjMWViNjg0MjBmYzBjMzI5MzRmNmYyNGEzNTVmMzgzM2RhZjA3YTQwZTcwMzJhNzMiLCJ0YWciOiIifQ==',
          'Accept': 'application/json',
        },
      );
      Get.back();

      var responseBody = response.body;

      if (responseBody['status_code'] == 1) {
        salaryList.value = responseBody['url'];
      } else if (responseBody['status_code'] == 0) {
        salaryList.value = '';
        print('failed with status code: ${responseBody['status_code']}');
      }
    } catch (e) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      alertEmptyData(
          'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadSlip(String date) async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/employee/salary',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'startDate': date,
          'endDate': date,
        },
        // null,
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == '00') {
        var salaryJSONList = responseBody['emp_salary'];

        var mappedSalaryList = salaryJSONList.map<SalaryModel>(
          (salaryListJSON) => SalaryModel.fromJson(salaryListJSON),
        );

        var convertedSalaryList = RxList<SalaryModel>.of(mappedSalaryList);

        salarySectionList.assignAll(convertedSalaryList);
        Get.toNamed('slip-section');
        // convertedempAttendanceList.forEach((empAttendanceModel) {
        //   print(empAttendanceModel.toJson());
        // });
      } else {
        salarySectionList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.back();
      });
      print(e);
      alertEmptyData(
          'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }

    // await Future.delayed(const Duration(seconds: 1), () {
    //   monthName.value = textMonth;
    //   yearName.value = year;
    //   Get.back();
    // });
  }

// ----------------------------------------------------------------------

  bool isStepOneCompleted() {
    return inputCause.value.isNotEmpty && selectedMonths.isNotEmpty;
  }

  bool isStepTwoCompleted() {
    return usedDate.value.isNotEmpty;
  }

  void updateInputCause(String value) {
    inputCause.value = value;
    print(inputCause);
  }

  void selectedUsedDate(String selectedDate) {
    // formatDate.value = formattedDate;
    usedDate.value = selectedDate;
    print(usedDate);
  }

  // Future<Map<String, dynamic>> sendSlipRequest() async {
  void sendSlipRequest() async {
    loadingController.dialogLoading();

    var strMonth = selectedMonths.join(',');
    // print('selectedMonths: $strMonth');
    // print('inputCause: ${inputCause.value}');
    // print('usedDate: ${usedDate.value}');

    try {
      var requestStatus = await connect.get(
        '$baseUrl/get/config/requests',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (requestStatus.statusCode == 200) {
        final configData = requestStatus.body;
        final statusData = configData['statuses']['new'];
        statusData['emp_id'] = box.read('id');
        statusData['user_id'] = box.read('id');
        statusData['module_name'] = 'emp.requests.salary.slip';

        FormData formData = FormData({
          'emp_id': box.read('id'),
          'companys_id': box.read('companyId'),
          'page_number': 'emp.requests.salary.slip',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'module_name': 'emp.requests.salary.slip',
            'detail': strMonth,
            'note1': inputCause.value,
            'note2': usedDate.value,
          }),
          // 'actions_name': 'ขอเพิ่มข้อมูลรถส่วนตัว',
          'status_data': jsonEncode(statusData),
        });

        var response = await connect.post(
          '$baseUrl/requests/send',
          headers: {
            'Authorization': 'Bearer $token',
          },
          formData,
          // {
          //   'emp_id': box.read('id'),
          //   'month_request': strMonth,
          //   'reason_request': '$inputCause',
          //   'use_date': '$usedDate',
          // },
        );
        Get.back();

        // print(response.body);

        Map<String, dynamic> responseBody = response.body;

        if (responseBody['statusCode'] == '200') {
          strMonth = '';
          clear();
          // return responseBody;
          Get.offAndToNamed('salary-step-request', arguments: 1);
        } else {
          Get.offAndToNamed('salary-step-request', arguments: 2);
          // Get.toNamed(page)
        }
      } else {
        Get.back();
        alertEmptyData(
            'แจ้งเตือน', 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งในภายหลีัง');
        print("ไม่สามารถดึงข้อมูล status ได้");
      }
    } catch (e) {
      Get.offAndToNamed('salary-step-request', arguments: 2);
      print('Error: $e');
    }

    // return {'statusCode': 'error', 'message': 'Failed to send data'};
  }

  void clearHistory() {
    salaryList = RxString('');
    monthSelected = ''.obs;
    yearSelected = ''.obs;

    update();
  }

  void clear() {
    selectedMonths.clear();
    inputCause = RxString('');
    formatDate = RxString('ยังไม่ได้เลือก');
    usedDate = RxString('');

    update();
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
