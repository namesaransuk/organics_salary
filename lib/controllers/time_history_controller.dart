import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/time_history_model.dart';

class TimeHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var timeHistoryList = RxList<TimeHistoryModel>();
  RxString monthName = 'กรุณาเลือกเดือน'.obs;

  void getMonthName(String mName) {
    monthName.value = mName;
  }

  void loadData(int month) async {
    loadingController.dialogLoading();

    var response = [];

    switch (month) {
      case 1:
        response = [
          {
            'id': '1',
            'date': '4 มกราคม 2567',
            'time': '08:00',
          },
          {
            'id': '2',
            'date': '4 มกราคม 2567',
            'time': '18:10',
          },
          {
            'id': '3',
            'date': '5 มกราคม 2567',
            'time': '08:00',
          },
          {
            'id': '4',
            'date': '5 มกราคม 2567',
            'time': '12:00',
          },
          {
            'id': '5',
            'date': '5 มกราคม 2567',
            'time': '13:01',
          },
          {
            'id': '6',
            'date': '5 มกราคม 2567',
            'time': '18:01',
          },
        ];
        break;
      case 2:
        response = [
          {
            'id': '1',
            'date': '4 มกราคม 2567',
            'time': '08:10',
          },
          {
            'id': '2',
            'date': '4 มกราคม 2567',
            'time': '12:10',
          },
          {
            'id': '3',
            'date': '4 มกราคม 2567',
            'time': '12:59',
          },
          {
            'id': '4',
            'date': '4 มกราคม 2567',
            'time': '18:10',
          },
        ];
        break;
      case 3:
        response = [
          {
            'id': '1',
            'date': '4 มกราคม 2567',
            'time': '08:10',
          },
        ];
        break;
      default:
        response = [];
    }

    var timeHistoryJSONList = response;

    var mappedtimeHistoryList = timeHistoryJSONList.map(
      (timeHistoryJSON) {
        return TimeHistoryModel.fromMap(timeHistoryJSON);
      },
    );

    var convertedtimeHistoryList =
        RxList<TimeHistoryModel>.of(mappedtimeHistoryList);

    timeHistoryList.assignAll(convertedtimeHistoryList);

    await Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }
}
