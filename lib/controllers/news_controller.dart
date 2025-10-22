import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/news_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';

class NewsController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());

  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.find<GetConnect>();
  final box = GetStorage();

  var newsList = RxList<NewsModel>();
  var newsSectionList = RxList<NewsModel>();
  RxInt current = 0.obs;

  Future<void> loadData() async {
    // loadingController.dialogLoading();

    // Get.back();
    try {
      var response = await connect.post(
        '$baseUrl/news/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        null,
      );
      // Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == '00') {
        var newsJSONList = responseBody['news_list'];

        var mappednewsList = newsJSONList.map<NewsModel>(
          (newsListJSON) => NewsModel.fromJson(newsListJSON),
        );

        var convertednewsList = RxList<NewsModel>.of(mappednewsList);

        newsList.assignAll(convertednewsList);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      // Get.back();
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> loadSectionData(id) async {
    loadingController.dialogLoading();

    // Get.back();
    try {
      var response = await connect.post(
        '$baseUrl/news/notice/search/by/id',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'news_id': id,
        },
      );
      Get.back();

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == '00') {
        var newsJSONList = responseBody['searchNewsById'];

        var mappednewsList = newsJSONList.map<NewsModel>(
          (newsListJSON) => NewsModel.fromJson(newsListJSON),
        );

        var convertednewsList = RxList<NewsModel>.of(mappednewsList);

        newsSectionList.assignAll(convertednewsList);
        Get.toNamed('news-section');
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      Get.back();
      print(e);
      alertEmptyData(
          'แจ้งเตือน', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งในภายหลัง');
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
