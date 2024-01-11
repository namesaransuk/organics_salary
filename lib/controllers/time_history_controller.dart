import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/time_history_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TimeHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  RxString monthName = 'เดือน'.obs;
  RxString yearName = 'ปี'.obs;
  RxString ddMonthName = 'เดือน'.obs;
  RxString ddYearName = 'ปี'.obs;
  var timeHistoryList = RxList<TimeHistoryModel>();
  var baseUrl = dotenv.env['API_URL'];
  var connect = Get.find<GetConnect>();
  final box = GetStorage();

  void getMonthName(String mName) {
    ddMonthName.value = mName;
  }

  void getYear(String yName) {
    ddYearName.value = yName;
  }

  void loadData(String textMonth, int month, String year) async {
    loadingController.dialogLoading();
    timeHistoryList.clear();
    try {
      var response = await connect.post(
        '$baseUrl/employee/empPasteCardLog',
        {
          'emp_id': box.read('id'),
          'month': month,
        },
      );

      print(box.read('id'));

      // if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = response.body;
      monthName.value = textMonth;
      yearName.value = year;

      if (responseBody['statusCode'] == '00') {
        var timeHistoryListJSONList = responseBody['empLog'];

        var mappedtimeHistoryList =
            timeHistoryListJSONList.map<TimeHistoryModel>(
          (timeHistoryListJSON) =>
              TimeHistoryModel.fromJson(timeHistoryListJSON),
        );

        var convertedtimeHistoryList =
            RxList<TimeHistoryModel>.of(mappedtimeHistoryList);

        timeHistoryList.assignAll(convertedtimeHistoryList);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
      Get.back();
      // } else {
      //   Get.back();
      //   print('Disconnect');
      // }
    } catch (e) {
      print(e);
      Get.back();
    }
  }
}
