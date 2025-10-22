import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/leave_approve_controller.dart';
import 'package:organics_salary/theme.dart';

class HistoryLeaveApproveScreen extends StatefulWidget {
  final dynamic item;
  final dynamic mode;

  const HistoryLeaveApproveScreen(this.item, this.mode, {Key? key})
      : super(key: key);

  @override
  State<HistoryLeaveApproveScreen> createState() =>
      _HistoryLeaveApproveScreenState();
}

class _HistoryLeaveApproveScreenState extends State<HistoryLeaveApproveScreen> {
  late bool screenMode;

  final LeaveApproveController leaveApproveController =
      Get.put(LeaveApproveController());

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    // final mode = widget.mode;

    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListView(
              children: leaveApproveController.leaveTotalUsedList.map((leave) {
                String leaveUsed = '-';
                bool colorActive = false;
                // item['leave_detail']['leave_types_id'];
                // leave['id'];
                if (item['leave_history']['leave_histories_view']
                        ['leave_types_id'] ==
                    leave['id']) {
                  leaveUsed =
                      '${item['leave_history']['leave_histories_view']['total_workdays_used']} วัน ${item['leave_history']['leave_histories_view']['leave_hours']} ชม. ${item['leave_history']['leave_histories_view']['leave_minutes']} นาที';
                  colorActive = true;
                }

                // var remainingLeave = calculateRemainingLeave(leave);
                // print(calculateRemainingLeave(leave));
                return leaveItem(
                  leave['holiday_name_type'],
                  'รวมทั้งหมด  ${leave['limit']}  วัน',
                  '${leave['leaveUsed']?['days']} วัน ${leave['leaveUsed']?['hours']} ชม. ${leave['leaveUsed']?['minutes']} นาที',
                  leaveUsed,
                  '${leave['remaining']?['days']} วัน ${leave['remaining']?['hours']} ชม. ${leave['remaining']?['minutes']} นาที',
                  colorActive,
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Map<String, dynamic> calculateRemainingLeave(Map<String, dynamic> typeData) {
    var detailLeave = leaveApproveController.workTimeList.first;

    DateTime currentDate = DateTime.now();
    String currentDateFormatted = DateFormat('yyyy-MM-dd').format(currentDate);

    DateTime setStartData = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['am_worktime_start']}");
    DateTime setEndData = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['pm_worktime_end']}");

    DateTime amEnd = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['am_worktime_end']}");
    DateTime pmStart = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['pm_worktime_start']}");

    Duration intervalBreak = pmStart.difference(amEnd);
    int hoursBreak = intervalBreak.inHours;
    int minutesBreak = intervalBreak.inMinutes % 60;

    Duration getDateTimeSetup = setEndData.difference(setStartData);
    int hoursSetup = getDateTimeSetup.inHours;
    int minutesSetup = getDateTimeSetup.inMinutes % 60;

    if ((hoursBreak > 0 || minutesBreak > 0)) {
      hoursSetup -= hoursBreak;
      minutesSetup -= minutesBreak;
    }

    print(minutesSetup);

    int totalUsedDays = typeData['total_used_days'];
    int totalUsedHours = typeData['total_used_hours'];
    int totalUsedMinutes = typeData['total_used_minutes'];

    int additionalHoursFromMinutes = totalUsedMinutes ~/ 60;
    int remainingMinutes = totalUsedMinutes % 60;

    totalUsedHours += additionalHoursFromMinutes;

    int additionalDaysFromHours = totalUsedHours ~/ hoursSetup;
    int remainingHours = totalUsedHours % hoursSetup;

    totalUsedDays += additionalDaysFromHours;

    int balanceDays = int.parse(typeData['amount']) - totalUsedDays;
    int balanceHours = 0 - remainingHours;
    int balanceMinutes = 0 - remainingMinutes;

    if (balanceMinutes < 0) {
      balanceMinutes += 60;
      balanceHours -= 1;
    }

    if (balanceHours < 0) {
      balanceHours += hoursSetup;
      balanceDays -= 1;
    }

    return {
      'Leaveused': {
        'days': totalUsedDays,
        'hours': remainingHours,
        'minutes': remainingMinutes,
        'hoursSetup': hoursSetup,
      },
      'LeaveBalance': {
        'days': balanceDays,
        'hours': balanceHours,
        'minutes': balanceMinutes,
      }
    };
  }

  Widget leaveItem(String title, String quota, String used, String usedThisTime,
      String remaining, bool colorActive) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            decoration: BoxDecoration(
              color: colorActive ? AppTheme.bgSoftGreen : Color(0xFFF4F4F4),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.solidCalendar,
                        color: colorActive ? AppTheme.ognGreen : Colors.grey,
                        size: 18),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: colorActive ? AppTheme.ognGreen : Colors.black54,
                      ),
                    ),
                  ],
                ),
                Text(
                  quota,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: colorActive ? AppTheme.ognGreen : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                leaveColumn('ใช้ไปแล้ว', used, colorActive),
                leaveColumn('ใช้ครั้งนี้', usedThisTime, colorActive),
                leaveColumn('คงเหลือ', remaining, colorActive),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveColumn(String title, String value, bool colorActive) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: colorActive ? AppTheme.ognGreen : Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: colorActive ? AppTheme.ognGreen : Colors.black54,
              // fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
