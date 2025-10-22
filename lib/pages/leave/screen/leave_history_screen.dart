import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/leave_history_controller.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/controllers/notification_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  final LoadingController loadingController = Get.put(LoadingController());

  final LeaveHistoryController leaveHistoryController =
      Get.put(LeaveHistoryController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  final DateRangePickerController _controller = DateRangePickerController();

  late bool screenMode;

  @override
  void dispose() {
    leaveHistoryController.clear();
    Get.delete<LeaveHistoryController>();
    super.dispose();
  }

  @override
  void initState() {
    // employeeLeaves = getEmployeeLeaveData();
    // employeeDataSource = EmployeeLeaveDataSource(employeeLeave: employeeLeaves);

    final DateTime today = DateTime.now();
    leaveHistoryController.c_startDate.value = DateFormat('MMMM yyyy')
        .format(today)
        .replaceFirst(
          '${today.year}',
          '${today.year}',
        )
        .toString();
    leaveHistoryController.c_endDate.value = DateFormat('MMMM yyyy')
        .format(today.add(const Duration(days: 0)))
        .replaceFirst(
          '${today.year}',
          '${today.year}',
        )
        .toString();
    _controller.selectedRange =
        PickerDateRange(today, today.add(const Duration(days: 0)));

    leaveHistoryController.searchStartDate.value = DateFormat('yyyy-MM-dd')
        .format(today.subtract(const Duration(days: 5)))
        .toString();

    DateTime endOfDay =
        DateTime(today.year, today.month, today.day, 23, 59, 59);
    leaveHistoryController.searchEndDate.value =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(endOfDay).toString();

    leaveHistoryController.loadData();

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime startDate = args.value.startDate;
    DateTime endDate = args.value.endDate ?? args.value.startDate;

    print(startDate);
    print(endDate);

    setState(() {
      leaveHistoryController.c_startDate.value = DateFormat('MMMM yyyy', 'th')
          .format(startDate)
          .replaceFirst(
            '${startDate.year}',
            '${startDate.year}',
          )
          .toString();

      leaveHistoryController.c_endDate.value = DateFormat('MMMM yyyy', 'th')
          .format(endDate)
          .replaceFirst(
            '${endDate.year}',
            '${endDate.year}',
          )
          .toString();

      leaveHistoryController.searchStartDate.value =
          DateFormat('yyyy-MM-dd').format(startDate).toString();

      DateTime endOfDay =
          DateTime(endDate.year, endDate.month + 1, 0, 23, 59, 59);
      leaveHistoryController.searchEndDate.value =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(endOfDay).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'ตั้งแต่ ${leaveHistoryController.c_startDate.value} - ${leaveHistoryController.c_endDate.value}',
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
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(
          () => leaveHistoryController.leaveHistoryList.isNotEmpty
              ? Expanded(
                  child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children:
                            leaveHistoryController.leaveHistoryList.map((item) {
                          DateTime dateTime =
                              DateTime.parse(item['created_at']);
                          final thaiYear = dateTime.year;
                          final thaiMonths = [
                            'มกราคม',
                            'กุมภาพันธ์',
                            'มีนาคม',
                            'เมษายน',
                            'พฤษภาคม',
                            'มิถุนายน',
                            'กรกฎาคม',
                            'สิงหาคม',
                            'กันยายน',
                            'ตุลาคม',
                            'พฤศจิกายน',
                            'ธันวาคม'
                          ];
                          final thaiMonth = thaiMonths[dateTime.month - 1];

                          String formattedDate =
                              '${dateTime.day} $thaiMonth $thaiYear';

                          Color colorStatus = Colors.grey;
                          if (item['status'] == 1) {
                            colorStatus = Colors.grey;
                          } else if (item['status'] == 2) {
                            colorStatus = Colors.amber;
                          } else if (item['status'] == 3) {
                            colorStatus = Colors.orange;
                          } else if (item['status'] == 4) {
                            colorStatus = AppTheme.stepperGreen;
                          } else if (item['status'] == 5) {
                            colorStatus = Colors.red;
                          } else if (item['status'] == 6) {
                            colorStatus = Colors.red;
                          }

                          return Container(
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.all(5),
                            // margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                // openBottomSheet(item);
                                Get.toNamed(
                                  'leave-section',
                                  arguments: item['id'],
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   width: 100,
                                  //   height: 100,
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(15),
                                  //       bottomLeft: Radius.circular(15),
                                  //     ),
                                  //     child: Image.network(
                                  //       'https://media.istockphoto.com/id/1418476287/photo/businessman-analyzing-companys-financial-balance-sheet-working-with-digital-augmented-reality.jpg?s=612x612&w=0&k=20&c=Cgdq4iCELzmCVg19Z69GPt0dgNYbN7zbAARkzNSpyno=',
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${item['leave_history']?['leave_detail']?['leavetype']?['holiday_name_type'] ?? '-'}',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: const TextStyle(
                                                      color: AppTheme.ognGreen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 3,
                                                        horizontal: 12),
                                                    decoration: BoxDecoration(
                                                      color: colorStatus,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(35),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .fiber_manual_record,
                                                          size: 10,
                                                          color: Colors.white,
                                                        ),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          item['status_logs']
                                                                      ?[
                                                                      'status_name'] !=
                                                                  null
                                                              ? (item['status_logs']
                                                                          ['status_name']
                                                                      is List
                                                                  ? (item['status_logs'][
                                                                              'status_name']
                                                                          .isNotEmpty
                                                                      ? item['status_logs']['status_name'][0][
                                                                              'emp_status_app']
                                                                          .toString()
                                                                      : 'รายการใหม่')
                                                                  : item['status_logs']
                                                                          ['status_name']
                                                                      .toString())
                                                              : 'ขออนุมัติ',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                // 'ตั้งแต่ : ${formatDate(item['leave_history']['start_date'])} - ${formatDate(item['leave_history']['end_date'])}',
                                                'ตั้งแต่ : ${formatDate(item['leave_history']['start_date'])}',
                                                style: const TextStyle(
                                                  color: AppTheme.ognMdGreen,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'จนถึง : ${formatDate(item['leave_history']['end_date'])}',
                                                style: const TextStyle(
                                                  color: AppTheme.ognMdGreen,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2),
                                                child: Text(
                                                  'สาเหตุการลา : ${item['leave_history']['reason_leave']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'วันที่ส่งข้อมูล : $formattedDate',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ))
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/menu/leave.png',
                        width: MediaQuery.of(context).size.width *
                            (screenMode ? 0.10 : 0.25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'ไม่มีข้อมูลของเดือนที่เลือก',
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
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }

  String formatDate(String dateTime) {
    final date = DateTime.parse(dateTime);

    final thaiMonths = [
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม'
    ];
    final thaiYear = date.year; // เพิ่ม 543 เพื่อแปลงปีเป็น พ.ศ.
    final thaiMonth = thaiMonths[date.month - 1];
    final time = DateFormat('HH:mm น.').format(date);

    return '${date.day} $thaiMonth $thaiYear ($time)';
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
                                    'เดือนเริ่มต้น',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    leaveHistoryController.c_startDate.value,
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
                                    'เดือนสิ้นสุด',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    leaveHistoryController.c_endDate.value,
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
                        view: DateRangePickerView.year,
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
                            leaveHistoryController.loadData();
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

  void openBottomSheet(item) {
    var baseUrl = dotenv.env['ASSET_URL'];

    Color colorStatus = Colors.grey;
    if (item['status'] == 1) {
      colorStatus = Colors.grey;
    } else if (item['status'] == 2) {
      colorStatus = Colors.amber;
    } else if (item['status'] == 3) {
      colorStatus = Colors.orange;
    } else if (item['status'] == 4) {
      colorStatus = AppTheme.stepperGreen;
    } else if (item['status'] == 5) {
      colorStatus = Colors.red;
    } else if (item['status'] == 6) {
      colorStatus = Colors.red;
    }

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.library_books_sharp,
                    color: AppTheme.ognGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'รายละเอียด',
                    style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(2, 4, 2, 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        // color: Colors.grey[50],
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              children: [
                                const Icon(Icons.info,
                                    color: AppTheme.ognOrangeGold),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'สถานะการดำเนินการ',
                                    style: TextStyle(color: AppTheme.ognGreen),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: colorStatus,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(35),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.fiber_manual_record,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        item['status_logs']['status_name'] !=
                                                null
                                            ? (item['status_logs']
                                                    ['status_name'] is List
                                                ? (item['status_logs']
                                                            ['status_name']
                                                        .isNotEmpty
                                                    ? item['status_logs']
                                                                ['status_name'][
                                                            0]['emp_status_app']
                                                        .toString()
                                                    : 'รายการใหม่')
                                                : item['status_logs']
                                                        ['status_name']
                                                    .toString())
                                            : 'ขออนุมัติ',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildDetailRow(Icons.category, 'ประเภทการลา',
                              '${item['leave_history']['leave_detail']['leavetype']['holiday_name_type']}'),
                          _buildDetailRow(
                              Icons.description,
                              'รายละเอียดเพิ่มเติม',
                              item['leave_history']?['leave_detail']
                                      ?['sub_leave']?['holiday_name_type'] ??
                                  'ไม่มีข้อมูล'),
                          _buildDetailRow(Icons.error, 'สาเหตุการลา',
                              '${item['leave_history']['reason_leave']}'),
                          // _buildDetailRow(Icons.person, 'ผู้ปฏิบัติงานแทน', 'นายแอดมิน ทดสอบ'),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    item['leave_main_image'] != null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showImageViewer(
                                                        context,
                                                        Image.network(
                                                                '$baseUrl/${item['leave_main_image']['file_path']}')
                                                            .image,
                                                        useSafeArea: true,
                                                        swipeDismissible: true,
                                                        doubleTapZoomable: true,
                                                      );
                                                    },
                                                    child: Image.network(
                                                      '$baseUrl/${item['leave_main_image']['file_path']}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ), // หรือใช้ Icon(Icons.image_not_supported)
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    item['leave_sub_image'] != null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showImageViewer(
                                                        context,
                                                        Image.network(
                                                                '$baseUrl/${item['leave_sub_image']['file_path']}')
                                                            .image,
                                                        useSafeArea: true,
                                                        swipeDismissible: true,
                                                        doubleTapZoomable: true,
                                                      );
                                                    },
                                                    child: Image.network(
                                                      '$baseUrl/${item['leave_sub_image']['file_path']}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.teal,
                            indent: 50,
                            endIndent: 50,
                          ),
                          _buildDetailRow(
                              Icons.access_time,
                              'ตั้งแต่วันที่/เวลา',
                              formatDate(item['leave_history']['start_date'])),
                          _buildDetailRow(Icons.access_time, 'จนถึงวันที่/เวลา',
                              formatDate(item['leave_history']['end_date'])),
                          // _buildDetailRow(Icons.timer, 'จำนวนทั้งหมด', '0 วัน 0 ชั่วโมง 5 นาที'),
                          _buildDetailRow(Icons.date_range, 'วันที่แจ้ง',
                              formatDate(item['created_at'])),
                        ],
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.ognOrangeGold),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: AppTheme.ognGreen),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.teal),
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
}
