import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/savings_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';

class SavingsController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());

  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.find<GetConnect>();
  final box = GetStorage();

  RxString c_startDate = ''.obs;
  RxString c_endDate = ''.obs;

  RxString startMonthYearName = ''.obs;
  RxString endMonthYearName = ''.obs;

  RxString monthName = 'เดือน'.obs;
  RxString yearName = 'ปี'.obs;
  RxString ddMonthName = 'เดือน'.obs;
  RxString ddYearName = 'ปี'.obs;
  var savingsList = RxList<SavingsModel>();
  var savingsWithdrawList = RxList<SavingsModel>();
  RxString savingsAmount = RxString('');
  RxString savingsDetail = RxString('');

  void getMonthName(String mName) {
    ddMonthName.value = mName;
    monthName.value = mName;
  }

  void getYear(String yName) {
    ddYearName.value = yName;
    yearName.value = yName;
  }

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/get/saving/money/by/id',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'save_status': 1,
          'from_date': startMonthYearName.toString(),
          'to_date': endMonthYearName.toString(),
        },
      );

      // if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = response.body;
      Get.back();

      if (responseBody['statusCode'] == '00') {
        var savingsListJSONList = responseBody['data'];

        var mappedsavingsList = savingsListJSONList.map<SavingsModel>(
          (savingsListJSON) => SavingsModel.fromJson(savingsListJSON),
        );

        var convertedsavingsList = RxList<SavingsModel>.of(mappedsavingsList);

        savingsList.assignAll(convertedsavingsList);
      } else {
        savingsList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        print('test savings else');
      }
      // } else {
      //   Get.back();
      //   print('Disconnect');
      // }
    } catch (e) {
      print(e);
      print('test savings');
      Get.back();
    }
  }

  void loadDataWithdraw() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/get/saving/money/by/id',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'save_status': 2,
          'from_date': startMonthYearName.toString(),
          'to_date': endMonthYearName.toString(),
        },
      );

      // if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = response.body;
      Get.back();

      if (responseBody['statusCode'] == '00') {
        var savingsWithdrawListJSONList = responseBody['data'];

        var mappedsavingsWithdrawList =
            savingsWithdrawListJSONList.map<SavingsModel>(
          (savingsWithdrawListJSON) =>
              SavingsModel.fromJson(savingsWithdrawListJSON),
        );

        var convertedsavingsWithdrawList =
            RxList<SavingsModel>.of(mappedsavingsWithdrawList);

        savingsWithdrawList.assignAll(convertedsavingsWithdrawList);
      } else {
        savingsWithdrawList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        print('test savings');
      }
    } catch (e) {
      print(e);
      print('test savings');
      Get.back();
    }
  }

  void sendData() async {
    // print(savingsAmount);
    // print(savingsDetail);
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/create/withdraw/money',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'amount': savingsAmount.value,
          'remark': savingsDetail.value,
        },
      );

      print(response.body);

      Map<String, dynamic> responseBody = response.body;
      Get.back();

      if (responseBody['statusCode'] == '00') {
        print('success');
        Get.offAndToNamed('savings-status-send', arguments: 1);
      } else {
        Get.offAndToNamed('savings-status-send', arguments: 2);
        // Get.toNamed(page)
      }
    } catch (e) {
      Get.offAndToNamed('savings-status-send', arguments: 2);
      print('Error: $e');
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
