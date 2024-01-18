import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/login_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var loginList = RxList<LoginModel>();
  final box = GetStorage();

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
        box.write('isLogged', true);
        box.write('id', loginJSONList.id);
        box.write('company_id', loginJSONList.companyId);
        box.write('company_name_th', loginJSONList.companyNameTh);
        box.write('company_name_en', loginJSONList.companyNameEn);
        box.write('position_id', loginJSONList.positionId);
        box.write('position_name_th', loginJSONList.positionNameTh);
        box.write('position_name_en', loginJSONList.positionNameEn);
        box.write('department_id', loginJSONList.departmentId);
        box.write('department_name_th', loginJSONList.departmentNameTh);
        box.write('department_name_en', loginJSONList.departmentNameEn);
        box.write('employee_card_id', loginJSONList.employeeCardId);
        box.write('employee_code', loginJSONList.employeeCode);
        box.write('pre_name', loginJSONList.preName);
        box.write('f_name', loginJSONList.fName);
        box.write('l_name', loginJSONList.lName);
        box.write('n_name', loginJSONList.nName);
        box.write('gender_id', loginJSONList.genderId);
        box.write('birthday', loginJSONList.birthday);
        box.write('mobile', loginJSONList.mobile);
        box.write('card_add', loginJSONList.cardAdd);
        box.write('current_add', loginJSONList.currentAdd);
        box.write('id_card', loginJSONList.idCard);
        box.write('start_date', loginJSONList.startDate);
        box.write('end_date', loginJSONList.endDate);
        box.write('y_experience', loginJSONList.yExperience);
        box.write(
          'image',
          loginJSONList.image ?? 'assets/img/user.png',
        );
        box.write('record_status', loginJSONList.recordStatus);
        box.write('coins', loginJSONList.coins);
        box.write('username', loginJSONList.username);
        box.write('password', loginJSONList.password);
        // box.write('created_at', loginJSONList.createdAt);
        // box.write('updated_at', loginJSONList.updatedAt);
        box.write('pin', '${loginJSONList.pin}');
        box.write('accessa_token', loginJSONList.accessToken);

        if (box.read('pin') == 'null' || box.read('pin') == '') {
          Get.offAndToNamed('pinauth');
        } else {
          Get.offAndToNamed('pin');
          // Get.offAndToNamed('home');
        }
      } else {
        alertEmptyData(
            context, 'แจ้งเตือน', 'รหัสพนักงานหรือรหัสผ่านไม่ถูกต้อง');
      }
    } catch (e) {
      Get.back();
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
          actionsAlignment: MainAxisAlignment.center,
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
