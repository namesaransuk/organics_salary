import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/emp_leave_model.dart';

class LeaveHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var connect = Get.find<GetConnect>();

  var leaveHistoryList = RxList<LeaveHistoryModel>();
  RxString monthName = 'กรุณาเลือกเดือน'.obs;

  void getMonthName(String mName) {
    monthName.value = mName;
  }

  void loadData(int month) async {
    loadingController.dialogLoading();
    leaveHistoryList.clear();
    try {
      var response = await connect.post(
        '$baseUrl/employee/empLeave',
        {'emp_id': box.read('id'), 'month': month},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = response.body;

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
        Get.back();
      } else {
        Get.back();
        print('Disconnect');
      }
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  void sendData(selectedLeaveId, selectedImages, reasonLeave, leaveStart,
      leaveEnd) async {}

  void alertEmptyData(BuildContext context, String title, String detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          content: Text(detail),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/pin');
              },
              child: Text("ตกลง"),
            ),
          ],
        );
      },
    );
  }
}
