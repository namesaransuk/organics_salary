import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/request_doc_controller.dart';
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final box = GetStorage();
  final SalaryController salaryController = Get.put(SalaryController());
  final DateRangePickerController _controller = DateRangePickerController();
  final RequestDocController requestDocController =
      Get.put(RequestDocController());

  late bool screenMode;

  @override
  void initState() {
    final DateTime currentDate = DateTime.now();

    final DateTime previousMonth =
        DateTime(currentDate.year, currentDate.month - 0, currentDate.day);

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
    requestDocController.loadDataSuccess();
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
    requestDocController.loadDataSuccess();
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
        Obx(() {
          final selectedDate = _controller.selectedDate;

          // กรองข้อมูลตามเดือนและปี
          final filteredList =
              requestDocController.transectionSuccessList.where((item) {
            if (selectedDate == null) return true;
            final createdAtStr = item['created_at'];
            if (createdAtStr == null) return false;
            final createdAt = DateTime.tryParse(createdAtStr);
            if (createdAt == null) return false;
            return createdAt.month == selectedDate.month &&
                createdAt.year == selectedDate.year;
          }).toList();

          return filteredList.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];

                      final employeeData =
                          item['status_logs']?['employee_data'];
                      final positionName = employeeData != null
                          ? employeeData['positions_th'] ?? '-'
                          : '-';
                      final createAt = item['status_logs']?['created_at_th'];
                      final statusLog = item['status_logs'];
                      int statusNumber = statusLog != null
                          ? statusLog['status_number'] ?? 0
                          : 0;

                      String statusText;
                      Color statusColor;

                      switch (statusNumber) {
                        case 0:
                          statusText = "ขออนุมัติ";
                          statusColor = Colors.grey;
                          break;
                        case 1:
                          statusText = "ขออนุมัติ";
                          statusColor = Colors.grey;
                          break;
                        case 2:
                          statusText = "อนุมัติ";
                          statusColor = AppTheme.stepperGreen;
                          break;
                        case 3:
                          statusText = "ไม่อนุมัติ";
                          statusColor = Colors.red;
                          break;
                        case 99:
                          statusText = "ไม่สำเร็จ";
                          statusColor = Colors.black;
                          break;
                        default:
                          statusText = "รอดำเนินการ";
                          statusColor = Colors.grey;
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          color: AppTheme.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title + Status
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${item['detail']}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.ognGreen,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: statusColor),
                                      ),
                                      child: Text(
                                        statusText,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // ชื่อพนักงาน + ตำแหน่ง
                                Text(
                                  "ชื่อพนักงาน : ${box.read('fnames')} ${box.read('lnames')} ($positionName)",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.deactivatedText,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                // วันที่ส่งข้อมูล
                                Text(
                                  "วันที่ส่งข้อมูล : ${item['format_date']}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.deactivatedText,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                if (statusNumber == 2 || statusNumber == 3)
                                  Text(
                                    "วันที่อนุมัติ : $createAt",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.deactivatedText,
                                    ),
                                  ),

                                // note1 (ถ้ามี)
                                if (item['note1'] != null &&
                                    item['note1'].toString().isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      "หมายเหตุ: ${item['note1']}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.deactivatedText,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                if (statusNumber == 3)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0), // เว้นระยะด้านบน
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(
                                            thickness: 0.5,
                                            color: Colors.grey), // เส้นคั่น
                                        const SizedBox(height: 4), // เว้นระยะ
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.info_outline,
                                              size: 16,
                                              color: Colors.redAccent,
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text:
                                                          "เหตุผลที่ไม่อนุมัติ: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: item['note2'] ?? "",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      "ไม่มีข้อมูลของเดือนที่เลือก",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                );
        })
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
