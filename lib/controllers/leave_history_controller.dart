import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/emp_leave_model.dart';
import 'dart:convert';

class LeaveHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var connect = Get.find<GetConnect>();
  var leaveHistoryList = RxList<LeaveHistoryModel>();

  void loadData() async {
    loadingController.dialogLoading();
    try {
      var response = await connect.post(
        '$baseUrl/employee/empLeave',
        {
          // 'id': box.read('id'),
          'emp_id': 165,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = response.body;

        if (responseBody['statusCode'] == '00') {
        print('test');
          var leaveHistoryJSONList = responseBody['empLeave'];

          var mappedLeaveHistoryList =
              leaveHistoryJSONList.map<LeaveHistoryModel>(
            (leaveHistoryJSON) => LeaveHistoryModel.fromJson(leaveHistoryJSON),
          );

          var convertedLeaveHistoryList =
              RxList<LeaveHistoryModel>.of(mappedLeaveHistoryList);

          leaveHistoryList.assignAll(convertedLeaveHistoryList);

          // await Future.delayed(const Duration(seconds: 1), () {
            Get.back();
          // });
        } else {
          print('failed with status code: ${responseBody['statusCode']}');
        }
      } else {
        print('Disconnect');
      }
    } catch (e) {
      print(e);
    }
  }

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
