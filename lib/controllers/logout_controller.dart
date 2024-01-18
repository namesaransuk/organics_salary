import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

class LogoutController extends GetxController {
  LoadingController loadingController = LoadingController();
  final box = GetStorage();
  // var connect = Get.find<GetConnect>();
  // var baseUrl = dotenv.env['API_URL'];

  void logout() async {
    loadingController.dialogLoading();
    // var response = await connect.post(
    //   '$baseUrl/employee/Logout',
    //   null,
    // );

    // print(response);
    // Get.deleteAll();
    GetStorage().erase();

    await Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed('/login');
    });
  }
}
