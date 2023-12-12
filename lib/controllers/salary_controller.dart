import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/salary_model.dart';

class SalaryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  RxInt monthId = 0.obs;
  RxString monthName = 'กรุณาเลือกเดือน'.obs;
  var salaryList = RxList<SalaryModel>();

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
            'name': 'Dr.Jel Organics',
            'customer': 'IT1234',
            'role': "CEO",
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
        ];
        break;
      case 2:
        response = [
          {
            'name': 'Dr.Jel Organics',
            'customer': 'IT1234',
            'role': "CEO",
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
        ];
        break;
      case 3:
        response = [
          {
            'name': 'Dr.Jel Organics',
            'customer': 'IT1234',
            'role': "CEO",
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
        ];
        break;
      default:
        response = [];
    }

    var salaryJSONList = response;

    var mappedSalaryList = salaryJSONList.map(
      (salaryJSON) {
        return SalaryModel.fromJson(salaryJSON);
      },
    );

    var convertedSalaryList = RxList<SalaryModel>.of(mappedSalaryList);

    salaryList.assignAll(convertedSalaryList);

    await Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }
}
