import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:organics_salary/pages/salary/screen/slip_section_page.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SlipView extends StatefulWidget {
  const SlipView({super.key});

  @override
  State<SlipView> createState() => _SlipViewState();
}

class _SlipViewState extends State<SlipView> {
  final box = GetStorage();
  final SalaryController salaryController = Get.put(SalaryController());
  final DateRangePickerController _controller = DateRangePickerController();

  late bool screenMode;

  @override
  void initState() {
    final DateTime currentDate = DateTime.now();

    final DateTime previousMonth =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);

    salaryController.c_startDate.value =
        DateFormat('MMMM yyyy').format(previousMonth).toString();
    salaryController.c_endDate.value =
        DateFormat('MMMM yyyy').format(previousMonth).toString();

    _controller.selectedDate = previousMonth;

    int currentMonth = previousMonth.month;
    int currentYear = previousMonth.year;

    salaryController.monthSelected.value = currentMonth.toString();
    salaryController.yearSelected.value = currentYear.toString();

    salaryController.loadData();

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime selectedDate = args.value; // ในกรณีนี้ args.value จะเป็น DateTime

    // แปลงวันที่ที่เลือกเป็นรูปแบบที่ต้องการ
    salaryController.c_startDate.value = DateFormat('MMMM yyyy')
        .format(selectedDate)
        .replaceFirst(
          '${selectedDate.year}',
          '${selectedDate.year}',
        )
        .toString();

    salaryController.c_endDate.value = DateFormat('MMMM yyyy')
        .format(selectedDate)
        .replaceFirst(
          '${selectedDate.year}',
          '${selectedDate.year}',
        )
        .toString();

    int currentMonth = selectedDate.month;
    int currentYear = selectedDate.year;

    salaryController.monthSelected.value = currentMonth.toString();
    salaryController.yearSelected.value = currentYear.toString();
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
                    Text(
                      'เดือน${salaryController.c_startDate.value}',
                      // 'ตั้งแต่${salaryController.c_startDate.value} - ${salaryController.c_endDate.value}',
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
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () {
            return salaryController.salaryList.isNotEmpty
                ? Expanded(
                    child: SlipViewSection(
                        filePath: salaryController.salaryList.value),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/time_history/history.png',
                          width: MediaQuery.of(context).size.width * 0.25,
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
                  );
          },
        ),
      ],
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
                                    'เลือกเดือน',
                                    // 'เดือนเริ่มต้น',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    salaryController.c_startDate.value,
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
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 7),
                          //   child: Center(
                          //     child: Text(
                          //       'ถึง',
                          //       style: TextStyle(
                          //         color: AppTheme.ognMdGreen,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Expanded(
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 10, horizontal: 15),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       border: Border.all(
                          //           color: Colors.grey.shade300, width: 0.5),
                          //       borderRadius: const BorderRadius.all(
                          //         Radius.circular(16.0),
                          //       ),
                          //     ),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           'เดือนสิ้นสุด',
                          //           style: TextStyle(
                          //               color: Colors.grey[400], fontSize: 10),
                          //         ),
                          //         Text(
                          //           timeHistoryController.c_endDate.value,
                          //           style: const TextStyle(
                          //             color: AppTheme.ognMdGreen,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 13,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
                        selectionMode: DateRangePickerSelectionMode.single,
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
                            salaryController.loadData();
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
    return "+ $formattedAmount";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
