import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/salary/salary_page.dart';
import 'package:organics_salary/theme.dart';

class StepTwo extends StatefulWidget {
  final TextEditingController controller;
  final ExampleNotifier notifier;

  const StepTwo({
    super.key,
    required this.controller,
    required this.notifier,
  });

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'เลือกวันรับเอกสาร',
              style: TextStyle(
                  color: AppTheme.ognGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Center(
              child: TextFormField(
                controller: dateInput,
                style:
                    const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                decoration: InputDecoration(
                  suffixIconConstraints: const BoxConstraints(minWidth: 65),
                  suffixIcon: const Icon(
                    Icons.calendar_month_rounded,
                    size: 20,
                    color: AppTheme.ognOrangeGold,
                  ),
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                  labelText: 'เลือกวันรับเอกสาร',
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
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      dateInput.text = formattedDate;
                      salaryController.selectedUsedDate(formattedDate);
                    });
                  } else {}
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ระบุวันรับเอกสาร';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
