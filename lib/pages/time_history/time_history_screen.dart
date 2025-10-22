import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:organics_salary/controllers/time_history_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TimeHistoryPage extends StatefulWidget {
  const TimeHistoryPage({super.key});

  @override
  State<TimeHistoryPage> createState() => _TimeHistoryPageState();
}

class _TimeHistoryPageState extends State<TimeHistoryPage> {
  late bool screenMode;

  final TimeHistoryController timeHistoryController =
      Get.put(TimeHistoryController());
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    final DateTime today = DateTime.now();
    timeHistoryController.c_startDate.value = DateFormat('dd MMMM yyyy')
        .format(today.subtract(const Duration(days: 5)))
        .replaceFirst(
          '${today.year}',
          '${today.year}',
        )
        .toString();
    timeHistoryController.c_endDate.value = DateFormat('dd MMMM yyyy')
        .format(today)
        .replaceFirst(
          '${today.year}',
          '${today.year}',
        )
        .toString();

    _controller.selectedRange =
        PickerDateRange(today.subtract(const Duration(days: 5)), today);

    timeHistoryController.searchStartDate.value = DateFormat('yyyy-MM-dd')
        .format(today.subtract(const Duration(days: 5)))
        .toString();

    DateTime endOfDay =
        DateTime(today.year, today.month, today.day, 23, 59, 59);
    timeHistoryController.searchEndDate.value =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(endOfDay).toString();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timeHistoryController.loadInitial();
      if (mounted) setState(() {});
    });

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime startDate = args.value.startDate;
    DateTime endDate = args.value.endDate ?? args.value.startDate;

    timeHistoryController.c_startDate.value = DateFormat('dd MMMM yyyy')
        .format(startDate)
        .replaceFirst(
          '${startDate.year}',
          '${startDate.year}',
        )
        .toString();
    timeHistoryController.c_endDate.value = DateFormat('dd MMMM yyyy')
        .format(endDate)
        .replaceFirst(
          '${endDate.year}',
          '${endDate.year}',
        )
        .toString();

    timeHistoryController.searchStartDate.value =
        DateFormat('yyyy-MM-dd').format(startDate).toString();

    DateTime endOfDay =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    timeHistoryController.searchEndDate.value =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(endOfDay).toString();

    timeHistoryController.loadData();
  }

  @override
  void dispose() {
    // leaveHistoryController.dispose();
    // salaryController.clearHistory();
    // Get.delete<LeaveHistoryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          'สถิติการเข้าออกงาน',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              timeHistoryController.loadStatus(context);
            },
            icon: Icon(
              Icons.refresh,
              color: AppTheme.ognOrangeGold,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: AppTheme.ognOrangeGold,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'ตั้งแต่ ${timeHistoryController.c_startDate.value} - ${timeHistoryController.c_endDate.value}',
                          style: const TextStyle(
                            color: AppTheme.ognGreen,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return dateSelected();
                        },
                      );
                    },
                    child: const Icon(
                      Icons.tune_rounded,
                      color: AppTheme.ognOrangeGold,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => timeHistoryController.timeHistoryList.isNotEmpty
                ? Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                          child: Column(
                            children: ([
                              ...timeHistoryController.timeHistoryList
                            ]..sort((a, b) => a['date'].compareTo(b['date'])))
                                .map((row) => _buildCardRow(row))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/menu/statistics.png',
                          width: MediaQuery.of(context).size.width *
                              (screenMode ? 0.10 : 0.25),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'ไม่มีข้อมูลของวันที่เลือก',
                          style: TextStyle(
                            color: Colors.grey[400],
                            // fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardRow(row) {
    final h1 = row['hour_12_1'];
    final h2 = row['hour_12_2'];
    String lunchDate = '-';

    if (h1 != null && h2 != null) {
      lunchDate = '$h1 - $h2';
    } else if (h1 != null) {
      lunchDate = 'ออก $h1';
    } else if (h2 != null) {
      lunchDate = 'เข้า $h2';
    }

    final List<Map<String, String>> timeData = [
      {
        'label': 'เข้าครั้งแรก',
        'time': row['first_activity_time'] ?? '-',
        'delay': row['morning_in_delay'] ?? '',
      },
      {
        'label': 'ช่วงเที่ยง',
        'time': lunchDate,
        // '${row['hour_12_1'] != null ? '${row['hour_12_1']}' : null} ${row['hour_12_2'] != null ? '${row['hour_12_1'] != null && row['hour_12_2'] != null ? '-' : null} ${row['hour_12_2']}' : null}',
        'delay': '',
      },
      {
        'label': 'ออกครั้งสุดท้าย',
        'time': row['last_activity_time'] ?? '-',
        'delay': row['evening_out_delay'] ?? '',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: Builder(builder: (context) {
        if (row['is_leave'] == 'N') {
          final holiday = timeHistoryController.holidaysList.firstWhere(
            (hlday) {
              final date = DateTime.parse(row['date']);
              final start = DateTime.parse(hlday['holiday_start']);
              final end = DateTime.parse(hlday['holiday_end']);
              return date.isAtSameMomentAs(start) ||
                  date.isAtSameMomentAs(end) ||
                  (date.isAfter(start) && date.isBefore(end));
            },
            orElse: () => null,
          );

          print(holiday);
          if (holiday != null) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          row['date'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          holiday['holiday_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (row.containsKey('weekend') && row['weekend'] == 'Y') {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(
                        row['date'],
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.grey[700],
                          ),
                          SizedBox(width: 8),
                          Text(
                            'หยุดเสาร์-อาทิตย์',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.ognMdGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          row['date'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          children: timeData.map((item) {
                            final String label = item['label'].toString();
                            final String time = item['time'].toString();
                            // final String? delay = item['delay'];
                            Color colorStatus = Colors.grey;
                            IconData icon;

                            switch (item['label']) {
                              case 'เข้าครั้งแรก':
                                colorStatus = AppTheme.ognMdGreen;
                                icon = Symbols.login;
                                break;
                              case 'ช่วงเที่ยง':
                                colorStatus = AppTheme.ognOrangeGold;
                                icon = Symbols.wb_sunny;
                                break;
                              case 'ออกครั้งสุดท้าย':
                                colorStatus = AppTheme.ognMdGreen;
                                icon = Symbols.logout;
                                break;
                              default:
                                colorStatus = AppTheme.ognMdGreen;
                                icon = Symbols.trip_origin;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        icon,
                                        color: colorStatus,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        label,
                                        style: TextStyle(
                                          color: colorStatus,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      color: colorStatus,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        } else if (row['is_leave'] == 'Y') {
          final holiday = timeHistoryController.holidaysList.firstWhere(
            (hlday) {
              final date = DateTime.parse(row['date']);
              final start = DateTime.parse(hlday['holiday_start']);
              final end = DateTime.parse(hlday['holiday_end']);
              return date.isAtSameMomentAs(start) ||
                  date.isAtSameMomentAs(end) ||
                  (date.isAfter(start) && date.isBefore(end));
            },
            orElse: () => null,
          );

          // print(row['leave_detail']?['leavetype']?['holiday_name_type'] ??
          //     'ไม่มีข้อมูลการลา');

          // print(holiday);
          // item!['leave_history']['leave_detail']['leavetype']['holiday_name_type']
          // row['leave_history'] != null
          //                             ? row['leave_history']['leave_detail']['leavetype']
          //                                 ['holiday_name_type']
          //                             : 'ลา (ไม่ระบุประเภท)',

          if (holiday != null) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          row['date'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          holiday['holiday_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (row.containsKey('weekend') && row['weekend'] == 'Y') {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(
                        row['date'],
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.grey[700],
                          ),
                          SizedBox(width: 8),
                          Text(
                            'หยุดเสาร์-อาทิตย์',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (row['first_activity_time'] != null ||
              row['hour_12_1'] != null ||
              row['hour_12_2'] != null ||
              row['last_activity_time'] != null) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.ognMdGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              row['date'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              children: timeData.map((item) {
                                final String label = item['label'].toString();
                                final String time = item['time'].toString();
                                // final String? delay = item['delay'];
                                Color colorStatus = Colors.grey;
                                IconData icon;

                                switch (item['label']) {
                                  case 'เข้าครั้งแรก':
                                    colorStatus = AppTheme.ognMdGreen;
                                    icon = Symbols.login;
                                    break;
                                  case 'ช่วงเที่ยง':
                                    colorStatus = AppTheme.ognOrangeGold;
                                    icon = Symbols.wb_sunny;
                                    break;
                                  case 'ออกครั้งสุดท้าย':
                                    colorStatus = AppTheme.ognMdGreen;
                                    icon = Symbols.logout;
                                    break;
                                  default:
                                    colorStatus = AppTheme.ognMdGreen;
                                    icon = Symbols.trip_origin;
                                }

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            icon,
                                            color: colorStatus,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            label,
                                            style: TextStyle(
                                              color: colorStatus,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        time,
                                        style: TextStyle(
                                          color: colorStatus,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      children: (row['leave_history'] as List)
                          .where((item) => item['status'] != 0)
                          .map<Widget>((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidCircle,
                                    color: Colors.grey[700],
                                    size: 5,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['leave_detail']?['leavetype']
                                                ?['holiday_name_type']
                                            ?.toString() ??
                                        'ลา (ไม่ได้ระบุประเภท)',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${formatDateTimeShort(item['start_date'])} ถึง ${formatDateTimeShort(item['end_date'])}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(1, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.ognOrangeGold,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          row['date'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          row['leave_history'][0]['leave_detail']?['leavetype']
                                      ?['holiday_name_type'] !=
                                  null
                              ? row['leave_history'][0]['leave_detail']
                                  ['leavetype']['holiday_name_type']
                              : 'ลา (ไม่ระบุประเภท)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.ognOrangeGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[400],
              border: Border.all(
                color: Colors.grey.shade400,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 0.5,
                  offset: const Offset(1, 0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      row['date'],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.punch_clock,
                          size: 18,
                          color: Colors.grey[700],
                        ),
                        SizedBox(width: 8),
                        Text(
                          'ไม่มีข้อมูล',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  String formatDateTimeShort(String input) {
    try {
      DateTime dateTime = DateTime.parse(input);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} น.';
    } catch (e) {
      return input; // หรือจะ return 'Invalid date' ก็ได้ ถ้า parse ไม่ได้
    }
  }

  Widget dateSelected() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: const Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 28,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'เลือกช่วงเวลา',
                          style: TextStyle(
                              color: AppTheme.ognGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // 'เลือกเดือน',
                                    'วันที่เริ่มต้น',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    timeHistoryController.c_startDate.value,
                                    style: const TextStyle(
                                      color: AppTheme.ognMdGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Center(
                              child: Text(
                                'ถึง',
                                style: TextStyle(
                                  color: AppTheme.ognMdGreen,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'วันที่สิ้นสุด',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    timeHistoryController.c_endDate.value,
                                    style: const TextStyle(
                                      color: AppTheme.ognMdGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SfDateRangePicker(
                        controller: _controller,
                        backgroundColor: Colors.transparent,
                        startRangeSelectionColor: AppTheme.ognXsmGreen,
                        endRangeSelectionColor: AppTheme.ognXsmGreen,
                        rangeSelectionColor: AppTheme.ogn2XsmGreen,
                        selectionRadius: 12,
                        monthFormat: 'MMMM',
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        rangeTextStyle:
                            const TextStyle(color: AppTheme.ognMdGreen),
                        headerStyle: const DateRangePickerHeaderStyle(
                            backgroundColor: Colors.transparent,
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.ognGreen)),
                        onSelectionChanged: (args) {
                          selectionChanged(args);
                          setState(() {}); // ใช้ setState เพื่อ rebuild dialog
                        },
                        allowViewNavigation: false,
                        showNavigationArrow: true,
                        yearCellStyle: const DateRangePickerYearCellStyle(
                          todayTextStyle: TextStyle(color: AppTheme.ognMdGreen),
                          todayCellDecoration:
                              BoxDecoration(color: Colors.white),
                          textStyle: TextStyle(color: AppTheme.ognMdGreen),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: const ButtonStyle(),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text('ยกเลิก'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.ognOrangeGold,
                          ),
                          onPressed: () {
                            timeHistoryController.loadData();
                            Get.back();
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: Text(
                                  'ยืนยัน',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String numberToStringCurrency(int? amount) {
    String formattedAmount =
        NumberFormat('#,###.##', 'en_US').format(amount ?? 0);
    return "$formattedAmount บาท";
  }

  // String _getThaiMonth(String month) {
  //   final formatter = DateFormat('MMMM', 'th');
  //   return formatter.format(DateTime(2024, int.parse(month)));
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
