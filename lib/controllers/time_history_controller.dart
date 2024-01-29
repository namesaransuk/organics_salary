import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/emp_attendance_model.dart';
import 'package:organics_salary/models/time_history_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TimeHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  RxString monthName = 'เดือน'.obs;
  RxString yearName = 'ปี'.obs;
  RxString ddMonthName = 'เดือน'.obs;
  RxString ddYearName = 'ปี'.obs;
  var timeHistoryList = RxList<TimeHistoryModel>();
  var empAttendanceList = RxList<EmpAttendanceModel>();
  var baseUrl = dotenv.env['API_URL'];
  var connect = Get.find<GetConnect>();
  final box = GetStorage();

  void getMonthName(String mName) {
    ddMonthName.value = mName;
  }

  void getYear(String yName) {
    ddYearName.value = yName;
  }

  void loadStatus() async {
    loadingController.dialogLoading();

    // Get.back();
    try {
      var response = await connect.post(
          '$baseUrl/employee/attendance/by/month/year', null);
      Get.back();

      Map<String, dynamic> responseBody = response.body;
      // print(responseBody['emp_attendance']);

      if (responseBody['statusCode'] == '00') {
        var empAttendanceJSONList = responseBody['emp_attendance'];

        var mappedempAttendanceList =
            empAttendanceJSONList.map<EmpAttendanceModel>(
          (empAttendanceListJSON) =>
              EmpAttendanceModel.fromJson(empAttendanceListJSON),
        );

        var convertedempAttendanceList =
            RxList<EmpAttendanceModel>.of(mappedempAttendanceList);

        empAttendanceList.assignAll(convertedempAttendanceList);
        // convertedempAttendanceList.forEach((empAttendanceModel) {
        //   print(empAttendanceModel.toJson());
        // });
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      Get.back();
      print(e);
      alertEmptyData(
          'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadData(String textMonth, int month, String year) async {
    loadingController.dialogLoading();
    timeHistoryList.clear();
    try {
      var response = await connect.post(
        '$baseUrl/employee/empPasteCardLog',
        {'emp_id': box.read('id'), 'month': month, 'year': year},
      );

      // if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = response.body;
      monthName.value = textMonth;
      yearName.value = year;

      Get.back();
      if (responseBody['statusCode'] == '00') {
        var timeHistoryListJSONList = responseBody['empLog'];

        var mappedtimeHistoryList =
            timeHistoryListJSONList.map<TimeHistoryModel>(
          (timeHistoryListJSON) =>
              TimeHistoryModel.fromJson(timeHistoryListJSON),
        );

        var convertedtimeHistoryList =
            RxList<TimeHistoryModel>.of(mappedtimeHistoryList);

        timeHistoryList.assignAll(convertedtimeHistoryList);

        Get.toNamed('time-history-month');
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
      // } else {
      //   Get.back();
      //   print('Disconnect');
      // }
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  void alertEmptyData(String title, String detail) {
    Get.dialog(
      AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        title: Text(title),
        content: Text(detail),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("ตกลง"),
          ),
        ],
      ),
    );
  }
}
