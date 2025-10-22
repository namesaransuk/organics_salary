import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/login_model/login_model.dart';
import 'package:organics_salary/models/login_model/data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/theme.dart';

class LoginController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  // var connect = Get.find<GetConnect>();
  var connect = Get.put(GetConnect());
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var loginList = RxList<LoginModel>();
  RxString selectedPrefixName = 'เลือกคำนำหน้า'.obs;
  RxString firstname = ''.obs;
  RxString lastname = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

  void login(BuildContext context, employeeCode, String password) async {
    loadingController.dialogLoading();

    try {
      final FirebaseMessaging messaging = FirebaseMessaging.instance;

      String deviceKey = '';
      try {
        if (Platform.isIOS) {
          // บน iOS: ถ้าเป็น Simulator จะไม่มี APNs token → getToken มัก error
          // 1) ขอสิทธิ์แจ้งเตือนก่อน (จะไม่มี dialog บน Simulator)
          await messaging.requestPermission(
            alert: true,
            badge: true,
            sound: true,
            announcement: false,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
          );

          final apnsToken = await messaging.getAPNSToken();
          final isSimulator = apnsToken == null;

          if (!isSimulator) {
            final token = await messaging.getToken();
            deviceKey = token ?? '';
          } else {
            // iOS Simulator: ใช้ค่า fallback เพื่อไม่ให้ login พัง
            deviceKey = ''; // หรือ 'SIMULATOR' ถ้า backend ต้องการ non-empty
          }
        } else {
          // Android/แพลตฟอร์มอื่น
          final token = await messaging.getToken();
          deviceKey = token ?? '';
        }
      } catch (e) {
        // กันเคส [firebase_messaging/unknown] และอื่น ๆ
        debugPrint('FCM getToken failed: $e');
        deviceKey = ''; // fallback เพื่อไม่ให้ login ล้ม
      }

      box.write('deviceKey', deviceKey);
      print("deviceKey: $deviceKey");

      //โค๊ดเก่าก่อนจะแก้ให้เข้า emu ได้
      // final deviceKey = await FirebaseMessaging.instance.getToken();
      // box.write('deviceKey', '$deviceKey');
      // print("deviceKey: $deviceKey");

      var response = await connect.post(
        '$baseUrl/employee/login',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'employee_code': employeeCode,
          'password': password,
          'device_id': deviceKey,
        },
      );

      var dataResponse = response.body;
      var statusCode = dataResponse['statusCode'];

      print(statusCode);
      if (statusCode == '00') {
        var dataJSONList = DataModel.fromJson(dataResponse['data']);
        // if (loginJSONList.userStatus == 0 || loginJSONList.userStatus == null) {
        //   box.write('f_name', loginJSONList.fName);
        //   box.write('l_name', loginJSONList.lName);
        //   box.write('username', loginJSONList.username);
        //   Get.offAndToNamed('user-demo');
        // } else {
        box.write('isLogged', true);
        box.write('id', dataJSONList.id);
        box.write('companyId', dataJSONList.companyId);
        box.write('positionId', dataJSONList.positionId);
        box.write('departmentId', dataJSONList.departmentId);
        box.write(
            'personalityCharacterId', dataJSONList.personalityCharacterId);
        box.write('fnamesId', dataJSONList.fnamesId);
        box.write('lnamesId', dataJSONList.lnamesId);
        box.write('nnamesId', dataJSONList.nnamesId);
        box.write('level', dataJSONList.level);
        box.write('empCard', dataJSONList.empCard);
        box.write('gender', dataJSONList.gender);
        box.write('employmentType', dataJSONList.employmentType);
        box.write('employeeCode', dataJSONList.employeeCode);
        box.write('prefix', dataJSONList.prefix);
        box.write('birthday', dataJSONList.birthday);
        box.write('phoneNumber', dataJSONList.phoneNumber);
        box.write('email', dataJSONList.email);
        box.write('idCard', dataJSONList.idCard);
        box.write('startDate', dataJSONList.startDate);
        box.write('endDate', dataJSONList.endDate);
        box.write('username', dataJSONList.username);
        box.write('password', dataJSONList.password);
        box.write('pin', dataJSONList.pin.toString());
        box.write('status', dataJSONList.status);
        box.write('device_key', dataJSONList.deviceKey);
        box.write('social_security_rights', dataJSONList.socialSecurityRights);
        box.write('user_id', dataJSONList.userId);
        box.write('created_at', dataJSONList.createdAt.toString());
        box.write('updated_at', dataJSONList.updatedAt.toString());
        box.write('access_token', dataJSONList.accessToken);
        box.write('encode_access_token', dataJSONList.encodeAccessToken);
        box.write('address', jsonEncode(dataJSONList.address));

        var multitextFnames = dataJSONList.fnames!.multitexts;
        var multitextLnames = dataJSONList.lnames!.multitexts;

        var fnameThai = multitextFnames!
            .firstWhere((item) => item.languageCode == 'th')
            .name;
        // var fnameEnglish = multitextFnames.firstWhere((item) => item.languageCode == 'en').name;
        var lnameThai = multitextLnames!
            .firstWhere((item) => item.languageCode == 'th')
            .name;
        // var lnameEnglish = multitextLnames!.firstWhere((item) => item.languageCode == 'en').name;
        box.write('fnames', fnameThai);
        box.write('lnames', lnameThai);
        // box.write('fnames', jsonEncode(dataJSONList.fnames));
        // box.write('lnames', jsonEncode(dataJSONList.lnames));

        box.write('nnames', jsonEncode(dataJSONList.nnames));
        box.write('companyImage', jsonEncode(dataJSONList.companyImage));

        if (dataJSONList.profileImage != null &&
            dataJSONList.profileImage!.filePath != null) {
          box.write('profileImage', dataJSONList.profileImage!.filePath!);
        } else {
          box.write('profileImage', '');
        }

        var departmentName =
            dataJSONList.department!.departmentText!.singletexts!.name;
        box.write('department', departmentName);

        // box.write(
        //   'image',
        //   dataJSONList.image ?? 'assets/img/user.png',
        // );
        print(dataJSONList.accessToken);
        if (box.read('pin') == 'null' || box.read('pin') == '') {
          Get.toNamed('/pinauth', arguments: 1);
        } else {
          // final FirebaseMessaging messaging = FirebaseMessaging.instance;

          // final deviceKey = await FirebaseMessaging.instance.getToken();
          // box.write('deviceKey', '$deviceKey');
          // print("deviceKey: $deviceKey");

          // await connect.post(
          //   '$baseUrl/employee/change/devicekey',
          //   headers: {
          //     'Authorization': 'Bearer $token',
          //     'Content-Type': 'application/json',
          //   },
          //   {
          //     'emp_id': dataJSONList.id,
          //     'device_key': deviceKey,
          //   },
          // );

          // final fcmToken = await FirebaseMessaging.instance.getToken(); //fcmToken
          // final apnsToken = await FirebaseMessaging.instance.getAPNSToken(); //apnsToken

          const String topic = 'news';
          //โค๊ดเก่าก่อนจะแก้ให้เข้าผ่าน emu
          //await messaging.subscribeToTopic(topic);

          try {
            // ข้ามบน iOS Simulator (ไม่มี APNs)
            final bool isIosSimulator = Platform.isIOS &&
                (await FirebaseMessaging.instance.getAPNSToken()) == null;

            // เอา deviceKey ที่คุณได้มาก่อนหน้านี้มาใช้ (เก็บใน box แล้ว)
            final String deviceKey = (box.read('deviceKey') ?? '').toString();

            if (!isIosSimulator && deviceKey.isNotEmpty) {
              await messaging.subscribeToTopic(topic);
              debugPrint('Subscribed to topic: $topic');
            } else {
              debugPrint(
                  'Skip subscribeToTopic: isIosSimulator=$isIosSimulator, deviceKey="$deviceKey"');
            }
          } catch (e) {
            debugPrint(
                'subscribeToTopic failed: $e'); // กัน [firebase_messaging/unknown]
          }

          print('Subscribed to topic: $topic');

          Get.offAllNamed('home');
        }
        // }
      } else {
        Get.back();
        alertEmptyData(context, 'แจ้งเตือน',
            dataResponse['message'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e, s) {
      Get.back();
      // alertEmptyData(
      //     context, 'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      alertEmptyData(
          context, 'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      print(e);
      print(s);
    }
  }

  void register() async {
    loadingController.dialogLoading();

    dynamic selectedValues = selectedPrefixName.split(' ');
    // String prefixId = selectedValues[0];
    String prefixName = selectedValues[1];
    print(prefixName);
    print(firstname);
    print(lastname);
    print(email);
    print(password);

    try {
      var response = await connect.post(
        '$baseUrl/app/register/employee/create',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'pre_name': prefixName,
          'f_name': firstname.value,
          'l_name': lastname.value,
          'username': email.value,
          'password': password.value,
        },
      );

      print(response.body);

      Map<String, dynamic> responseBody = response.body['data'];
      Get.back();

      if (responseBody['statusCode'] == '00') {
        print('success');
        box.write('f_name', responseBody['f_name']);
        box.write('l_name', responseBody['l_name']);
        box.write('username', responseBody['username']);

        Get.offAndToNamed('user-demo');
      } else {
        // Get.toNamed(page)
        print('failed');
      }
    } catch (e) {
      print('Error: $e');
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
}
