import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/salary/salary_page.dart';
import 'package:organics_salary/theme.dart';

class StepThree extends StatefulWidget {
  final TextEditingController controller;
  final ExampleNotifier notifier;

  const StepThree({
    super.key,
    required this.controller,
    required this.notifier,
  });

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  String? formattedDate;
  List<String> monthNames = [];
  String? resultMonthNames;

  // @override
  // void dispose() {
  //   salaryController.selectedMonths.clear();
  //   salaryController.inputCause = RxString('');
  //   salaryController.usedDate = RxString('');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    String? formattedDate;

    List<String> thaiDates = salaryController.selectedMonths.map((monthYear) {
      List<String> parts = monthYear.split('-');
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);

      String thaiMonth = DateFormat.MMM('th_TH').format(DateTime(year, month));

      return '$thaiMonth $year';
    }).toList();

    resultMonthNames = thaiDates.join(', ');

    if (salaryController.usedDate.value.isNotEmpty) {
      DateTime dateTime = DateTime.parse(salaryController.usedDate.value);
      formattedDate = DateFormat('dd MMMM yyyy', 'th').format(dateTime);
    } else {
      formattedDate = 'ไม่มีข้อมูล';
    }

    return Container(
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
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: AppTheme.ognOrangeGold,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                  child: Text(
                'เดือนที่ขอสลิป',
                style: TextStyle(color: AppTheme.ognMdGreen),
              )),
              Expanded(
                child: Text(
                  '$resultMonthNames',
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppTheme.ognMdGreen),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(
                Icons.warning_rounded,
                color: AppTheme.ognOrangeGold,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text(
                  'สาเหตุที่นำไปใช้',
                  style: TextStyle(color: AppTheme.ognMdGreen),
                ),
              ),
              Expanded(
                child: Text(
                  salaryController.inputCause.value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppTheme.ognMdGreen),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: AppTheme.ognOrangeGold,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text(
                  'วันที่จะนำไปใช้',
                  style: TextStyle(color: AppTheme.ognMdGreen),
                ),
              ),
              Expanded(
                child: Text(
                  formattedDate,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppTheme.ognMdGreen),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
