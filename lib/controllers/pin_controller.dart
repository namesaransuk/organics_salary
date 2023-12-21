import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

class PinController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];

  String firstPin = '';
  String secondPin = '';

  void savepin(pin) async {
    firstPin = pin;
    Get.toNamed('/confirm-pin');
  }

  void confirmpin(context, pin) async {
    loadingController.dialogLoading();
    secondPin = pin;
    //   print('1 ${firstPin}');
    //   print('2 ${secondPin}');

    if (firstPin == secondPin) {
      Get.offAllNamed('/');
    } else {
      alertEmptyData(
          context, 'แจ้งเตือน', 'รหัส PIN ไม่ตรงกัน กรุณาลองใหม่อีกครั้ง');
    }
  }

  void alertEmptyData(BuildContext context, String title, String detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          content: Text(detail),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ตกลง"),
            ),
          ],
        );
      },
    );
  }
}
