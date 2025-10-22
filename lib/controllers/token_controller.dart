import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class TokenController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var connect = Get.find<GetConnect>();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];

  Future<void> checkToken() async {
    loadingController.dialogLoading();
    // print('access_token: ${box.read('access_token')}');
    // print('encode_access_token: ${box.read('encode_access_token')}');

    try {
      var response = await connect.post(
          // '$baseUrl/check-token',
          '$baseUrl/employee/login/repeat',
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          {
            'employee_code': box.read('employeeCode'),
            'device_key': box.read('device_key')
          });

      print(response);

      var responseBody = response.body;
      if (responseBody['statusCode'] == 200) {
        // Get.offAllNamed('/');
        if (responseBody['pin'] == null || responseBody['pin'] == '') {
          Get.offAllNamed('/pinauth', arguments: 1);
        } else {
          Get.offAllNamed('/pin');
        }
      } else {
        GetStorage().erase();
        Get.offAllNamed('failed-token');
      }
    } catch (e) {
      GetStorage().erase();
      Get.offAllNamed('failed-token');
    }
  }
}
