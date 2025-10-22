import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/car_model/datum.dart';

import 'package:organics_salary/theme.dart';

class CarController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());

  var carList = RxList<Datum>();
  // late RxList filteredCarList;
  RxString selectedCarText = RxString('เลือกประเภทรถ');
  RxString selectedCarRegistration = RxString('');
  RxString selectedCarBrand = RxString('');
  RxString selectedCarColor = RxString('');
  // Rx<XFile?> selectedImages = Rx<XFile?>(null);
  RxList<XFile> selectedImages = <XFile>[].obs;

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/get/my/car',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'language': 'th',
          'emp_id': box.read('id'),
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;
      print(responseBody);

      if (response.statusCode == 200) {
        var carJSONList = responseBody['data'];

        if (carJSONList != null) {
          var mappedcarList = carJSONList.map<Datum>(
            (carJSON) => Datum.fromJson(carJSON),
          );

          var convertedcarList = RxList<Datum>.of(mappedcarList);

          carList.assignAll(convertedcarList);
        } else {
          carList.clear();
        }
      } else {
        carList.clear();
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e, stackTrace) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      // Get.back();
      // });
      print(e);
      print('Stack Trace: $stackTrace');
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

// ================================================================

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

        FormData formData = FormData({
          'language': 'th',
          'emp_id': box.read('id'),
          'companys_id': box.read('companyId'),
          'page_number': 'emp.requests.add.car.data',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_name': 'emp.requests.add.car.data',
            'subject': 'รถส่วนตัว',
            'detail': 'รูปรถ',
            'note1': 'ขอเพิ่มข้อมูลรถส่วนตัว',
          }),
          'hr_private_cars': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'department_id': box.read('departmentId'),
            'car_category_id': selectedCarText.value,
            'car_registration': selectedCarRegistration.value,
            'car_brand': selectedCarBrand.value,
            'car_color': selectedCarColor.value
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

            formData.fields.add(
                MapEntry('actions_name[$index]', 'ขอเพิ่มข้อมูลรถส่วนตัว'));
            formData.fields.add(MapEntry('detail[$index]', 'รูปรถ'));
            // formData.fields.add(MapEntry('note1[$index]', 'แจ้งขอใช้สิทธิ์ประกันสังคม'));
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
            print('success');
            Get.offAndToNamed('/status-success');
          } else {
            print('failed');
            Get.offAndToNamed('/status-cancel');
          }
        } else {
          final responseData = response.body;
          Get.back();
          print("ไม่สามารถส่งข้อมูลได้");
          alertEmptyData('แจ้งเตือน',
              responseData['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
          Get.offAndToNamed('/status-cancel');
        }
      } else {
        Get.back();
        print("ไม่สามารถดึงข้อมูล status ได้");
        Get.offAndToNamed('/status-cancel');
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
    selectedCarText = RxString('เลือกประเภทรถ');
    selectedCarRegistration = RxString('');
    selectedCarBrand = RxString('');
    selectedCarColor = RxString('');
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
