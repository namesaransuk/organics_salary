import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/models/leave_quota_model/datum.dart';
import 'dart:convert';

import 'package:organics_salary/theme.dart';

class LeaveHistoryController extends GetxController {
  final LoadingController loadingController = Get.put(LoadingController());
  final box = GetStorage();
  var baseUrl = dotenv.env['API_URL'];
  var token = dotenv.env['TOKEN'];
  var connect = Get.put(GetConnect());
  final id = GetStorage().read('id');

  RxString c_startDate = RxString('');
  RxString c_endDate = RxString('');

  RxString searchStartDate = RxString('');
  RxString searchEndDate = RxString('');

  RxInt selectedTypeLeaveId = RxInt(0);
  RxString selectedTypeTwoSetup = RxString('');
  var leaveQuotaList = RxList<Datum>([]);
  RxList listLeaveType = RxList<dynamic>([]);
  RxList listEmpDept = RxList<dynamic>([]);
  RxList listAdmin = RxList<dynamic>([]);
  var leaveHistoryList = RxList([]);
  var leaveHistorySectionList = RxList([]);
  RxList leaveQuota = RxList<dynamic>();
  late RxList filteredLeaveHistoryList;
  RxInt selectedLeaveId = RxInt(0);
  RxString selectedLeave = 'เลือกประเภทการลา'.obs;
  RxString selectedLeaveName = RxString('');
  RxInt selectedSubType = RxInt(0);
  var setupSubType = RxList<dynamic>([]);
  RxString selectedLocation = RxString('');
  RxString selectedReasonLeave = RxString('');
  RxString selectedDetailLeave = RxString('');
  RxString selectedSubDetailLeave = RxString('');
  RxString selectedAssigner = RxString('เลือกผู้ปฏิบัติงานแทน');
  RxList<XFile> selectedImages = <XFile>[].obs;
  RxList<XFile> selectedSubImages = <XFile>[].obs;

  RxString startDate = RxString('');
  RxString startTime = RxString('');
  RxString endDate = RxString('');
  RxString endTime = RxString('');
  RxString leaveStart = RxString('');
  RxString leaveEnd = RxString('');
  RxString diffTime = RxString('');

  RxList flowLeaveList = RxList<dynamic>([]);
  RxList workTimeList = RxList<dynamic>([]);
  RxList holidaysList = RxList<dynamic>([]);
  RxList cHierarchysList = RxList<dynamic>([]);
  RxList leaveTotalUsedList = RxList<dynamic>([]);
  RxList checkLeaveList = RxList<dynamic>([]);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nextPageTwo = false.obs;

