import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organics_salary/theme.dart';
import 'package:image_picker/image_picker.dart';

class RecordWorkTimeController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.find<GetConnect>();
  final box = GetStorage();
  Rx<XFile?> pickedFile = Rx<XFile?>(null);

  Future sendSlipRequest() async {
    // loadingController.dialogLoading();

    // print('selectedMonths: $selectedMonths');

    // Get.back();
    // try {
    //   var response = await connect.post(
    //     '$baseUrl/salary/request/slip/create',
    //     {
    //       'emp_id': box.read('id'),
    //       'month_request': strMonth,
    //       'reason_request': '$inputCause',
    //       'use_date': '$usedDate',
    //     },
    //   );

    //   // print(response.body);

    //   Map<String, dynamic> responseBody = response.body;
    //   Get.back();

    //   if (responseBody['statusCode'] == '00') {
    //     return responseBody;
    //   }
    // } catch (e) {
    //   Get.back();
    //   print('Error: $e');
    // }

    // return {'statusCode': 'error', 'message': 'Failed to send data'};
    return true;
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
