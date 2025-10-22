import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/emp_attendance_model.dart';
import 'package:organics_salary/models/time_history_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';
import 'package:saver_gallery/saver_gallery.dart';

class ProfileController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  // RxString monthName = 'เดือน'.obs;
  // RxString yearName = 'ปี'.obs;
  // RxString ddMonthName = 'เดือน'.obs;
  // RxString ddYearName = 'ปี'.obs;
  var timeHistoryList = RxList<TimeHistoryModel>();
  var empAttendanceList = RxList<EmpAttendanceModel>();
  var leaveQuotaList = RxList<dynamic>();

  RxList flowLeaveList = RxList<dynamic>([]);
  RxList empWorkList = RxList<dynamic>([]);
  RxList workTimeList = RxList<dynamic>([]);
  RxList holidaysList = RxList<dynamic>([]);

  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final box = GetStorage();

  Future<void> downloadAndSaveImage(
      BuildContext context, String imageUrl, String fileName) async {
    try {
      var response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 && response.data != null) {
        final String uniqueId =
            DateTime.now().millisecondsSinceEpoch.toString();
        final String newFileName = '${uniqueId}_$fileName';

        final result = await SaverGallery.saveImage(
          Uint8List.fromList(response.data),
          fileName: newFileName,
          skipIfExists: false,
        );

        print('Save Result: ${result.toString()}');

        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                'บันทึกรูปภาพเรียบร้อยแล้ว',
                style: TextStyle(color: Colors.black),
              ),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                'เกิดข้อผิดพลาด ไม่สามารถบันทึกรูปภาพได้: ${result.errorMessage ?? "ไม่ทราบสาเหตุ"}',
                style: TextStyle(color: Colors.black),
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              'ไม่สามารถดาวน์โหลดรูปภาพได้ (สถานะ: ${response.statusCode})',
              style: TextStyle(color: Colors.black),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'เกิดข้อผิดพลาด ไม่สามารถดาวน์โหลดหรือบันทึกไฟล์นี้ได้',
            style: TextStyle(color: Colors.black),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> loadStatus(String year) async {
    empAttendanceList.clear();

    try {
      var response = await connect.post(
        '$baseUrl/employee/attendance/by/month/year',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'year': year,
        },
        // null,
      );

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
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
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

  Future<void> loadQuota() async {
    try {
      var response = await connect.post(
        // '$baseUrl/leave/type/select',
        '$baseUrl/leave/emp/limit',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
        },
      );

      var responseBody = response.body;

      leaveQuotaList.assignAll(responseBody['data']['leaveSummary']);
    } catch (e) {
      print(e);
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
