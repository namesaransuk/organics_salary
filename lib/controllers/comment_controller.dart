import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

import 'package:organics_salary/theme.dart';

class CommentController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final emp_id = GetStorage().read('id');

  var commentList = RxList();

  RxString selectedCommentText = RxString('เลือกหัวข้อ');
  RxString selectedSubCommentText = RxString('');
  RxString selectedCommentDetail = RxString('');
  // Rx<XFile?> selectedImages = Rx<XFile?>(null);
  RxList<XFile> selectedImages = <XFile>[].obs;

  RxList listComment = RxList<dynamic>([]);
  RxList listSubComment = RxList<dynamic>([]);

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
          'language': 'th',
          'emp_id': box.read('id'),
          // 'page_number': 'feedback',
          'requests_types': 'feedback',
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == '200') {
        commentList.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        commentList.clear();
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        print('failed with status code: ${responseBody['statusCode']}');
      }
      // }
    } catch (e, stack) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      print(stack);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  // Future<void> fetchComment() async {
  //   var response = await connect.post(
  //     '$baseUrl/comment/categories/getAll',
  //     null,
  //   );

  //   // print(response.body);
  //   listComment.value = response.body;
  // }

  Future<void> fetchSubComment() async {
    var response = await connect.post(
      '$baseUrl/comment/get/topic/com',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      {
        'categories_comment_id': selectedCommentText.value,
      },
    );

    // print(response.body);
    Map<String, dynamic> responseBody = response.body;
    listSubComment.value = responseBody['topicsCom'];
  }

// ================================================================
  void sendData() async {
    print(emp_id);
    print(selectedSubCommentText);
    print(selectedCommentDetail);
    print(selectedImages);

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
          'emp_id': box.read('id'),
          'companys_id': box.read('companyId'),
          'page_number': 'emp.feedback',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_name': 'emp.feedback',
            'subject': selectedSubCommentText.value,
            'detail': selectedCommentDetail.value,
            'note1': 'การมีส่วนร่วม (เสนอความคิดเห็น)',
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

            formData.fields.add(MapEntry(
                'actions_name[$index]', 'การมีส่วนร่วม (เสนอความคิดเห็น)'));
            formData.fields
                .add(MapEntry('detail[$index]', selectedCommentDetail.value));
          }
        }

        var response = await connect.post(
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
            loadData();
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
    selectedCommentText = RxString('เลือกหัวข้อ');
    selectedSubCommentText = RxString('');
    selectedCommentDetail = RxString('');
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
