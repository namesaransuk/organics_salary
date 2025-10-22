import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

import 'package:organics_salary/theme.dart';

class SocialSecurityController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final emp_id = GetStorage().read('id');

  var socialSecurityList = RxList();
  RxString selectedSocialSecurityId = RxString('เลือกประเภท');
  RxString selectedSocialSecurityText = RxString('');
  RxString selectedSocialSecurityIdCard = RxString('');
  RxString selectedSocialSecurityPasswordSSO = RxString('');

  RxList listSocialSecurity = RxList<dynamic>([]);
  RxList listSubSocialSecurity = RxList<dynamic>([]);
  RxList<Map<String, dynamic>> selectedFiles = <Map<String, dynamic>>[].obs;

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/socialSecurity/list/history',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;
      print(responseBody);

      if (responseBody['statusCode'] == 200) {
        socialSecurityList.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        socialSecurityList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> fetchSocialSecurity() async {
    var response = await connect.post(
      '$baseUrl/search/socialSecurityType/list',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      {
        'emp_id': box.read('id'),
      },
    );

    print(response.body);
    // Map<String, dynamic> responseBody = response.body;
    listSocialSecurity.value = response.body['data'];
  }

  void sendData() async {
    loadingController.dialogLoading();

    try {
      final responseStatus = await connect.get(
        '$baseUrl/get/config/requests',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (responseStatus.statusCode == 200) {
        final configData = responseStatus.body;
        final statusData = configData['statuses']['new'];

        print(selectedSocialSecurityText.value);
        print(selectedSocialSecurityIdCard.value);
        print(selectedSocialSecurityPasswordSSO.value);

        statusData['emp_id'] = box.read('id');
        statusData['user_id'] = box.read('id');
        statusData['module_name'] = 'c_transaction_requests.id';

        final formData = FormData({
          'emp_id': box.read('id').toString(),
          'companys_id': box.read('companyId').toString(),
          'page_number': 'emp.requests.social.security',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_name': 'emp.rights.benefits',
            'module_action_id': selectedSocialSecurityId.value,
            'image_show_id': 8,
            'subject': 'ประกันสังคม',
            'detail': selectedSocialSecurityText.value,
            'note1': selectedSocialSecurityIdCard.value,
            'note2': selectedSocialSecurityPasswordSSO.value,
          }),
          'status_data': jsonEncode(statusData),
        });

        if (selectedFiles.isNotEmpty) {
          for (int index = 0; index < selectedFiles.length; index++) {
            var fileData = selectedFiles[index];

            if (fileData['type'] == 'image') {
              XFile file = fileData['file'];
              formData.files.add(
                MapEntry(
                  'files[]',
                  MultipartFile(
                    await file.readAsBytes(),
                    filename: file.name,
                    contentType: MediaType('image', 'jpeg').toString(),
                  ),
                ),
              );
            } else if (fileData['type'] == 'pdf') {
              PlatformFile file = fileData['file'];
              formData.files.add(
                MapEntry(
                  'files[]',
                  MultipartFile(
                    file.bytes!,
                    filename: file.name,
                    contentType: MediaType('application', 'pdf').toString(),
                  ),
                ),
              );
            }

            formData.fields
                .add(MapEntry('actions_name[$index]', 'ประกันสังคม'));
            formData.fields.add(MapEntry('detail[$index]', 'ประกันสังคม'));
          }
        }

        final response = await connect.post(
          '$baseUrl/requests/send',
          headers: {
            'Authorization': 'Bearer $token',
          },
          formData,
        );
        Get.back();

        if (response.statusCode == 200) {
          final responseData = response.body;
          print(responseData);
          clear();

          if (responseData['statusCode'] == '200') {
            loadData();
            print('success');
            Get.offAndToNamed('/status-success');
          } else {
            print('failed');
            Get.offAndToNamed('/status-cancel');
          }
        } else {
          Get.back();
          final responseData = response.body;
          print("ไม่สามารถส่งข้อมูลได้");
          alertEmptyData('แจ้งเตือน',
              responseData['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        }
      } else {
        Get.back();
        print("ไม่สามารถดึงข้อมูล status ได้");
        alertEmptyData(
            'แจ้งเตือน', 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งในภายหลีัง');
      }
    } catch (e) {
      clear();
      Get.offAndToNamed('/status-cancel');
      print('Error: $e');
    }
  }

  void clear() {
    selectedSocialSecurityText = RxString('เลือกประเภท');
    listSubSocialSecurity = RxList<dynamic>([]);
    selectedFiles = selectedFiles = <Map<String, dynamic>>[].obs;
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
