import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/theme.dart';

class PinController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var connect = Get.find<GetConnect>();

  String firstPin = '';
  String secondPin = '';

  void savepin(pin) async {
    firstPin = pin;
    Get.toNamed('/confirm-pinauth');
  }

  void confirmpin(context, pin) async {
    secondPin = pin;
    //   print('1 ${firstPin}');
    //   print('2 ${secondPin}');

    loadingController.dialogLoading();
    try {
      if (firstPin == secondPin) {
        var response = await connect.post(
          '$baseUrl/employee/empPin',
          {
            'id': box.read('id'),
            'pin': secondPin,
          },
        );

        Get.back();

        if (response.statusCode == 200) {
          Map<String, dynamic> responseBody = response.body;
          if (responseBody['statusCode'] == '00') {
            box.write('pin', '$secondPin');

            // await Future.delayed(const Duration(seconds: 1), () {
            Get.offAllNamed('/');
            // });
            print('success');
          } else {
            print('failed with status code: ${responseBody['statusCode']}');
            alertEmptyData(
                context, 'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
          }
        } else {
          alertEmptyData(
              context, 'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        }
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          Get.back();
        });

        alertEmptyData(
            context, 'แจ้งเตือน', 'รหัส PIN ไม่ตรงกัน กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      Get.back();
      print(e);
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
          color: AppTheme.ognGreen,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
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
            child: Text("ตกลง"),
          ),
        ],
      ),
    );
  }
}
