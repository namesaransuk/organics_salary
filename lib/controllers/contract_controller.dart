import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/models/contract_list_history_model/data.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_asset_loan.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_competition.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_confidentiality.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_contract.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_educational.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_form.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_house.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_id_card.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_paid_training.dart';
import 'package:organics_salary/models/contract_list_history_model/emp_saving_contract.dart';
import 'package:organics_salary/models/employee_data_model/emp_book_bank.dart';

import 'package:organics_salary/theme.dart';

class ContractController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final emp_id = GetStorage().read('id');

  var contractList = RxList<ContractData>();

  var empContractList = RxList<EmpContract>();
  var empConfidentialityList = RxList<EmpConfidentiality>();
  var empCompetitionList = RxList<EmpCompetition>();
  var empPaidTrainingList = RxList<EmpPaidTraining>();
  var empAssetLoanList = RxList<EmpAssetLoan>();
  var empSavingContractList = RxList<EmpSavingContract>();
  var empFormList = RxList<EmpForm>();
  var empIdCardList = RxList<EmpIdCard>();
  var empHouseList = RxList<EmpHouse>();
  var empEducationalList = RxList<EmpEducational>();
  var empBookBankList = RxList<EmpBookBank>();

  late RxList filteredContractList;
  RxString selectedContractText = RxString('เลือกประเภทสัญญา');
  RxString selectedContractDetail = RxString('');
  // Rx<XFile?> selectedFiles = Rx<XFile?>(null);
  RxList<Map<String, dynamic>> selectedFiles = <Map<String, dynamic>>[].obs;
  RxList listContract = RxList<dynamic>([]);

  void loadData() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/employee/data',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'companies_id': box.read('companyId'),
        },
      );
      Get.back();

      var responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        var empContractJSONList = responseBody['data']['emp_contract'];
        var empConfidentialityJSONList =
            responseBody['data']['emp_confidentiality'];
        var empCompetitionJSONList = responseBody['data']['emp_competition'];
        var empPaidTrainingJSONList = responseBody['data']['emp_paid_training'];
        var empAssetLoanJSONList = responseBody['data']['emp_asset_loan'];
        var empSavingContractJSONList =
            responseBody['data']['emp_saving_contract'];
        var empFormJSONList = responseBody['data']['emp_form'];
        var empIdCardJSONList = responseBody['data']['emp_id_card'];
        var empHouseJSONList = responseBody['data']['emp_house'];
        var empEducationalJSONList = responseBody['data']['emp_educational'];
        var empBookBankJSONList = responseBody['data']['emp_book_bank'];

        print(empConfidentialityJSONList);

        // แปลง JSON เป็น List<EmpContract> และเก็บลงใน RxList
        var mappedEmpContractList = empContractJSONList
            .map<EmpContract>(
                (empContractJSON) => EmpContract.fromJson(empContractJSON))
            .toList();
        empContractList
            .assignAll(RxList<EmpContract>.of(mappedEmpContractList));

        // แปลง JSON สำหรับ emp_confidentiality
        var mappedEmpConfidentialityList = empConfidentialityJSONList
            .map<EmpConfidentiality>((empConfidentialityJSON) =>
                EmpConfidentiality.fromJson(empConfidentialityJSON))
            .toList();
        empConfidentialityList.assignAll(
            RxList<EmpConfidentiality>.of(mappedEmpConfidentialityList));

        // แปลง JSON สำหรับ emp_competition
        var mappedEmpCompetitionList = empCompetitionJSONList
            .map<EmpCompetition>((empCompetitionJSON) =>
                EmpCompetition.fromJson(empCompetitionJSON))
            .toList();
        empCompetitionList
            .assignAll(RxList<EmpCompetition>.of(mappedEmpCompetitionList));

        // แปลง JSON สำหรับ emp_paid_training
        var mappedEmpPaidTrainingList = empPaidTrainingJSONList
            .map<EmpPaidTraining>((empPaidTrainingJSON) =>
                EmpPaidTraining.fromJson(empPaidTrainingJSON))
            .toList();
        empPaidTrainingList
            .assignAll(RxList<EmpPaidTraining>.of(mappedEmpPaidTrainingList));

        // แปลง JSON สำหรับ emp_asset_loan
        var mappedEmpAssetLoanList = empAssetLoanJSONList
            .map<EmpAssetLoan>(
                (empAssetLoanJSON) => EmpAssetLoan.fromJson(empAssetLoanJSON))
            .toList();
        empAssetLoanList
            .assignAll(RxList<EmpAssetLoan>.of(mappedEmpAssetLoanList));

        // แปลง JSON สำหรับ emp_saving_contract
        var mappedEmpSavingContractList = empSavingContractJSONList
            .map<EmpSavingContract>((empSavingContractJSON) =>
                EmpSavingContract.fromJson(empSavingContractJSON))
            .toList();
        empSavingContractList.assignAll(
            RxList<EmpSavingContract>.of(mappedEmpSavingContractList));

        // แปลง JSON สำหรับ emp_form
        var mappedEmpFormList = empFormJSONList
            .map<EmpForm>((empFormJSON) => EmpForm.fromJson(empFormJSON))
            .toList();
        empFormList.assignAll(RxList<EmpForm>.of(mappedEmpFormList));

        // แปลง JSON สำหรับ emp_id_card
        var mappedEmpIdCardList = empIdCardJSONList
            .map<EmpIdCard>(
                (empIdCardJSON) => EmpIdCard.fromJson(empIdCardJSON))
            .toList();
        empIdCardList.assignAll(RxList<EmpIdCard>.of(mappedEmpIdCardList));

        // แปลง JSON สำหรับ emp_house
        var mappedEmpHouseList = empHouseJSONList
            .map<EmpHouse>((empHouseJSON) => EmpHouse.fromJson(empHouseJSON))
            .toList();
        empHouseList.assignAll(RxList<EmpHouse>.of(mappedEmpHouseList));

        // แปลง JSON สำหรับ emp_educational
        var mappedEmpEducationalList = empEducationalJSONList
            .map<EmpEducational>((empEducationalJSON) =>
                EmpEducational.fromJson(empEducationalJSON))
            .toList();
        empEducationalList
            .assignAll(RxList<EmpEducational>.of(mappedEmpEducationalList));

        // แปลง JSON สำหรับ emp_book_bank
        var mappedEmpBookBankList = empBookBankJSONList
            .map<EmpBookBank>(
                (empBookBankJSON) => EmpBookBank.fromJson(empBookBankJSON))
            .toList();
        empBookBankList
            .assignAll(RxList<EmpBookBank>.of(mappedEmpBookBankList));
      } else {
        clearAllLists();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> fetchContract() async {
    var response = await connect.post(
      '$baseUrl/contract/obj/filter',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      {
        'emp_id': box.read('id'),
      },
    );

    print(response.body);

    listContract.value = response.body['data']['contractCategories'];
  }

// ================================================================

  void sendData() async {
    loadingController.dialogLoading();

    try {
      var requestStatus = await connect.get(
        '$baseUrl/get/config/requests',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (requestStatus.statusCode == 200) {
        final configData = requestStatus.body;
        final statusData = configData['statuses']['new'];

        var contractModule = '';
        switch (selectedContractText.value) {
          case '1':
            contractModule = 'emp.requests.add.file.employment.contract';
            break;
          case '2':
            contractModule = 'emp.requests.add.file.employment.confidentiality';
            break;
          case '3':
            contractModule = 'emp.requests.add.file.employment.competition';
            break;
          case '4':
            contractModule = 'emp.requests.add.file.employment.paid.training';
            break;
          case '5':
            contractModule = 'emp.requests.add.file.employment.asset.loan';
            break;
          case '6':
            contractModule = 'emp.requests.add.file.employment.saving.contract';
            break;
          case '7':
            contractModule = 'emp.requests.add.file.employment.form';
            break;
          case '8':
            contractModule = 'emp.requests.add.file.id.card';
            break;
          case '9':
            contractModule = 'emp.requests.add.file.house';
            break;
          case '10':
            contractModule = 'emp.requests.add.file.educational';
            break;
          case '11':
            contractModule = 'emp.requests.add.file.book.bank';
            break;
          default:
        }

        statusData['emp_id'] = box.read('id');
        statusData['user_id'] = box.read('id');
        statusData['module_name'] = 'c_transaction_requests.id';

        FormData formData = FormData({
          'emp_id': box.read('id'),
          'companys_id': box.read('companyId'),
          'page_number': 'emp.requests.dc.employment.contracts',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_name': contractModule,
            'subject': 'เอกสารและสัญญา',
            'detail': selectedContractDetail.value,
            'note1': 'แจ้งขอเปลี่ยนแปลงข้อมูลเอกสารและสัญญา',
          }),
          'status_data': jsonEncode(statusData),
        });

        if (selectedFiles.isNotEmpty) {
          for (int index = 0; index < selectedFiles.length; index++) {
            var fileData = selectedFiles[index];

            if (fileData['type'] == 'image') {
              XFile file = fileData['file'];
              formData.files.add(
                MapEntry(
                  'files[]',
                  MultipartFile(
                    await file.readAsBytes(),
                    filename: file.name,
                    contentType: MediaType('image', 'jpeg').toString(),
                  ),
                ),
              );
            } else if (fileData['type'] == 'pdf') {
              PlatformFile file = fileData['file'];
              formData.files.add(
                MapEntry(
                  'files[]',
                  MultipartFile(
                    file.bytes!,
                    filename: file.name,
                    contentType: MediaType('application', 'pdf').toString(),
                  ),
                ),
              );
            }

            formData.fields.add(MapEntry('actions_name[$index]',
                'แจ้งขอเปลี่ยนแปลงข้อมูลเอกสารและสัญญา'));
            formData.fields
                .add(MapEntry('detail[$index]', selectedContractDetail.value));
          }
        }

        var response = await connect.post(
          '$baseUrl/requests/send',
          headers: {
            'Authorization': 'Bearer $token',
          },
          formData,
        );
        Get.back();

        if (response.statusCode == 200) {
          final responseData = response.body;
          print(responseData);
          clear();

          if (responseData['statusCode'] == '200') {
            print('success');
            loadData();
            Get.offAndToNamed('/status-success');
          } else {
            print('failed');
            Get.offAndToNamed('/status-cancel');
          }
        } else {
          Get.back();
          final responseData = response.body;
          print("ไม่สามารถส่งข้อมูลได้");
          alertEmptyData('แจ้งเตือน',
              responseData['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
        }
      } else {
        Get.back();
        print("ไม่สามารถดึงข้อมูล status ได้");
        alertEmptyData(
            'แจ้งเตือน', 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งในภายหลีัง');
      }
    } catch (e, s) {
      clear();
      Get.offAndToNamed('/status-cancel');
      print('Error: $e');
      print('Error: $s');
    }
  }

  void clear() {
    selectedContractText = RxString('เลือกประเภทสัญญา');
    selectedContractDetail = RxString('');
    selectedFiles = <Map<String, dynamic>>[].obs;
  }

  void clearAllLists() {
    empContractList.clear();
    empConfidentialityList.clear();
    empCompetitionList.clear();
    empPaidTrainingList.clear();
    empAssetLoanList.clear();
    empSavingContractList.clear();
    empFormList.clear();
    empIdCardList.clear();
    empHouseList.clear();
    empEducationalList.clear();
    empBookBankList.clear();
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
