import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

import 'package:organics_salary/theme.dart';

class EquipmentController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final emp_id = GetStorage().read('id');

  var equipmentWithdrawList = RxList([]);
  var equipmentMaintenanceList = RxList([]);
  var equipmentHistoryMaintenanceList = RxList([]);

  RxString selectedEquipmentText = RxString('เลือกอุปกรณ์');
  RxInt selectedUnitText = RxInt(0);
  RxString selectedEquipmentId = RxString('');
  RxString selectedEquipmentUnit = RxString('');
  RxString selectedEquipmentDetail = RxString('');

  RxList listEquipment = RxList<dynamic>([]);
  RxString assetSupplyCount = RxString('');

  RxString selectedReturnMaintenanceId = RxString('');
  RxString selectedReturnMaintenanceDetail = RxString('');

  RxString selectedReportMaintenanceId = RxString('');
  RxString selectedReportMaintenanceDetail = RxString('');
  RxList<XFile> selectedReportMaintenanceImages = <XFile>[].obs;

  void loadDataWithdraw() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        // '$baseUrl/requests/list',
        '$baseUrl/asset/supply/list/history',
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
        equipmentWithdrawList.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        equipmentWithdrawList.clear();
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

  void loadDataMaintenance() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        // '$baseUrl/requests/list',
        '$baseUrl/asset/supply/list/employee',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'type': 1,
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        equipmentMaintenanceList
            .assignAll(responseBody['data'] as List<dynamic>);
      } else {
        equipmentMaintenanceList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
      // }
    } catch (e) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadDataHistoryMaintenance() async {
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
          'requests_types': 'maintence_emp',
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;
      print(responseBody);

      if (responseBody['statusCode'] == '200') {
        equipmentHistoryMaintenanceList
            .assignAll(responseBody['data'] as List<dynamic>);
      } else {
        equipmentHistoryMaintenanceList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
      // }
    } catch (e) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> fetchEquipment() async {
    var response = await connect.post(
      // '$baseUrl/asset/supply/category/list',
      '$baseUrl/search/asset/list',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      {
        "name": " ",
        "whereitem": {
          "company_id": box.read('companyId'),
          "categories_option": {"operator": "!=", "value": 3}
        },
      },
    );

    print(response.body);
    Map<String, dynamic> responseBody = response.body;
    listEquipment.value = responseBody['data'] ?? [];
  }

  Future<void> checkAssetAndSupply(itemId) async {
    var response = await connect.post(
      '$baseUrl/asset/supply/pickup',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      {
        'item_id': itemId,
        'emp_id': box.read('id'),
      },
    );

    Map<String, dynamic> responseBody = response.body;
    print(response.body);
    assetSupplyCount.value = responseBody['data']['amount'].toString();

    // listEquipment.value = responseBody['data'];
  }

// ================================================================
  void sendData() async {
    // print(selectedEquipmentText);
    print(selectedEquipmentUnit);
    // print(selectedEquipmentDetail);

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

        final formData = {
          'language': 'th',
          'emp_id': box.read('id'),
          'companys_id': box.read('companyId'),
          'item_id': selectedEquipmentText.value,
          'page_number': 'emp.asset.and.supply.transaction',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_action_id': selectedEquipmentText.value,
            'module_name': 'emp.asset.and.supply.transaction',
            'subject': 'อุปกรณ์และสินทรัพย์',
            'detail': selectedEquipmentDetail.value,
            'note1': 'ขอเบิกอุปกรณ์และสินทรัพย์',
          }),
          'store_data': jsonEncode({
            'emp_id': box.read('id'),
            'module_name': 'emp.asset.and.supply.transaction',
            'detail': selectedEquipmentDetail.value,
            'amount': selectedEquipmentUnit.value == ''
                ? '1'
                : selectedEquipmentUnit.value,
            'asset_id': selectedEquipmentText.value,
          }),
          'status_data': jsonEncode(statusData),
        };

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
            loadDataWithdraw();
            loadDataMaintenance();
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
        alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      clear();
      Get.offAndToNamed('/status-cancel');
      print('Error: $e');
    }
  }

  void sendReturnData() async {
    // print(selectedEquipmentText);
    // print(selectedEquipmentUnit);
    // print(selectedEquipmentDetail);

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

        final formData = {
          'language': 'th',
          'emp_id': box.read('id'),
          'companys_id': box.read('companyId'),
          'page_number': 'emp.return.asset.and.supply.transaction',
          'item_id': selectedReturnMaintenanceId.value,
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_action_id': selectedReturnMaintenanceId.value,
            'subject': 'คืนอุปกรณ์และสินทรัพย์',
            'note1': 'ขอคืนอุปกรณ์และสินทรัพย์',
            'module_name': 'emp.return.asset.and.supply.transaction',
            'detail': selectedReturnMaintenanceDetail.value,
          }),
          'status_data': jsonEncode(statusData),
        };

        final response = await connect.post(
          '$baseUrl/requests/send',
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
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
            loadDataWithdraw();
            loadDataMaintenance();
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

  void sendReportData() async {
    // print(selectedEquipmentText);
    // print(selectedEquipmentUnit);
    // print(selectedEquipmentDetail);

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
          'page_number': 'emp.profile.report.maintenance',
          'item_id': selectedReportMaintenanceId.value,
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_action_id': selectedReportMaintenanceId.value,
            'subject': 'ซ่อมบำรุงสินทรัพย์',
            'note1': 'คำขอแจ้งซ่อมบำรุงสินทรัพย์',
            'module_name': 'emp.profile.report.maintenance',
            'detail': selectedReportMaintenanceDetail.value,
          }),
          'status_data': jsonEncode(statusData),
        });

        if (selectedReportMaintenanceImages.isNotEmpty) {
          for (int index = 0;
              index < selectedReportMaintenanceImages.length;
              index++) {
            var file = selectedReportMaintenanceImages[index];

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
            'Content-Type': 'application/json',
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
            loadDataWithdraw();
            loadDataMaintenance();
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
    selectedEquipmentText = RxString('เลือกอุปกรณ์');
    selectedUnitText = RxInt(0);
    selectedEquipmentUnit = RxString('');
    selectedEquipmentDetail = RxString('');
    assetSupplyCount = RxString('');

    selectedReturnMaintenanceDetail = RxString('');

    selectedReportMaintenanceDetail = RxString('');
    selectedReportMaintenanceImages = <XFile>[].obs;
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
