import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class TokenController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var status = false;

  void checkToken() async {
    var connect = Get.find<GetConnect>();
    var baseUrl = dotenv.env['API_URL'];

    if (box.read('access_token') != null) {
      List<String> parts = box.read('access_token').split('|');
      // var response = await connect.post(
      //   '$baseUrl/employee/Login',
      //   {
      //     'username': username,
      //     'password': password,
      //   },
      // );

      String number = parts[0];

      print('Number: $number');

      status = true;
    } else {
      status = false;
    }
  }
}
