import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/pages/savings/extention/savings.dart';
import 'package:organics_salary/pages/savings/savings_page.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class SavingsViewScreen extends StatefulWidget {
  const SavingsViewScreen({super.key});

  @override
  State<SavingsViewScreen> createState() => _SavingsViewScreenState();
}

class _SavingsViewScreenState extends State<SavingsViewScreen> {
  final box = GetStorage();
  final DateRangePickerController _controller = DateRangePickerController();

  late bool screenMode;

  late List<Savings> employees = <Savings>[];
  late SavingsDataSource employeeData;
  // final DataGridController _dataGridController = DataGridController();
  // late String _startDate, _endDate;

  @override
  void initState() {
    employees = getEmployeeData();
    employeeData = SavingsDataSource(savingsData: getEmployeeData());
    // employeeDataSource = EmployeeDataSource(employeeData: employees);

    final DateTime today = DateTime.now();
    savingsController.c_startDate.value =
        DateFormat('MMMM yyyy').format(today).toString();
    savingsController.c_endDate.value = DateFormat('MMMM yyyy')
        .format(today.add(const Duration(days: 0)))
        .toString();
    _controller.selectedRange =
        PickerDateRange(today, today.add(const Duration(days: 0)));

    savingsController.startMonthYearName.value =
        DateFormat('yyyy-MM').format(today).toString();
    savingsController.endMonthYearName.value =
        DateFormat('yyyy-MM').format(today).toString();
    savingsController.loadData();

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime startDate = args.value.startDate;
    DateTime endDate = args.value.endDate ?? args.value.startDate;

    setState(() {
      savingsController.c_startDate.value =
          DateFormat('MMMM yyyy').format(startDate).toString();
      savingsController.c_endDate.value =
          DateFormat('MMMM yyyy').format(endDate).toString();

      savingsController.startMonthYearName.value =
          DateFormat('yyyy-MM').format(startDate).toString();
      savingsController.endMonthYearName.value =
          DateFormat('yyyy-MM').format(endDate).toString();
    });
  }

  List<Savings> getEmployeeData() {
    return savingsController.savingsList.map((savings) {
      DateTime savingsDate =
          DateTime(savings.year!.toInt(), savings.month!.toInt());
      String formattedMonth = DateFormat('MMM').format(savingsDate).toString();
      String formattedChannel =
          savings.saveChannel == 1 ? 'หักจากเงินเดือน' : 'อื่นๆ';
      return Savings(
        '$formattedMonth ${savings.year}',
        '+ ${savings.amount}',
        '${savings.saveDate}',
        formattedChannel,
      );
    }).toList();
  }

  @override
  void dispose() {
    // leaveHistoryController.dispose();
    // savingsController.clearHistory();
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
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ตั้งแต่${savingsController.c_startDate.value} - ${savingsController.c_endDate.value}',
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
              ),
            ],
          ),
        ),
        Obx(
          () => savingsController.savingsList.isNotEmpty
              ? Expanded(
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                      headerColor: Colors.grey[200],
                      selectionColor: Colors.grey[100],
                      gridLineStrokeWidth: 0.5,
                    ),
                    child: SfDataGrid(
                      // controller: _dataGridController,
                      source: SavingsDataSource(savingsData: getEmployeeData()),
                      columnWidthMode: ColumnWidthMode.fill,
                      shrinkWrapRows: true,
                      headerGridLinesVisibility: GridLinesVisibility.none,
                      headerRowHeight: 25,
                      rowHeight: 50,
                      columns: <GridColumn>[
                        GridColumn(
                          columnName: 'month',
                          label: Container(
                            padding: const EdgeInsets.all(0.0),
                            alignment: Alignment.center,
                            child: Text(
                              'เดือน',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'netpay',
                          label: Container(
                            padding: const EdgeInsets.all(0.0),
                            alignment: Alignment.center,
                            child: Text(
                              'ยอดเงิน',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'datetime',
                          label: Container(
                            padding: const EdgeInsets.all(0.0),
                            alignment: Alignment.center,
                            child: Text(
                              'วัน - เวลา',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        GridColumn(
                          columnName: 'channel',
                          label: Container(
                            padding: const EdgeInsets.all(0.0),
                            alignment: Alignment.center,
                            child: Text(
                              'ช่องทาง',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 12),
                              ),
                            ),
                          ),
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
                ),
        )
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
                                    'เดือนเริ่มต้น',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    savingsController.c_startDate.value,
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
                                    savingsController.c_endDate.value,
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
                            // print(savingsController.startMonthYearName);
                            // print(savingsController.endMonthYearName);
                            savingsController.loadData();
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