  Future<bool> checkTimeLeave() async {
    loadingController.dialogLoading();

    try {
      var response = await connect.post(
        '$baseUrl/check/time/leave',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'start': leaveStart.value,
          'end': leaveEnd.value,
          'type': 1,
        },
      );

      Get.back();

      var responseBody = response.body;
      print(responseBody);

      if (responseBody is List && responseBody.isEmpty) {
        return true; // ไม่มีรายการลา
      } else if (responseBody is List) {
        checkLeaveList.assignAll(responseBody);
        return false; // มีรายการลาแล้ว
      } else {
        // fallback กรณี response ไม่ใช่ List
        print('Unexpected response format: $responseBody');
        return true;
      }
    } catch (e) {
      print('Error in checkTimeLeave: $e');
      return true; // กรณี error ให้ถือว่าไม่มีรายการซ้ำ
    }
  }

  Future<void> loadLeaveTotalUsed() async {
    try {
      var response = await connect.post(
        '$baseUrl/leave/emp/limit',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
        },
      );

      var responseBody = response.body;

      leaveTotalUsedList
          .assignAll(responseBody['data']['leaveSummary'] as List<dynamic>);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadFlowLeave() async {
    try {
      var response = await connect.post(
        '$baseUrl/select/flow/of/leave',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'whereData': {
            "approve_type": 1,
            "approve_type_name": "อนุมัติใบลา",
            "step_approve_number": 1
          },
        },
      );

      var responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        flowLeaveList.assignAll(
            (responseBody['data']['approveFlowList'] as List).cast<dynamic>());
        workTimeList.assignAll([responseBody['data']['worktime']]);
        holidaysList.assignAll(
            (responseBody['data']['holidaysData'] as List).cast<dynamic>());

        final raw = responseBody['data']?['cHierarchys'];
        cHierarchysList.assignAll(
          raw is List
              ? raw
              : raw is Map
                  ? [raw]
                  : [],
        );
        print(cHierarchysList);
      } else {
        print('test failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      // Get.back();
      // alertEmptyData(
      //     'แจ้งเตือน', 'เกิดข้อผิดพลาดของระบบ กรุณาลองใหม่อีกครั้งในภายหลัง');
      print(e);
    }
  }

  Future<void> loadEmpDept() async {
    try {
      var response = await connect.post(
        '$baseUrl/employee/getByDept',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'empId': box.read('id'),
          'deptId': box.read('departmentId'),
        },
      );

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == 200) {
        listEmpDept.assignAll(responseBody['data'] as List<dynamic>);
        // print(listEmpDept);
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดของระบบ กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> loadQuota() async {
    leaveQuotaList.clear();

    try {
      var response = await connect.post(
        '$baseUrl/leave/emp/limit',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'empId': box.read('id'),
        },
      );

      Map<String, dynamic> responseBody = response.body;

      if (responseBody['statusCode'] == '200') {
        if (responseBody['data'] is List) {
          var leaveQuotaJSONList = responseBody['data'] as List;

          var mappedleaveQuotaList = leaveQuotaJSONList
              .map<Datum>(
                (leaveQuotaListJSON) => Datum.fromJson(leaveQuotaListJSON
                    as Map<String, dynamic>), // ✅ แปลงเป็น Map ก่อนใช้
              )
              .toList();

          leaveQuotaList.assignAll(mappedleaveQuotaList);
        } else {
          print('Data format is incorrect: ${responseBody['data']}');
        }
      } else {
        print('failed with status code: ${responseBody['statusCode']}');
      }
    } catch (e) {
      print(e);
      // alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดของระบบ กรุณาลองใหม่อีกครั้งในภายหลัง');
    }
  }

  Future<void> fetchLeaveType() async {
    try {
      var response = await connect.post(
        '$baseUrl/leave/type/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        null,
      );

      if (response.statusCode == 200) {
        listLeaveType.value = response.body['data'];
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        listLeaveType.clear();
      }
    } catch (e) {
      // จัดการข้อผิดพลาดเมื่อเกิดปัญหา
      print('Error occurred while fetching leave types: $e');
      listLeaveType.clear();
    }
  }

  Future<void> fetchAdmin() async {
    try {
      var response = await connect.post(
        '$baseUrl/administrative/category/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        null,
      );

      if (response.statusCode == 200) {
        listAdmin.value = response.body['data'];
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        listAdmin.clear();
      }
    } catch (e) {
      // จัดการข้อผิดพลาดเมื่อเกิดปัญหา
      print('Error occurred while fetching leave types: $e');
      listAdmin.clear();
    }
  }

  Future<void> loadData() async {
    loadingController.dialogLoading();

    try {
      List<Map<String, dynamic>> whereItem;

      if (searchStartDate.value.isNotEmpty && searchEndDate.value.isNotEmpty) {
        if (searchStartDate.value == searchEndDate.value) {
          final cutTimeStartDate = searchStartDate.value.split(' ')[0];
          DateTime dateTime = DateTime.parse(cutTimeStartDate);
          DateTime lastDay = DateTime(
              dateTime.year, dateTime.month + 1, 0); // วันสุดท้ายของเดือน
          final formattedEndDate =
              DateFormat('yyyy-MM-dd').format(lastDay).toString();
          print(formattedEndDate);

          whereItem = [
            {
              'field': 'created_at',
              'operator': '>=',
              'value': '${searchStartDate.value} 00:00:00'
            },
            {
              'field': 'created_at',
              'operator': '<=',
              'value': '$formattedEndDate 23:59:59'
            },
            {'field': 'emp_id', 'operator': '=', 'value': box.read('id')},
          ];
        } else {
          whereItem = [
            {
              'field': 'created_at',
              'operator': '>=',
              'value': searchStartDate.value // ใช้ '>='
            },
            {
              'field': 'created_at',
              'operator': '<=',
              'value': searchEndDate.value // ใช้ '<='
            },
            {
              'field': 'emp_id',
              'operator': '=',
              'value': box.read('id') // ใช้ '='
            },
          ];
        }
      } else {
        whereItem = [
          {
            'field': 'emp_id',
            'operator': '=',
            'value': box.read('id') // ใช้ '='
          },
        ];
      }

      var response = await connect.post(
        '$baseUrl/requests/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          'requests_types': 'leave',
          'filter': jsonEncode(whereItem),
        },
      );
      Get.back();

      var responseBody = response.body;
      // print(responseBody);

      if (responseBody['statusCode'] == '200') {
        leaveHistoryList.assignAll(responseBody['data'] as List<dynamic>);
      } else {
        leaveHistoryList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
      // }
    } catch (e) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

  void printLongJson(String text, {int chunkSize = 800}) {
    for (var i = 0; i < text.length; i += chunkSize) {
      print(text.substring(
          i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }
  Future<void> loadDataSection() async {
    loadingController.dialogLoading();

    try {
      List<Map<String, dynamic>> whereItem;

      whereItem = [
        {
          'field': 'emp_id',
          'operator': '=',
          'value': box.read('id') // ใช้ '='
        },
      ];

      var response = await connect.post(
        '$baseUrl/requests/list',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        {
          'emp_id': box.read('id'),
          // 'treId': 1276,
          'requests_types': 'leave',
          'filter': jsonEncode(whereItem),
        },
      );
      Get.back();
  // Future<void> loadDataSection({dynamic treId}) async {
  //   loadingController.dialogLoading();

  //   int? treIdInt;
  //   if (treId is int) {
  //     treIdInt = treId;
  //   } else if (treId is String) {
  //     treIdInt = int.tryParse(treId);
  //   }

  //   final body = {
  //     "emp_id": box.read('id'),
  //     "company_id": box.read('companyId'),
  //     "department_id": box.read('departmentId'),
  //     "position_id": null,
  //     "treId": treIdInt, // ← ส่ง treId ให้ API
  //   };

  //   try {
  //     final response = await connect.post(
  //       '$baseUrl/select/flow/of/leave/list',
  //       body, // ← body เป็นอาร์กิวเมนต์ตัวที่ 2
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     Get.back();

      var responseBody = response.body;
      // printLongJson(jsonEncode('this is responseBoby section :$responseBody'));
      // print(responseBody);

      if (responseBody['statusCode'] == '200') {
        leaveHistorySectionList
            .assignAll(responseBody['data'] as List<dynamic>);
      } else {
        leaveHistoryList.clear();
        print('failed with status code: ${responseBody['statusCode']}');
        alertEmptyData('แจ้งเตือน',
            responseBody['desc'] ?? 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
      }
      // }
    } catch (e) {
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.back();
      // });
      print(e);
      alertEmptyData('แจ้งเตือน', 'เกิดข้อผิดพลาดโปรดลองใหม่อีกครั้งในภายหลัง');
    }
  }

// ================================================================

  bool isStepOneCompleted() {
    return formKey.currentState?.validate() == true;
  }

  bool isStepTwoCompleted() {
    switch (selectedTypeLeaveId.value) {
      case 1:
        if (startDate.value.isNotEmpty && endDate.value.isNotEmpty) {
          leaveStart.value =
              '$startDate ${workTimeList.first['flexible_hours_log_line']['am_worktime_start']}';
          leaveEnd.value =
              '$endDate ${workTimeList.first['flexible_hours_log_line']['pm_worktime_end']}';
          calculateTimeDifference(1);
          return true;
        }
        break;
      case 2:
        if (startDate.value.isNotEmpty &&
            selectedTypeTwoSetup.value.isNotEmpty) {
          if (selectedTypeTwoSetup.value == '1') {
            leaveStart.value =
                '$startDate ${workTimeList.first['flexible_hours_log_line']['am_worktime_start']}';
            leaveEnd.value =
                '$startDate ${workTimeList.first['flexible_hours_log_line']['am_worktime_end']}';
          } else if (selectedTypeTwoSetup.value == '2') {
            leaveStart.value =
                '$startDate ${workTimeList.first['flexible_hours_log_line']['pm_worktime_start']}';
            leaveEnd.value =
                '$startDate ${workTimeList.first['flexible_hours_log_line']['pm_worktime_end']}';
          }
          calculateTimeDifference(2);
          return true;
        }
        break;
      case 3:
        if (startDate.value.isNotEmpty &&
            startTime.value.isNotEmpty &&
            endTime.value.isNotEmpty) {
          leaveStart.value = '$startDate $startTime:00';
          leaveEnd.value = '$startDate $endTime:00';
          calculateTimeDifference(3);
          return true;
        }
        break;
    }
    return false;
  }

  void calculateTimeDifference(int mode) {
    DateTime start = DateTime.parse(leaveStart.value);
    DateTime end = DateTime.parse(leaveEnd.value);
    int totalWorkDays = 0;
    var workTime = workTimeList.first;

    List<DateTime> holidayDates = holidaysList.expand((holiday) {
      DateTime start = DateTime.parse(holiday['holiday_start']);
      DateTime end = DateTime.parse(holiday['holiday_end']);
      return List.generate(
        end.difference(start).inDays + 1,
        (index) => DateTime(start.year, start.month, start.day + index),
      );
    }).toList();

    // Mapping วันที่เป็น key เพื่อลด switch case
    Map<int, String> workTimeKeys = {
      DateTime.sunday: 'worktimes_sunday',
      DateTime.monday: 'worktimes_monday',
      DateTime.tuesday: 'worktimes_tuesday',
      DateTime.wednesday: 'worktimes_wednesday',
      DateTime.thursday: 'worktimes_thursday',
      DateTime.friday: 'worktimes_friday',
      DateTime.saturday: 'worktimes_saturday',
    };

    for (DateTime date = start;
        date.isBefore(end) || date.isAtSameMomentAs(end);
        date = date.add(Duration(days: 1))) {
      bool isHoliday =
          holidayDates.contains(DateTime(date.year, date.month, date.day));
      bool isWorkDay = workTime[workTimeKeys[date.weekday]] == 1;

      if (mode == 1 && isWorkDay && !isHoliday) {
        totalWorkDays++;
      }
    }

    Duration remainingTime = end.difference(start);
    if (start.hour == 8 &&
        start.minute == 0 &&
        end.hour == 18 &&
        end.minute == 0) {
      remainingTime = Duration.zero;
    }

    String hours = remainingTime.inHours.toString();
    String minutes = (remainingTime.inMinutes % 60).toString();
    diffTime.value = '$totalWorkDays วัน $hours ชม. $minutes นาที';

    print(diffTime.value);
  }

  void updateInputCause(String value) {
    selectedReasonLeave.value = value;
    // print(inputCause);
  }

  void sendData() async {
    loadingController.dialogLoading();

    try {
      final responseStatus =
          await connect.post('$baseUrl/select/flow/of/leave', headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, {
        "emp_id": box.read('id'),
        "where_data": {
          "approve_type_id": 1,
          "approve_type_name": "อนุมัติใบลา",
          "step_approve_number": 1
        }
      });

      if (responseStatus.statusCode == 200) {
        final configData = responseStatus.body;
        final statusData = configData['data']['approveFlowList'];

        final selectedStatus = statusData.firstWhere(
          (item) => item['flow_step'] == 1,
          orElse: () => null,
        );

        print(leaveStart);
        print(leaveEnd);

        final formData = FormData({
          'emp_id': box.read('id').toString(),
          'companys_id': box.read('companyId').toString(),
          'route': 'leave-section-approve',
          'page_number': 'employee.new.requests.transaction.leave',
          'create_data': jsonEncode({
            'emp_id': box.read('id'),
            'company_id': box.read('companyId'),
            'module_name': 'employee.new.requests.transaction.leave',
            'subject': 'การลาหยุด',
            'note1': 'คำขอการลาหยุด',
          }),
          'hr_leaves': jsonEncode({
            'emp_id': box.read('id'),
            'hr_worktimes_id': workTimeList.first['flexible_hours_log_line']
                ['worktimes_id'],
            'am_worktime_start': workTimeList.first['flexible_hours_log_line']
                ['am_worktime_start'],
            'am_worktime_end': workTimeList.first['flexible_hours_log_line']
                ['am_worktime_end'],
            'pm_worktime_start': workTimeList.first['flexible_hours_log_line']
                ['pm_worktime_start'],
            'pm_worktime_end': workTimeList.first['flexible_hours_log_line']
                ['pm_worktime_end'],
            'start_date': leaveStart.value,
            'end_date': leaveEnd.value,
            'reason_leave': selectedReasonLeave.value,
            'approve_type_id': selectedStatus['approve_type_id']
          }),
          'leave_details': jsonEncode({
            'leave_types_id': selectedLeaveId.value,
            'sub_leave_types_id':
                selectedSubType.value != 0 ? selectedSubType.value : null,
            'detail': selectedDetailLeave.value,
            'subDetail': selectedSubDetailLeave.value,
            'assigner_id': selectedAssigner.value,
          }),
          'status_data': jsonEncode({
            'status_name': selectedStatus['step_approve_name'],
            'status_number': selectedStatus['step_approve_number'],
            // 'status_name': 'ขออนุมัติ',
            // 'status_number': 1,
            'emp_id': box.read('id'),
            'user_id': box.read('id'),
            'module_name': 'c_transaction_requests.id'
          }),
        });

        if (selectedImages.isNotEmpty) {
          for (int index = 0; index < selectedImages.length; index++) {
            var file = selectedImages[index];

            formData.files.add(
              MapEntry(
                'files[]',
                MultipartFile(
                  await file.readAsBytes(),
                  filename: file.name,
                  contentType: 'image/jpeg',
                ),
              ),
            );

            formData.fields.add(MapEntry('actions_name[$index]', 'การลางาน'));
            formData.fields.add(
                MapEntry('detail[$index]', 'ไฟล์แนบเพิ่มเติมการลางาน(หลัก)'));
            formData.fields.add(MapEntry('note1[$index]', 'leave_file'));
          }
        }

        int baseIndex = selectedImages.length;

        if (selectedSubImages.isNotEmpty) {
          for (int index = 0; index < selectedSubImages.length; index++) {
            var file = selectedSubImages[index];
            int newIndex = baseIndex + index;

            formData.files.add(
              MapEntry(
                'files[]',
                MultipartFile(
                  await file.readAsBytes(),
                  filename: file.name,
                  contentType: 'image/jpeg',
                ),
              ),
            );

            formData.fields
                .add(MapEntry('actions_name[$newIndex]', 'การลางาน'));
            formData.fields.add(MapEntry(
                'detail[$newIndex]', 'ไฟล์แนบเพิ่มเติมการลางาน(ย่อย)'));
            formData.fields.add(MapEntry('note1[$newIndex]', 'sub_leave_file'));
          }
        }

        final response = await connect.post(
          '$baseUrl/requests/send',
          headers: {
            'Authorization': 'Bearer $token',
          },
          formData,
        );
        print(response);
        Get.back();

        if (response.statusCode == 200) {
          final responseData = response.body;
          print(responseData);
          clear();

          if (responseData['statusCode'] == '200') {
            print('success');
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
            'แจ้งเตือน', 'เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้งในภายหลัง');
      }
    } catch (e) {
      clear();
      Get.offAndToNamed('/status-cancel');
      print('Error: $e');
    }
  }

  void clear() {
    // leaveHistoryList.clear();
    // monthName = 'เดือน'.obs;
    // yearName = 'ปี'.obs;
    // ddMonthName = 'เดือน'.obs;
    // ddYearName = 'ปี'.obs;
    selectedLeaveId = RxInt(0);
    selectedLeave = 'เลือกประเภทการลา'.obs;
    selectedLeaveName = RxString('');
    selectedSubType = RxInt(0);
    selectedImages.clear();
    selectedReasonLeave = RxString('');
    startDate = RxString('');
    startTime = RxString('');
    endDate = RxString('');
    endTime = RxString('');
    leaveQuotaList = RxList<Datum>([]);
    leaveQuota = RxList<Datum>([]);
    setupSubType = RxList<dynamic>([]);
    selectedSubImages.clear();
    selectedAssigner = RxString('');
    selectedDetailLeave = RxString('');
    selectedSubDetailLeave = RxString('');
    selectedAssigner = RxString('เลือกผู้ปฏิบัติงานแทน');
    selectedTypeLeaveId = RxInt(0);

    update();
  }

  void clearHistory() {
    leaveHistoryList.clear();

    // monthName = 'เดือน'.obs;
    // yearName = 'ปี'.obs;
    // ddMonthName = 'เดือน'.obs;
    // ddYearName = 'ปี'.obs;

    update();
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
