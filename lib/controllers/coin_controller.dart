import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/theme.dart';

class CoinController extends GetxController {
  var connect = Get.find<GetConnect>();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  final box = GetStorage();

  final LoadingController loadingController = Get.put(LoadingController());
  var coinList = RxList([]);
  var coinListAll = RxList([]);
  var coinHistory = RxList([]);

  RxString empCoin = RxString('');
  RxString empHeart = RxString('');
  RxString selectedCarBrand = RxString('');

  var selectedMode = 0.obs;

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/exchange/reward/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'language': 'th',
          'company_id': box.read('companyId'),
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        coinList.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      // Get.back();
      print(e);
      //   alertEmptyData(
      //       'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadHistory() async {
    // coinList.clear();
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/exchange/histories',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'language': 'th',
          'user_id': box.read('id'),
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        coinHistory.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      // Get.back();
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadCurrencies() async {
    // coinList.clear();
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/currencies/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'language': 'th',
          'emp_id': box.read('id'),
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        var responseData = responseBody['data'];

        empCoin.value = responseData['coin']?['amount_item']?.toString() ?? '0';
        empHeart.value =
            responseData['heart']?['amount_item']?.toString() ?? '0';

        // for (var item in responseBody['data']) {
        //   if (item['name'] == 'Coin') {
        //     empCoin.value = item['store_reward_summary_view']?['amount_item']?.toString() ?? '0';
        //   } else if (item['name'] == 'Heart') {
        //     empHeart.value = item['store_reward_summary_view']?['amount_item']?.toString() ?? '0';
        //   }
        // }

        print('Coin: $empCoin');
        print('Heart: $empHeart');
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      // Get.back();
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void sendData(coin) async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/rewards/exchange',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'language': 'th',
          'user_id': box.read('id'),
          'current_company_id': box.read('companyId'),
          'id': coin['id'],
          'destination_rate': coin['cost_price'],
        },
      );
      Get.back();
      Get.back();

      print(response.body);

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        print('success');
        loadCurrencies();
        Get.offAndToNamed('/status-success');
      } else {
        Get.offAndToNamed('/status-cancel');
        // Get.toNamed(page)
      }
    } catch (e) {
      Get.offAndToNamed('/status-cancel');
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
