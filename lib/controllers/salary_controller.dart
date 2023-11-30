import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

class SalaryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  RxString monthName = ''.obs;
  RxList<Map<String, dynamic>> dataList = RxList<Map<String, dynamic>>();

  void getMonthName(String mName) async {
    monthName.value = mName;
  }

  void loadData(int month) async {
    loadingController.dialogLoading();

    await Future.delayed(const Duration(seconds: 1), () {
      Get.back();

      dataList.clear();
      if (month == 1) {
        dataList.addAll([
          {
            'name': 'John Doe',
            'customer': 'IT1234',
            'role': "IT Programer",
            'salaryMonth': "มกราคม",
            'yearValue': "2567",
            'salary': 50000,
            'da': 5000,
            'ot': 2000,
            'fc': 1000,
            'bonus': 3000,
            'interest': 100,
            'pm': 4000,
            'oi': 1500,
            'ti': 65500,
            'ss': 2000,
            'tax': 8000,
            'agl': 500,
            'loan': 3000,
            'df': 1000,
            'od': 200,
            'td': 15700,
            'total': 49800,
          },
        ]);
      } else if (month == 2) {
        dataList.addAll([
          {
            'name': 'John Doe',
            'customer': 'IT1234',
            'role': "IT Programer",
            'salaryMonth': "กุมภาพันธ์",
            'yearValue': "2567",
            'salary': 50000,
            'da': 5000,
            'ot': 2000,
            'fc': 1000,
            'bonus': 3000,
            'interest': 100,
            'pm': 4000,
            'oi': 1500,
            'ti': 65500,
            'ss': 2000,
            'tax': 8000,
            'agl': 500,
            'loan': 3000,
            'df': 1000,
            'od': 200,
            'td': 15700,
            'total': 49800,
          },
        ]);
      } else if (month == 3) {
        dataList.addAll([
          {
            'name': 'John Doe',
            'customer': 'IT1234',
            'role': "IT Programer",
            'salaryMonth': "มีนาคม",
            'yearValue': "2567",
            'salary': 50000,
            'da': 5000,
            'ot': 2000,
            'fc': 1000,
            'bonus': 3000,
            'interest': 100,
            'pm': 4000,
            'oi': 1500,
            'ti': 65500,
            'ss': 2000,
            'tax': 8000,
            'agl': 500,
            'loan': 3000,
            'df': 1000,
            'od': 200,
            'td': 15700,
            'total': 49800,
          },
        ]);
      }
    });
  }
}
