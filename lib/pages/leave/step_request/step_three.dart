import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/leave/leave_page.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class StepThree extends StatefulWidget {
  final TextEditingController controller;
  final ExampleNotifier notifier;

  const StepThree({
    super.key,
    required this.controller,
    required this.notifier,
  });

  @override
  _StepThreeState createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> with TickerProviderStateMixin {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String day = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String year = now.year.toString();

    final selectedItem = leaveHistoryController.listEmpDept.firstWhere(
      (item) =>
          item['id'] ==
          int.parse(leaveHistoryController.selectedAssigner.value ==
                  'เลือกผู้ปฏิบัติงานแทน'
              ? '0'
              : leaveHistoryController.selectedAssigner.value),
      orElse: () => null,
    );

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ตรวจสอบข้อมูล',
                style: TextStyle(
                  color: AppTheme.ognGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            rowDetail(FontAwesomeIcons.briefcaseMedical, 'วันที่แจ้งลา',
                '$day/$month/$year'),
            rowDetail(FontAwesomeIcons.solidUser, 'ผู้แจ้งลา',
                '${box.read('fnames')} ${box.read('lnames')}'),
            Column(
              children: [
                if (leaveHistoryController.selectedTypeLeaveId.value == 1) ...[
                  rowDetail(
                      FontAwesomeIcons.solidCalendarDays,
                      'วันที่เริ่มต้น',
                      formatDate(leaveHistoryController.startDate.value)),
                  rowDetail(FontAwesomeIcons.solidCalendarDays, 'วันที่สิ้นสุด',
                      formatDate(leaveHistoryController.endDate.value)),
                ] else if (leaveHistoryController.selectedTypeLeaveId.value ==
                    2) ...[
                  rowDetail(FontAwesomeIcons.solidCalendarDays, 'วันที่ลา',
                      formatDate(leaveHistoryController.startDate.value)),
                  rowDetail(
                      FontAwesomeIcons.businessTime,
                      'ช่วงเวลา',
                      leaveHistoryController.selectedTypeTwoSetup.value == '1'
                          ? 'ช่วงเช้า (08.00 - 13.00 น.)'
                          : 'ช่วงบ่าย (13.00 - 18.00 น.)'),
                ] else if (leaveHistoryController.selectedTypeLeaveId.value ==
                    3) ...[
                  rowDetail(FontAwesomeIcons.solidCalendarDays, 'วันที่ลา',
                      formatDate(leaveHistoryController.startDate.value)),
                  rowDetail(FontAwesomeIcons.businessTime, 'ช่วงเวลา',
                      '${leaveHistoryController.startTime} - ${leaveHistoryController.endTime} น.'),
                ],
              ],
            ),
            rowDetail(FontAwesomeIcons.solidClock, 'รวมวันเวลา',
                '${leaveHistoryController.diffTime}'),
            rowDetail(Icons.work, 'ประเภทการลา',
                '${leaveHistoryController.selectedLeaveName}'),
            leaveHistoryController.setupSubType.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${leaveHistoryController.setupSubType.first['holiday_name_type']} :',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${leaveHistoryController.selectedSubDetailLeave}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      leaveHistoryController.selectedSubImages.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ไฟล์แนบเพิ่มเติม :',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.file(
                                    File(leaveHistoryController
                                        .selectedSubImages[0].path),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                : Container(),
            rowDetail(FontAwesomeIcons.solidCircleQuestion, 'สาเหตุการลา',
                '${leaveHistoryController.selectedReasonLeave}'),
            leaveHistoryController.selectedDetailLeave.value != ''
                ? rowDetail(
                    FontAwesomeIcons.solidRectangleList,
                    'รายละเอียดเพิ่มเติม',
                    '${leaveHistoryController.selectedDetailLeave}')
                : Container(),
            rowDetail(
              FontAwesomeIcons.solidUser,
              'ผู้ปฏิบัติงานแทน',
              selectedItem?['fnames']?['multitexts'] != null
                  ? '${selectedItem?['fnames']?['multitexts']?[0]?['name']} ${selectedItem?['lnames']?['multitexts']?[0]?['name']}'
                  : '-',
            ),
            leaveHistoryController.selectedImages.isNotEmpty
                ? Column(
                    children: [
                      rowDetail(FontAwesomeIcons.solidFileImage,
                          'ไฟล์แนบเพิ่มเติม', ''),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.file(
                          File(leaveHistoryController.selectedImages[0].path),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget rowDetail(IconData icon, String title, String detail) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title :',
                style:
                    const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                detail,
                textAlign: TextAlign.right,
                style:
                    const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  String formatDate(String? inputDate) {
    if (inputDate == null || inputDate.isEmpty) {
      inputDate = "2025-01-01"; // ค่าเริ่มต้น
    }
    DateTime date = DateTime.parse(inputDate);

    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    return '$day/$month/$year';
  }
}
