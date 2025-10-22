import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/models/provident_fund_model.dart';
import 'package:organics_salary/theme.dart';

class ProvidentFundController extends GetxController {
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
  var providentFundList = RxList<ProvidentFundModel>();
  RxString providentFundDetail = RxString('');

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
    providentFundList.clear();

    try {
      var response = await connect.post(
        '$baseUrl/reserve/fund/filter',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'startDate': startMonthYearName.toString(),
          'endDate': endMonthYearName.toString(),
          // 'created_at': startMonthYearName.toString(),
          // 'updated_at': endMonthYearName.toString(),
        },
      );

      // if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = response.body;
      Get.back();

      if (responseBody['statusCode'] == '00') {
        var providentFundListJSONList = responseBody['data'];

        var mappedprovidentFundList =
            providentFundListJSONList.map<ProvidentFundModel>(
          (providentFundListJSON) =>
              ProvidentFundModel.fromJson(providentFundListJSON),
        );

        var convertedprovidentFundList =
            RxList<ProvidentFundModel>.of(mappedprovidentFundList);

        providentFundList.assignAll(convertedprovidentFundList);
      } else {
        providentFundList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  void sendData() async {
    // print(savingsAmount);
    // print(savingsDetail);
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/reserve/fund/withdraw',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'reserse_fund_detail': providentFundDetail.value,
        },
      );

      print(response.body);

      Map<String, dynamic> responseBody = response.body;
      Get.back();

      if (responseBody['statusCode'] == '00') {
        print('success');
        Get.offAndToNamed('provident-fund-status-send', arguments: 1);
      } else {
        Get.offAndToNamed('provident-fund-status-send', arguments: 2);
        // Get.toNamed(page)
      }
    } catch (e) {
      Get.offAndToNamed('provident-fund-status-send', arguments: 2);
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
