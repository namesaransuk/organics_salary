import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';

class MaintenanceController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());

  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final box = GetStorage();

  var maintenanceList = RxList([]);
  RxList listMaintenance = RxList<dynamic>([]);
  RxList listLocation = RxList<dynamic>([]);
  RxString selectedMaintenanceType = RxString('เลือกหมวดหมู่');
  RxString selectedMaintenanceId = RxString('เลือกประเภทการแจ้งซ่อม');
  RxString selectedMaintenanceTitle = RxString('');
  RxString maintenanceDetail = RxString('');
  RxList<XFile> selectedImages = <XFile>[].obs;

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/requests/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'requests_types': 'maintence',
          // 'requests_types': 'maintenance',
          // 'filter': jsonEncode(whereItem),
        },
      );

      // if (response.statusCode == 200) {
      var responseBody = response.body;
      Get.back();

      if (responseBody['statusCode'] == '200') {
        maintenanceList.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        maintenanceList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        print('test savings else');
      }
      // } else {
      //   Get.back();
      //   print('Disconnect');
      // }
    } catch (e) {
      print(e);
      print('test savings');
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> fetchMaintenance() async {
    try {
      var response = await connect.post(
        '$baseUrl/asset/supply/category/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        null,
      );

      // ตรวจสอบสถานะของ response
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = response.body;
        print(responseBody);
        listMaintenance.value = responseBody['data'];
      } else {
        throw Exception(
            'Failed to fetch maintenance data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // จัดการข้อผิดพลาด
      print('Error in fetchMaintenance: $e');
      // คุณสามารถเพิ่มการแจ้งเตือนหรือการแสดงผล error message ให้ผู้ใช้งานได้ตามต้องการ
    }
  }

  Future<void> fetchLocation() async {
    try {
      var response = await connect.post(
        '$baseUrl/locations/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        null,
      );

      // ตรวจสอบสถานะของ response
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = response.body;
        listLocation.value = responseBody['data'];
      } else {
        throw Exception(
            'Failed to fetch location data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // จัดการข้อผิดพลาด
      print('Error in fetchLocation: $e');
      // คุณสามารถเพิ่มการแจ้งเตือนหรือการแสดงผล error message ให้ผู้ใช้งานได้ตามต้องการ
    }
  }

  void sendData() async {
    loadingController.dialogLoading();

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
        statusData['module_name'] = 'c_transaction_requests.id';

        dynamic moduleActionId;
        dynamic note1;
        dynamic note2;
        switch (selectedMaintenanceType.value) {
          case '1':
            moduleActionId = selectedMaintenanceId.value;
            note1 = 'คำขอการมีส่วนร่วม (แจ้งซ่อมบำรุง)';
            note2 = 'location';
            break;
          case '2':
            moduleActionId = selectedMaintenanceId.value;
            note1 = 'คำขอการมีส่วนร่วม (แจ้งซ่อมบำรุง)';
            note2 = 'asset';
            break;
          case '3':
            moduleActionId = null;
            note1 = selectedMaintenanceTitle.value;
            note2 = 'other';
            break;
          default:
            moduleActionId = null;
            note1 = null;
            note2 = null;
        }

        FormData formData = FormData({
          'emp_id': box.read('id'),
          'companys_id': box.read('companyId'),
          'page_number': 'emp.report.maintenance',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_name': 'emp.report.maintenance',
            'module_action_id': moduleActionId,
            'subject': 'การมีส่วนร่วม (แจ้งซ่อมบำรุง)',
            'detail': maintenanceDetail.value,
            'note1': note1,
            'note2': note2,
          }),
          'status_data': jsonEncode(statusData),
        });

        if (selectedImages.isNotEmpty) {
          for (int index = 0; index < selectedImages.length; index++) {
            var file = selectedImages[index];

            formData.files.add(
              MapEntry(
                'files[]',
                MultipartFile(
                  await file.readAsBytes(),
                  filename: file.name,
                  contentType: 'image/jpeg',
                ),
              ),
            );

            formData.fields
                .add(MapEntry('actions_name[$index]', 'แจ้งซ่อมสินทรัพย์'));
            formData.fields.add(
                MapEntry('detail[$index]', 'รูปแนบสำหรับแจ้งซ่อมสินทรัพย์'));
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
    maintenanceList = RxList([]);
    listMaintenance = RxList<dynamic>([]);
    listLocation = RxList<dynamic>([]);
    selectedMaintenanceType = RxString('เลือกหมวดหมู่');
    selectedMaintenanceId = RxString('เลือกประเภทการแจ้งซ่อม');
    selectedMaintenanceTitle = RxString('');
    maintenanceDetail = RxString('');
    selectedImages = <XFile>[].obs;
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
