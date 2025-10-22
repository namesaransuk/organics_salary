import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/leave/leave_page.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class StepTwo extends StatefulWidget {
  final TextEditingController controller;
  final ExampleNotifier notifier;

  const StepTwo({
    super.key,
    required this.controller,
    required this.notifier,
  });

  @override
  _StepTwoState createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> with TickerProviderStateMixin {
  TextEditingController dateInput = TextEditingController();

  DateTime? partDateStart;
  DateTime? partDateEnd;
  TimeOfDay? partTimeStart;
  TimeOfDay? partTimeEnd;

  TextEditingController startDate =
      TextEditingController(text: '${leaveHistoryController.startDate}');
  TextEditingController endDate =
      TextEditingController(text: '${leaveHistoryController.endDate}');
  TextEditingController startTime =
      TextEditingController(text: '${leaveHistoryController.startTime}');
  TextEditingController endTime =
      TextEditingController(text: '${leaveHistoryController.endTime}');

  Future<void> _selectDate(BuildContext context, int mode) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      // final String formattedDate =
      //     DateFormat('dd MMMM yyyy', 'th').format(picked.toLocal());
      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(picked.toLocal());

      if (mode == 2 && startDate.text.isNotEmpty) {
        final DateTime start = DateTime.parse(startDate.text);

        // เช็คว่า endDate ต้องไม่ก่อน startDate
        if (picked.isBefore(start)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('วันที่สิ้นสุดต้องมากกว่าหรือเท่ากับวันที่เริ่มต้น')),
          );
          return;
        }
      }

      setState(() {
        if (mode == 1) {
          startDate.text = formattedDate;
          leaveHistoryController.startDate.value = formattedDate;
          partDateStart = selectedDate;
        } else {
          endDate.text = formattedDate;
          leaveHistoryController.endDate.value = formattedDate;
          partDateEnd = selectedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int mode) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            textTheme: GoogleFonts.kanitTextTheme(),
            colorScheme: const ColorScheme.light(
              primary: AppTheme.ognSmGreen,
              onPrimary: Colors.white,
              surface: AppTheme.bgSoftGreen,
            ),
            dialogBackgroundColor: AppTheme.bgSoftGreen,
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final String formattedTime =
          "${"${pickedTime.hour}".padLeft(2, '0')}:${"${pickedTime.minute}".padLeft(2, '0')}";

      if (mode == 2 && startTime.text.isNotEmpty) {
        // แปลงเวลาเริ่มต้นจาก String เป็น TimeOfDay
        final start = _parseTimeOfDay(startTime.text);

        // ถ้าเวลาสิ้นสุดน้อยกว่าหรือเท่ากับเวลาเริ่มต้น
        if (_compareTime(pickedTime, start) <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('เวลาสิ้นสุดต้องมากกว่าเวลาเริ่มต้น')),
          );
          return;
        }
      }

      setState(() {
        if (mode == 1) {
          startTime.text = formattedTime;
          leaveHistoryController.startTime.value = formattedTime;
          partTimeStart = selectedTime;
        } else {
          endTime.text = formattedTime;
          leaveHistoryController.endTime.value = formattedTime;
          partTimeEnd = selectedTime;
        }
      });
    }
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  int _compareTime(TimeOfDay a, TimeOfDay b) {
    final aMinutes = a.hour * 60 + a.minute;
    final bMinutes = b.hour * 60 + b.minute;
    return aMinutes.compareTo(bMinutes);
  }

  @override
  void initState() {
    super.initState();
    leaveHistoryController.fetchAdmin();
    // leaveHistoryController.loadFlowLeave();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'เลือกวัน-เวลาที่ต้องการลา',
                  style: TextStyle(
                    color: AppTheme.ognGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    for (var item in [
                      {'id': 1, 'name': 'ลาเต็มวัน'},
                      {'id': 2, 'name': 'ลาครึ่งวัน'},
                      {'id': 3, 'name': 'ลาเป็นชั่วโมง'},
                    ])
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => RadioListTile<int>(
                              fillColor: const WidgetStatePropertyAll(
                                  AppTheme.ognMdGreen),
                              value: item['id'] as int,
                              groupValue: leaveHistoryController
                                  .selectedTypeLeaveId.value,
                              title: Text(
                                item['name'] as String,
                                style: const TextStyle(
                                  color: AppTheme.ognMdGreen,
                                  fontSize: 14,
                                ),
                              ),
                              onChanged: (value) {
                                leaveHistoryController
                                    .selectedTypeLeaveId.value = value!;
                              },
                              visualDensity: VisualDensity.compact,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              dense: true,
                            ),
                          ),
                          Obx(() {
                            if (leaveHistoryController
                                    .selectedTypeLeaveId.value ==
                                item['id']) {
                              switch (leaveHistoryController
                                  .selectedTypeLeaveId.value) {
                                case 1:
                                  return _buildLeaveType1();
                                case 2:
                                  return _buildLeaveType2();
                                case 3:
                                  return _buildLeaveType3();
                                default:
                                  return SizedBox();
                              }
                            } else {
                              return SizedBox();
                            }
                          })
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveType1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 20,
                      color: AppTheme.ognOrangeGold,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'วันที่เริ่มต้น',
                      style: TextStyle(color: AppTheme.ognMdGreen),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: startDate,
                  style:
                      const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                  decoration: InputDecoration(
                    suffixIconConstraints: const BoxConstraints(minWidth: 55),
                    suffixIcon: const Icon(
                      Icons.calendar_month_rounded,
                      size: 20,
                      color: AppTheme.ognOrangeGold,
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 25),
                    labelText:
                        '${leaveHistoryController.startDate.isNotEmpty ? leaveHistoryController.startDate : 'เลือกวันที่'}',
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
                    _selectDate(context, 1);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ระบุวัน';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 20,
                      color: AppTheme.ognOrangeGold,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'วันที่สิ้นสุด',
                      style: TextStyle(color: AppTheme.ognMdGreen),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: endDate,
                  style:
                      const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                  decoration: InputDecoration(
                    suffixIconConstraints: const BoxConstraints(minWidth: 55),
                    suffixIcon: const Icon(
                      Icons.calendar_month_rounded,
                      size: 20,
                      color: AppTheme.ognOrangeGold,
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 25),
                    labelText:
                        '${leaveHistoryController.endDate.isNotEmpty ? leaveHistoryController.endDate : 'เลือกวันที่'}',
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
                    _selectDate(context, 2);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ระบุวัน';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveType2() {
    String formatWorkTime(String start, String end, int mode) {
      DateFormat inputFormat = DateFormat("HH:mm:ss");
      DateFormat outputFormat = DateFormat("HH.mm");

      DateTime startTime = inputFormat.parse(start);
      DateTime endTime = inputFormat.parse(end);

      String startFormatted = outputFormat.format(startTime);
      String endFormatted = outputFormat.format(endTime);

      if (mode == 1) {
        return 'ช่วงเช้า ($startFormatted - $endFormatted น.)';
      } else {
        return 'ช่วงบ่าย ($startFormatted - $endFormatted น.)';
      }
    }

    String amStart = leaveHistoryController
        .workTimeList.first['flexible_hours_log_line']['am_worktime_start'];
    String amEnd = leaveHistoryController
        .workTimeList.first['flexible_hours_log_line']['am_worktime_end'];
    String pmStart = leaveHistoryController
        .workTimeList.first['flexible_hours_log_line']['pm_worktime_start'];
    String pmEnd = leaveHistoryController
        .workTimeList.first['flexible_hours_log_line']['pm_worktime_end'];

    String amFormatted = formatWorkTime(amStart, amEnd, 1);
    String pmFormatted = formatWorkTime(pmStart, pmEnd, 2);
    final List<Map<String, dynamic>> timeSlots = [
      {'id': '1', 'name': amFormatted},
      {'id': '2', 'name': pmFormatted},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                size: 20,
                color: AppTheme.ognOrangeGold,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'วันที่',
                style: TextStyle(color: AppTheme.ognMdGreen),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: startDate,
            style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
            decoration: InputDecoration(
              suffixIconConstraints: const BoxConstraints(minWidth: 55),
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
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              labelText:
                  '${leaveHistoryController.startDate.isNotEmpty ? leaveHistoryController.startDate : 'เลือกวันที่'}',
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
                borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
              ),
            ),
            readOnly: true,
            onTap: () async {
              _selectDate(context, 1);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ระบุวัน';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณาเลือกช่วงเวลา';
                }
                return null;
              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                labelText: '',
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
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                ),
              ),
              borderRadius: BorderRadius.circular(20),
              hint: Text(
                'เลือกช่วงเวลา',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
              ),
              items: timeSlots.map<DropdownMenuItem<String>>(
                  (Map<String, dynamic> timeslot) {
                return DropdownMenuItem<String>(
                  value: timeslot['id'].toString(),
                  child: Text(
                    timeslot['name'],
                    style: GoogleFonts.kanit(
                      textStyle:
                          TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  print(value);
                  leaveHistoryController.selectedTypeTwoSetup.value = value;
                }
              },
              value: leaveHistoryController.selectedTypeTwoSetup.value ==
                      'เลือกช่วงเวลา'
                  ? leaveHistoryController.selectedTypeTwoSetup.value
                  : null, // กำหนดค่าเริ่มต้นเป็น null หากไม่มีค่า
              icon: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey[400],
                ),
              ),
              iconEnabledColor: Colors.white,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              dropdownColor: Colors.white,
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveType3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                size: 20,
                color: AppTheme.ognOrangeGold,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'วันที่',
                style: TextStyle(color: AppTheme.ognMdGreen),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: startDate,
            style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
            decoration: InputDecoration(
              suffixIconConstraints: const BoxConstraints(minWidth: 55),
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
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              labelText:
                  '${leaveHistoryController.startDate.isNotEmpty ? leaveHistoryController.startDate : 'เลือกวันที่'}',
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
                borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
              ),
            ),
            readOnly: true,
            onTap: () async {
              _selectDate(context, 1);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ระบุวัน';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          size: 20,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'เวลาเริ่มต้น',
                          style: TextStyle(color: AppTheme.ognMdGreen),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: startTime,
                      style: const TextStyle(
                          color: AppTheme.ognMdGreen, fontSize: 14),
                      decoration: InputDecoration(
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 55),
                        suffixIcon: const Icon(
                          FontAwesomeIcons.solidClock,
                          size: 16,
                          color: AppTheme.ognOrangeGold,
                        ),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        labelText:
                            '${leaveHistoryController.startTime.isNotEmpty ? leaveHistoryController.startTime : 'เลือกเวลา'}',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade300),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        _selectTime(context, 1);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ระบุเวลา';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          size: 20,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'เวลาสิ้นสุด',
                          style: TextStyle(color: AppTheme.ognMdGreen),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: endTime,
                      style: const TextStyle(
                          color: AppTheme.ognMdGreen, fontSize: 14),
                      decoration: InputDecoration(
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 55),
                        suffixIcon: const Icon(
                          FontAwesomeIcons.solidClock,
                          size: 16,
                          color: AppTheme.ognOrangeGold,
                        ),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        labelText:
                            '${leaveHistoryController.endTime.isNotEmpty ? leaveHistoryController.endTime : 'เลือกเวลา'}',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade300),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        _selectTime(context, 2);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ระบุเวลา';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
