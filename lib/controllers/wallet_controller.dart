import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/theme.dart';

class WalletController extends GetxController {
  var connect = Get.find<GetConnect>();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  final box = GetStorage();

  final LoadingController loadingController = Get.put(LoadingController());

  var currenciesOriginList = RxList([]);
  var currenciesDestinationList = RxList([]);
  var currenciesList = RxList([]);
  RxString originUnit = RxString('');
  RxString destinationUnit = RxString('');

  RxString c_startDate = RxString('');
  RxString c_endDate = RxString('');
  var coinQuantity = RxList([]);

  RxString h_startDate = RxString('');
  RxString h_endDate = RxString('');
  var heartQuantity = RxList([]);

  RxString firstConvert = RxString('เลือกหน่วย');
  RxString secondConvert = RxString('เลือกหน่วย');

  RxString empCoin = RxString('');
  RxString empHeart = RxString('');

  RxString exchangeAmount = RxString('');

  var historyExchange = RxList([]);

  var historyCoinExchange = RxList([]);
  var historyHeartExchange = RxList([]);
  RxString searchStartDate = RxString('');
  RxString searchEndDate = RxString('');

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

  void loadCurrenciesExchange() async {
    // coinList.clear();
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/setupSwap/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          // 'emp_id': box.read('id'),
          'origin_id': 2,
          'company_id': box.read('companyId'),
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        currenciesList.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      // Get.back();
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadConvertCurrencies() async {
    // coinList.clear();
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/convert/currencies/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        final currenciesData = responseBody['data'] as Map<String, dynamic>;
        currenciesOriginList.assignAll(currenciesData['origin_items']);
        currenciesDestinationList
            .assignAll(currenciesData['destination_items']);
        print(currenciesOriginList);
        print(currenciesDestinationList);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      // Get.back();
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadHistoryExchange() async {
    // coinList.clear();
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/history/currency',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'start_date': searchStartDate.value,
          'end_date': searchEndDate.value,
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        historyExchange.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      // Get.back();
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void loadHistoryCoinAndHeartExchange() async {
    // coinList.clear();
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/history/coin',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'start_date': searchStartDate.value,
          'end_date': searchEndDate.value,
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        var dataList = responseBody['data'] as List<dynamic>;

        // กรองข้อมูลสำหรับ historyCoinExchange
        historyCoinExchange.assignAll(
          dataList.where((item) => item['currencies']['id'] == 1).toList(),
        );

        // กรองข้อมูลสำหรับ historyHeartExchange
        historyHeartExchange.assignAll(
          dataList.where((item) => item['currencies']['id'] == 2).toList(),
        );
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      // Get.back();
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void sendData(item) async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/setup/swap/coin',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'company_id': box.read('companyId'),
          'id': item?['id'],
          'origin_rate': item?['origin_rate'],
          'origin_item_id': item?['origin_item_id'],
          'destination_rate': item?['destination_rate'],
          'destination_item_id': item?['destination_item_id'],
        },
      );
      Get.back();
      Get.back();
      Get.back();

      print(response.body);

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        print('success');
        loadCurrencies();
        Get.delete<WalletController>();
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

  void sendDataPromotion() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/currencies/swap/promotion',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'company_id': box.read('companyId'),
          'amount': exchangeAmount.value,
        },
      );
      Get.back();
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
