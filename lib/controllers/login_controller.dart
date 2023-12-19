import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/login_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var loginList = RxList<LoginModel>();

  void login(BuildContext context, username, String password) async {
    var connect = Get.find<GetConnect>();
    var baseUrl = dotenv.env['API_URL'];
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/employee/Login',
        {
          'username': username,
          'password': password,
        },
      );

      var loginJSONList = LoginModel.fromJson(response.body);
      Get.back();
      if (loginJSONList.statusCode == '00') {
        GetStorage().write('isLogged', true);
        GetStorage().write('id', loginJSONList.id);
        GetStorage().write('company_id', loginJSONList.companyId);
        GetStorage().write('position_id', loginJSONList.positionId);
        GetStorage().write('department_id', loginJSONList.departmentId);
        GetStorage().write('employee_card_id', loginJSONList.employeeCardId);
        GetStorage().write('employee_code', loginJSONList.employeeCode);
        GetStorage().write('pre_name', loginJSONList.preName);
        GetStorage().write('f_name', loginJSONList.fName);
        GetStorage().write('l_name', loginJSONList.lName);
        GetStorage().write('n_name', loginJSONList.nName);
        GetStorage().write('gender_id', loginJSONList.genderId);
        GetStorage().write('birthday', loginJSONList.birthday);
        GetStorage().write('mobile', loginJSONList.mobile);
        GetStorage().write('card_add', loginJSONList.cardAdd);
        GetStorage().write('current_add', loginJSONList.currentAdd);
        GetStorage().write('id_card', loginJSONList.idCard);
        GetStorage().write('start_date', loginJSONList.startDate);
        GetStorage().write('end_date', loginJSONList.endDate);
        GetStorage().write('y_experience', loginJSONList.yExperience);
        GetStorage().write('image', loginJSONList.image);
        GetStorage().write('record_status', loginJSONList.recordStatus);
        GetStorage().write('coins', loginJSONList.coins);
        GetStorage().write('username', loginJSONList.username);
        GetStorage().write('password', loginJSONList.password);
        // GetStorage().write('created_at', loginJSONList.createdAt);
        // GetStorage().write('updated_at', loginJSONList.updatedAt);
        GetStorage().write('access_token', loginJSONList.accessToken);

        Get.offAndToNamed('home');
      } else {
        alertEmptyData(
            context, 'แจ้งเตือน', 'รหัสพนักงานหรือรหัสผ่านไม่ถูกต้อง');
      }
    } catch (e) {
      alertEmptyData(
          context, 'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      print(e);
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
