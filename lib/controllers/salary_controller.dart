import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';

class SalaryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  var dataList = <Map<String, dynamic>>[].obs;

  void loadData() {
    loadingController.dialogLoading();

    Future.delayed(const Duration(seconds: 3), () {
      Get.back();

      dataList.clear();
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
    });
  }
}
