import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/salary/salary_page.dart';
import 'package:organics_salary/theme.dart';

class StepOne extends StatefulWidget {
  final TextEditingController controller;
  final ExampleNotifier notifier;

  const StepOne({
    super.key,
    required this.controller,
    required this.notifier,
  });

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final TextEditingController _reasonController =
      TextEditingController(text: '${salaryController.inputCause}');
  final List<String> _selectedMonths = [];

  @override
  void initState() {
    super.initState();
    // monthCheckboxes = [];
  }

  @override
  void dispose() {
    // leaveHistoryController.dispose();
    // _selectedMonths.clear();asd
    // salaryController.selectedMonths.clear();
    super.dispose();
  }

  List<DateTime> getLast12Months() {
    List<DateTime> dates = [];
    final today = DateTime.now();
    for (int x = 0; x < 12; x++) {
      dates.add(DateTime(today.year, today.month - x, 1));
    }
    return dates.reversed.toList();
  }

  List<List<DateTime>> groupByYear(List<DateTime> dates) {
    Map<int, List<DateTime>> yearMap = {};
    for (var date in dates) {
      int year = date.year;
      if (!yearMap.containsKey(year)) {
        yearMap[year] = [];
      }
      yearMap[year]!.add(date);
    }

    List<List<DateTime>> result = [];
    yearMap.forEach((year, months) {
      result.add(months);
    });

    return result;
  }

  List<Widget> buildYearMonthCheckboxes(List<List<DateTime>> groupedByYear) {
    List<Widget> checkboxes = [];
    for (var yearGroup in groupedByYear) {
      int year = yearGroup[0].year;

      List<Widget> monthCheckboxes = [];
      for (var month in yearGroup) {
        String monthNumber = month.month.toString().padLeft(2, '0');
        monthCheckboxes.add(
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min, // Set fixed width
              children: [
                Checkbox(
                  side: BorderSide(width: 1, color: Colors.grey.shade500),
                  activeColor: AppTheme.ognSmGreen,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3.0))),
                  value: salaryController.selectedMonths
                      .contains('$year-$monthNumber'),
                  onChanged: (newValue) {
                    setState(() {
                      final yearMonth = '$year-$monthNumber';
                      if (newValue!) {
                        salaryController.selectedMonths.add(yearMonth);
                        salaryController.selectedMonths.sort();
                      } else {
                        salaryController.selectedMonths.remove(yearMonth);
                      }
                      print(salaryController.selectedMonths);
                    });
                  },
                ), // Add spacing between checkbox and text
                Text(
                  DateFormat.MMM().format(month),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedMonths
                            .contains('$year-${DateFormat.M().format(month)}')
                        ? AppTheme.ognSmGreen
                        : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        );
      }

      if (monthCheckboxes.length < 12) {
        for (int i = monthCheckboxes.length; i < 12; i++) {
          monthCheckboxes.add(Expanded(child: Container()));
        }
      }

      // Add year title
      checkboxes.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$year',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.ognOrangeGold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );

      for (int i = 0; i < monthCheckboxes.length; i += 4) {
        List<Widget> rowChildren = monthCheckboxes.sublist(
          i,
          i + 4 < monthCheckboxes.length ? i + 4 : monthCheckboxes.length,
        );

        checkboxes.add(
          Row(
            children: rowChildren,
          ),
        );
      }
    }

    return checkboxes;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> last12Months = getLast12Months();
    List<List<DateTime>> groupedByYear = groupByYear(last12Months);

    List<Widget> checkboxes = buildYearMonthCheckboxes(groupedByYear);

    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'เลือกเดือนที่ต้องการ',
              style: TextStyle(
                  color: AppTheme.ognGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
        FormField(
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: checkboxes),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    state.errorText ?? '',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12),
                  ),
                ),
              ],
            );
          },
          validator: (value) {
            if (salaryController.selectedMonths.isEmpty) {
              return 'เลือกเดือน';
            }
            return null;
          },
        ),
        // Column(children: checkboxes),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ระบุสาเหตุที่ต้องการนำไปใช้',
                  style: TextStyle(
                      color: AppTheme.ognGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  salaryController.updateInputCause(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรอกรายละเอียด';
                  }
                  return null;
                },
                controller: _reasonController,
                textAlign: TextAlign.start,
                minLines: 3,
                maxLines: null,
                style:
                    const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                  labelText: 'กรอกรายละเอียด',
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
