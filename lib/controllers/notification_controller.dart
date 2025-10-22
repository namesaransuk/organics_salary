import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';

class NotificationController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());

  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final box = GetStorage();

  var notificationList = RxList<dynamic>();

  RxBool showUnreadOnly = false.obs;
  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  RxBool isLastPage = false.obs;
  int limit = 10;
  int page = 1;

  Future<void> loaddata({bool isLoadMore = false}) async {
    loadingController.dialogLoading();

    if (isMoreLoading.value) return;

    if (isLoadMore) {
      isMoreLoading.value = true;
      page++;
    } else {
      isLoading.value = true;
      isLastPage.value = false;
      page = 1;
      // ❌ อย่าล้าง notificationList ที่นี่
    }

    try {
      var response = await connect.post(
        '$baseUrl/emp/notification/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'page': page,
          'limit': limit,
        },
      );
      Get.back();

      var responseBody = response.body;
      print(responseBody);

      if (responseBody['statusCode'] == '200') {
        final List<dynamic> newData = responseBody['data']['data'];

        if (isLoadMore) {
          notificationList.addAll(newData);
        } else {
          // ✅ แทนที่ข้อมูลเก่าเมื่อโหลดเสร็จ
          notificationList.assignAll(newData);
        }

        int currentPage = responseBody['data']['current_page'];
        int lastPage = responseBody['data']['last_page'];

        isLastPage.value = currentPage >= lastPage;
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData(
            'แจ้งเตือน',
            responseBody['desc'] ??
                'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
      }
    } catch (e) {
      print(e);
      alertEmptyData(
          'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  Future<void> readUpdate(id) async {
    try {
      var response = await connect.post(
        '$baseUrl/emp/notification/read/update',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'id': id,
        },
        // null,
      );

      var responseBody = response.body;
      // print(responseBody['emp_attendance']);

      if (responseBody['statusCode'] == '200') {
        loaddata();
        print('success');
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      print(e);
      // alertEmptyData(
      //     'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
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
