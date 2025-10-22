import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

import 'package:organics_salary/theme.dart';

class AssessmentController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final id = GetStorage().read('id');

  late RxList filteredLeaveHistoryList;
  var assessmentList = RxList<dynamic>([]);
  var summarizeList = RxList<dynamic>([]);
  var historyAssessmentList = RxList<dynamic>([]);

  RxString detailRecomment = RxString('');

  RxString c_startDate = RxString('');
  RxString c_endDate = RxString('');
  RxString searchStartDate = RxString('');
  RxString searchEndDate = RxString('');

  // RxString selectedHonorText = RxString('เลือกประเภทเกียรติประวัติ');
  // RxList<XFile> selectedImages = <XFile>[].obs;

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/employee/data',
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

      var responseBody = response.body;
      print(responseBody);

      if (responseBody['statusCode'] == 200) {
      } else {
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e, stackTrace) {
      Get.back();
      print('Error: $e');
      debugPrintStack(stackTrace: stackTrace);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

// ================================================================

  // void sendData() async {
  //   loadingController.dialogLoading();

  //   try {
  //     var requestStatus = await connect.get(
  //       '$baseUrl/get/config/requests',
  // headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (requestStatus.statusCode == 200) {
  //       final configData = requestStatus.body;
  //       final statusData = configData['statuses']['new'];

  //       statusData['emp_id'] = box.read('id');
  //       statusData['user_id'] = box.read('id');
  //       statusData['module_name'] = 'c_transaction_requests.id';

  //       final formData = FormData({
  //         'emp_id': box.read('id').toString(),
  //         'companys_id': box.read('companyId').toString(),
  //         'page_number': selectedHonorText.value == '1' ? 'emp.requests.add.file.certificate.honor.one' : 'emp.requests.add.file.certificate.honor.two',
  //         'create_data': jsonEncode({
  //           'emp_id': box.read('id'),
  //           'company_id': box.read('companyId'),
  //           'module_name': selectedHonorText.value == '1' ? 'emp.requests.add.file.certificate.honor.one' : 'emp.requests.add.file.certificate.honor.two',
  //           'subject': 'เกียติประวัติ',
  //           'detail': selectedDetail.value,
  //           'note1': 'แจ้งขอเพิ่มเติมข้อมูลเกียติประวัติ',
  //         }),
  //         'status_data': jsonEncode(statusData),
  //       });

  //       if (selectedImages.isNotEmpty) {
  //         for (int index = 0; index < selectedImages.length; index++) {
  //           var file = selectedImages[index];

  //           formData.files.add(
  //             MapEntry(
  //               'files[]',
  //               MultipartFile(
  //                 await file.readAsBytes(),
  //                 filename: file.name,
  //                 contentType: 'image/jpeg',
  //               ),
  //             ),
  //           );

  //           formData.fields.add(MapEntry('actions_name[$index]', 'แจ้งขอเพิ่มเติมข้อมูลเกียติประวัติ'));
  //           formData.fields.add(MapEntry('detail[$index]', selectedDetail.value));
  //           // formData.fields.add(MapEntry('note1[$index]', 'แจ้งขอใช้สิทธิ์ประกันสังคม'));
  //         }
  //       }

  // final response = await connect.post('$baseUrl/requests/send', headers: {
  //   'Authorization': 'Bearer $token',
  // },formData,);
  //       Get.back();

  //       if (response.statusCode == 200) {
  //         final responseData = response.body;
  //         print(responseData);
  //         clearSend();

  //         if (responseData['statusCode'] == '200') {
  //           clearSend();
  //           print('success');
  //           Get.offAndToNamed('/status-success');
  //         } else {
  //           print('failed');
  //           Get.offAndToNamed('/status-cancel');
  //         }
  //       } else {
  //         Get.back();
  //         print("ไม่สามารถส่งข้อมูลได้");
  //         alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งในภายหลีัง');
  //       }
  //     } else {
  //       Get.back();
  //       print("ไม่สามารถดึงข้อมูล status ได้");
  //       alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งในภายหลีัง');
  //     }
  //   } catch (e) {
  //     clearSend();
  //     Get.offAndToNamed('/status-cancel');
  //     print('Error: $e');
  //   }
  // }

  void clearSend() {
    //   selectedHonorText = RxString('เลือกประเภทเกียรติประวัติ');
    //   selectedDetail = RxString('');
    //   // selectedImages = Rx<XFile?>(null);
    //   selectedImages = <XFile>[].obs;
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
