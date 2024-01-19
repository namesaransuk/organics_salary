import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/emp_leave_model.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class LeaveHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var connect = Get.find<GetConnect>();
  final id = GetStorage().read('id');

  var leaveHistoryList = RxList<LeaveHistoryModel>();
  RxString monthName = 'เดือน'.obs;
  RxString yearName = 'ปี'.obs;
  RxString ddMonthName = 'เดือน'.obs;
  RxString ddYearName = 'ปี'.obs;

  RxInt selectedLeaveId = 0.obs;
  // List<XFile?> selectedImages = [];
  RxList<XFile?> selectedImages = RxList<XFile?>.from([]);
  RxString selectedReasonLeave = ''.obs;
  RxString startDate = ''.obs;
  RxString startTime = ''.obs;
  RxString endDate = ''.obs;
  RxString endTime = ''.obs;
  String get leaveStart => '$startDate $startTime:00';
  String get leaveEnd => '$endDate $endTime:00';

  void getMonthName(String mName) {
    ddMonthName.value = mName;
  }

  void getYear(String yName) {
    ddYearName.value = yName;
  }

  void loadData(String textMonth, int month, String year) async {
    loadingController.dialogLoading();
    leaveHistoryList.clear();

    monthName.value = textMonth;
    yearName.value = year;
    try {
      var response = await connect.post(
        '$baseUrl/employee/empLeave',
        {'emp_id': box.read('id'), 'month': month},
      );

      Map<String, dynamic> responseBody = response.body;

      Get.back();

      if (responseBody['statusCode'] == '00') {
        var leaveHistoryJSONList = responseBody['empLeave'];

        var mappedLeaveHistoryList =
            leaveHistoryJSONList.map<LeaveHistoryModel>(
          (leaveHistoryJSON) => LeaveHistoryModel.fromJson(leaveHistoryJSON),
        );

        var convertedLeaveHistoryList =
            RxList<LeaveHistoryModel>.of(mappedLeaveHistoryList);

        leaveHistoryList.assignAll(convertedLeaveHistoryList);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
      // }
    } catch (e) {
      print(e);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<Map<String, dynamic>> sendData() async {
    loadingController.dialogLoading();

    // FormData formData = FormData({
    //   'leave_img1': MultipartFile(
    //         await selectedImages[0].readAsBytes(),
    //         filename: '${selectedImages[0]}.jpg',
    //       ) ??
    //       null,
    //   'leave_img2': MultipartFile(
    //         await selectedImages[1].readAsBytes(),
    //         filename: '${selectedImages[1]}.jpg',
    //       ) ??
    //       null,
    //   'leave_img3': MultipartFile(
    //         await selectedImages[2].readAsBytes(),
    //         filename: '${selectedImages[2]}.jpg',
    //       ) ??
    //       null,
    //   'leave_img4': MultipartFile(
    //         await selectedImages[3].readAsBytes(),
    //         filename: '${selectedImages[3]}.jpg',
    //       ) ??
    //       null,
    //   'leave_img5': MultipartFile(
    //         await selectedImages[4].readAsBytes(),
    //         filename: '${selectedImages[4]}.jpg',
    //       ) ??
    //       null,
    // });
    DateTime now = DateTime.now();
    int days = now.day;
    // int month = now.month;
    int year = now.year;
    String formattedDay = '$days'.padLeft(2, '0');
    String numericMonth = DateFormat('MM').format(now);

    FormData formData = FormData({});

    formData.fields.add(MapEntry('emp_id', '$id'));
    formData.fields.add(MapEntry('leave_type_id', '$selectedLeaveId'));
    formData.fields.add(MapEntry('leave_detail', '$selectedReasonLeave'));
    formData.fields.add(MapEntry('leave_date_start', leaveStart));
    formData.fields.add(MapEntry('leave_date_end', leaveEnd));
    formData.fields.add(MapEntry('days', formattedDay));
    formData.fields.add(MapEntry('month', numericMonth));
    formData.fields.add(MapEntry('year', '$year'));

    for (int i = 0; i < selectedImages.length; i++) {
      var image = selectedImages[i];

      if (image != null) {
        List<int> imageBytes = await image.readAsBytes();
        MultipartFile file = MultipartFile(
          imageBytes,
          filename: 'leave_img_$i.jpg',
        );
        formData.files.add(MapEntry('leave_imgs[$i]', file));
      } else {
        formData.fields.add(MapEntry('leave_imgs[$i]', 'null'));
      }
    }

    try {
      var response = await connect.post(
        '$baseUrl/employee/saveEmpLeave',
        formData,
      );

      print(response.body);

      Map<String, dynamic> responseBody = json.decode(response.body);
      Get.back();

      if (responseBody['statusCode'] == '00') {
        print('success');

        // Reset ค่าต่าง ๆ ที่ต้องการ clear
        selectedLeaveId.value = 0;
        selectedImages.clear();
        selectedReasonLeave.value = '';
        startDate.value = '';
        startTime.value = '';
        endDate.value = '';
        endTime.value = '';

        return responseBody;
      }
    } catch (e) {
      print('Error: $e');
    }

    // ในกรณีไม่สามารถส่งข้อมูลได้
    return {'statusCode': 'error', 'message': 'Failed to send data'};
  }

  void clear() {
    selectedLeaveId = 0.obs;
    selectedImages.clear();
    selectedReasonLeave = ''.obs;
    startDate = ''.obs;
    startTime = ''.obs;
    endDate = ''.obs;
    endTime = ''.obs;

    update();
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
