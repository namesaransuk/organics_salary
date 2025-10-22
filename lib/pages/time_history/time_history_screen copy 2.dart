import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    timeHistoryController.loadData();
    timeHistoryController.loadFlowLeave();

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
                      Text(
                        // 'เดือน${timeHistoryController.c_startDate.value}',
                        'ตั้งแต่ ${timeHistoryController.c_startDate.value} - ${timeHistoryController.c_endDate.value}',
                        style: const TextStyle(color: AppTheme.ognGreen),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 70,
                                  alignment: Alignment.center,
                                  color: AppTheme.ognOrangeGold,
                                  child: const Text(
                                    'วันที่',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 150,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          color: AppTheme.ognOrangeGold,
                                          child: const Center(
                                            child: Text(
                                              'ก่อนเที่ยง',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: AppTheme.ognOrangeGold,
                                                child: const Text(
                                                  'เข้า',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Container(width: 2),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: AppTheme.ognOrangeGold,
                                                child: const Text(
                                                  'ออก',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 150,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          color: AppTheme.ognOrangeGold,
                                          child: const Center(
                                            child: Text(
                                              'หลังเที่ยง',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: AppTheme.ognOrangeGold,
                                                child: const Text(
                                                  'เข้า',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Container(width: 2),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: AppTheme.ognOrangeGold,
                                                child: const Text(
                                                  'ออก',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // const SizedBox(width: 2),
                                // SizedBox(
                                //   width: 140,
                                //   height: 70,
                                //   child: Column(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       Expanded(
                                //         child: Container(
                                //           width: double.infinity,
                                //           color: AppTheme.ognOrangeGold,
                                //           child: const Center(
                                //             child: Text(
                                //               'ล่วงเวลา',
                                //               style: TextStyle(
                                //                   color: Colors.white),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       const SizedBox(height: 2),
                                //       Expanded(
                                //         child: Row(
                                //           children: [
                                //             Expanded(
                                //               child: Container(
                                //                 alignment: Alignment.center,
                                //                 color: AppTheme.ognOrangeGold,
                                //                 child: const Text(
                                //                   'เข้า',
                                //                   style: TextStyle(
                                //                       color: Colors.white),
                                //                 ),
                                //               ),
                                //             ),
                                //             Container(width: 2),
                                //             Expanded(
                                //               child: Container(
                                //                 alignment: Alignment.center,
                                //                 color: AppTheme.ognOrangeGold,
                                //                 child: const Text(
                                //                   'ออก',
                                //                   style: TextStyle(
                                //                       color: Colors.white),
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: ([
                                  ...timeHistoryController.timeHistoryList
                                ]..sort((a, b) =>
                                        a['date'].compareTo(b['date'])))
                                    .map((row) => _buildCardRow(row))
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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
    final List<Map<String, String>> timeData = [
      {
        'label': 'ก่อนเที่ยงเข้า',
        'time': row['morning_in'] ?? '-',
        'delay': row['morning_in_delay'] ?? '',
      },
      {
        'label': 'ก่อนเที่ยงออก',
        'time': row['lunch_out'] ?? '-',
        'delay': row['lunch_out_early'] ?? '',
      },
      {
        'label': 'หลังเที่ยงเข้า',
        'time': row['lunch_in'] ?? '-',
        'delay': row['lunch_in_delay'] ?? '',
      },
      {
        'label': 'หลังเที่ยงออก',
        'time': row['evening_out'] ?? '-',
        'delay': row['evening_out_delay'] ?? '',
      },
      // {
      //   'label': 'ล่วงเวลาเข้า',
      //   'time': '-',
      //   'delay': '',
      // },
      // {
      //   'label': 'ล่วงเวลาเข้าออก',
      //   'time': '-',
      //   'delay': '',
      // },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: Builder(builder: (context) {
        if (row['row_type'] == 0) {
          return Container(
            height: 75,
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
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    row['date'],
                    style: const TextStyle(
                      color: AppTheme.ognMdGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                ...timeData.map((item) {
                  final String time = item['time'].toString();
                  final String? delay = item['delay'];
                  Color colorStatus = Colors.grey;
                  if (delay != null) {
                    if (item['label'] == 'หลังเที่ยงออก' &&
                        delay.startsWith('-')) {
                      colorStatus = AppTheme.ognMdGreen;
                    } else {
                      colorStatus = AppTheme.ognOrangeGold;
                    }
                  }

                  return Container(
                    alignment: Alignment.center,
                    width: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                            color: AppTheme.ognMdGreen,
                            fontSize: 12,
                          ),
                        ),
                        delay != ''
                            ? Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: colorStatus,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                    ),
                                    child: Text(
                                      // test,
                                      delay.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        } else if (row['row_type'] == 1) {
          final holiday = timeHistoryController.holidaysList.firstWhere(
            (hlday) => hlday['date'] == row['date'],
            orElse: () => null,
          );

          return Container(
            width: 400,
            height: 75,
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
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    row['date'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppTheme.ognMdGreen,
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
                        holiday != null ? Icons.star : Icons.close,
                        size: 18,
                        color: AppTheme.ognOrangeGold,
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          holiday != null
                              ? holiday['holiday_name'] ?? 'วันหยุดนักขัตฤกษ์'
                              : 'ไม่มีข้อมูลการบันทึกเวลา',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.ognOrangeGold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (row['row_type'] == 2) {
          return Container(
            width: 400,
            height: 75,
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
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    row['date'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppTheme.ognMdGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        row['leave_history'] != null
                            ? row['leave_history']['leave_detail']['leavetype']
                                ['holiday_name_type']
                            : 'ลา (ไม่ระบุประเภท)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ognOrangeGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (row['row_type'] == 3) {
          return Container(
            width: 400,
            height: 75,
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
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    row['date'],
                    style: const TextStyle(
                      color: AppTheme.ognMdGreen,
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
                        color: AppTheme.ognOrangeGold,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'หยุดเสาร์-อาทิตย์',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ognOrangeGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('ไม่มีข้อมูล');
        }
      }),
    );
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
