import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/controllers/logout_controller.dart';
import 'package:organics_salary/theme.dart';

class PinController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final LogoutController logoutController = Get.put(LogoutController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());

  String firstPin = '';
  String secondPin = '';

  void savepin(pin, section) async {
    firstPin = pin;
    Get.toNamed('/confirm-pinauth', arguments: section);
  }

  void confirmpin(context, pin, section) async {
    secondPin = pin;
    //   print('1 ${firstPin}');
    //   print('2 ${secondPin}');

    try {
      if (firstPin == secondPin) {
        loadingController.dialogLoading();
        var response = await connect.post(
          '$baseUrl/employee/change/pin',
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          {
            'id': box.read('id'),
            'pin': secondPin,
          },
        );

        Get.back();

        var responseBody = response.body;
        print(responseBody['pin']);
        if (responseBody['statusCode'] == '00') {
          box.write('pin', responseBody['pin']);
          print(section);

          // await Future.delayed(const Duration(seconds: 1), () {
          if (section == 1) {
            Get.offAllNamed('/');
          } else if (section == 2) {
            Get.back();
            Get.back();
            Get.back();
            alertEmptyData(
                context, 'แจ้งเตือน', 'เปลี่ยนรหัส PIN เรียบร้อยแล้ว');
          } else {
            alertLogout(context);
          }
          // });
        } else {
          print('failed with status code: ${responseBody['statusCode']}');
          alertEmptyData(context, 'แจ้งเตือน',
              responseBody['message'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        }
      } else {
        // Get.offAllNamed('pinauth');
        await Future.delayed(const Duration(seconds: 1), () {
          Get.back();
        });
        alertEmptyData(context, 'แจ้งเตือน',
            'รหัส PIN ที่ระบุไม่ตรงกัน กรุณาลองใหม่อีกครั้ง');
        // alertLogout(context);
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
      // Get.offAllNamed('pinauth');
      // await Future.delayed(const Duration(seconds: 1), () {
      // alertEmptyData(
      //     context, 'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      alertLogout(context);
      // });
      print(e);
    }
  }

  Future<Map<String, dynamic>> checkpin(context, pin) async {
    //   print('1 ${firstPin}');
    //   print('2 ${secondPin}');

    loadingController.dialogLoading();
    try {
      var response = await connect.post(
        '$baseUrl/check-pin',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'pin': pin,
        },
      );

      Get.back();

      var responseBody = response.body;
      print(responseBody);

      if (responseBody['statusCode'] == 200) {
        return {'success': true, 'message': 'ตรวจสอบ PIN สำเร็จ'};
      } else {
        return {
          'success': false,
          'message':
              responseBody['errDesc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง'
        };
      }
    } catch (e) {
      Get.back();
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง'
      };
    }
  }

  void alertEmptyData(BuildContext context, String title, String detail) {
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

  void alertLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          title: Container(
            color: AppTheme.ognSmGreen,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: const Center(
              child: Text(
                'แจ้งเตือน',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('เกิดข้อผิดพลาด กรุณาเข้าสู่ระบบใหม่อีกครั้ง'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                logoutController.logout();
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
        );
      },
    );
  }
}
