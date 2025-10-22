import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';

class PasswordController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());

  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final box = GetStorage();

  RxString empCode = ''.obs;
  RxString birthday = ''.obs;
  RxString idCard = ''.obs;

  RxString old_password = ''.obs;

  RxString emp_id = ''.obs;
  RxString new_password = ''.obs;
  RxString confirm_password = ''.obs;

  Future<void> checkPasswordBefore() async {
    print(empCode);
    print(birthday);
    print(idCard);

    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/employee/check/password',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        // 1169800101028
        {
          'language': 'th',
          'employee_code': empCode.value,
          'birthday': birthday.value,
          'id_card': idCard.value,
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        emp_id.value = '${responseBody['emp_id']}';
        Get.toNamed('confirm-resetpass');
      } else {
        alertEmptyData('แจ้งเตือน',
            responseBody['message'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');

        print('failed with status code: ${responseBody['statusCode']}');
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

  // Future<void> checkPasswordAfter() async {
  //   // print(old_password);
  //   loadingController.dialogLoading();
  //   try {
  //     var response = await connect.post(
  //       '$baseUrl/profile/check/password',
  // headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       {
  //         'emp_id': box.read('id'),
  //         'password': old_password.value,
  //       },
  //       // null,
  //     );
  //     Get.back();
  //     Map<String, dynamic> responseBody = response.body;
  //     if (responseBody['statusCode'] == '00') {
  //       Get.toNamed('confirm-changepass');
  //     } else {
  //       alertEmptyData('แจ้งเตือน', 'ข้อมูลที่กรอกไม่ถูกต้อง กรุณากรอกข้อมูลใหม่อีกครั้ง');
  //       print('failed with status code: ${responseBody['statusCode']}');
  //     }
  //   } catch (e) {
  //     // Future.delayed(const Duration(milliseconds: 100), () {
  //     Get.back();
  //     // });
  //     print(e);
  //     alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
  //   }
  // }

  Future<void> sendData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/employee/change/password',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'create_data': jsonEncode({
            'new_password': new_password.value,
          }),
        },
      );
      Get.back();

      print(response.body);
      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        print(responseBody['dataBcrypt']);
        box.write('password', responseBody['dataBcrypt']);
        Get.offAndToNamed('status-changepass', arguments: 1);
      } else {
        print('failed');

        Get.offAndToNamed('status-changepass', arguments: 2);
        // Get.toNamed(page)
      }
    } catch (e, s) {
      Get.offAndToNamed('status-changepass', arguments: 2);
      print('Error: $e');
      print('Error: $s');
    }
  }

  Future<void> sendDataBeforeLogin() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/employee/change/password',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': emp_id.value,
          'create_data': jsonEncode({
            'new_password': new_password.value,
          }),
        },
      );
      Get.back();

      print(response.body);
      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        print(responseBody['dataBcrypt']);
        box.write('password', responseBody['dataBcrypt']);
        Get.back();
        Get.offAndToNamed('status-changepass', arguments: 1);
      } else {
        print('failed');

        Get.offAndToNamed('status-changepass', arguments: 2);
        // Get.toNamed(page)
      }
    } catch (e, s) {
      Get.offAndToNamed('status-changepass', arguments: 2);
      print('Error: $e');
      print('Error: $s');
    }
  }

  // Future<void> sendData2() async {
  //   loadingController.dialogLoading();
  //   try {
  //     var requestStatus = await connect.get(
  //       '$baseUrl/get/config/requests',
  //     );
  //     if (requestStatus.statusCode == 200) {
  //       final configData = requestStatus.body;
  //       final statusData = configData['statuses']['new'];
  //       statusData['emp_id'] = box.read('id');
  //       statusData['user_id'] = box.read('id');
  //       statusData['module_name'] = 'emp.requests.dc.employment.contracts';
  //       FormData formData = FormData({
  //         'emp_id': box.read('id'),
  //         'companys_id': box.read('companyId'),
  //         'page_number': 'emp.requests.change.password',
  //         'create_data': jsonEncode({
  //           'emp_id': box.read('id'),
  //           'company_id': box.read('companyId'),
  //           'module_name': 'emp.requests.change.password',
  //         }),
  //         // 'actions_name': 'แจ้งขอเปลี่ยนแปลงข้อมูลเอกสารและสัญญา',
  //         'status_data': jsonEncode(statusData),
  //       });
  //       var response = await connect.post(
  //         '$baseUrl/requests/send',
  //         formData,
  //       );
  //       Get.back();
  //       print(response.body);
  //       Map<String, dynamic> responseBody = response.body;
  //       if (responseBody['statusCode'] == '200') {
  //         print('success');
  //         Get.offAndToNamed('status-changepass', arguments: 1);
  //       } else {
  //         print('failed');
  //         Get.offAndToNamed('status-changepass', arguments: 2);
  //         // Get.toNamed(page)
  //       }
  //     } else {
  //       Get.back();
  //       alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งในภายหลีัง');
  //       print("ไม่สามารถดึงข้อมูล status ได้");
  //     }
  //   } catch (e) {
  //     Get.offAndToNamed('status-changepass', arguments: 2);
  //     print('Error: $e');
  //   }
  // }

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
}
