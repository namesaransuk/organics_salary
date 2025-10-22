import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/provident_fund_controller.dart';
import 'package:organics_salary/pages/provident_fund/extention/employee.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ProvidentFundPage extends StatefulWidget {
  const ProvidentFundPage({super.key});

  @override
  State<ProvidentFundPage> createState() => _ProvidentFundPageState();
}

class _ProvidentFundPageState extends State<ProvidentFundPage> {
  final box = GetStorage();
  final DateRangePickerController _controller = DateRangePickerController();
  final ProvidentFundController providentFundController =
      Get.put(ProvidentFundController());

  late bool screenMode;

  late List<ProvidentFund> employees = <ProvidentFund>[];
  late EmployeeDataSource employeeData;
  // final DataGridController _dataGridController = DataGridController();
  // late String _startDate, _endDate;

  @override
  void initState() {
    employees = getEmployeeData();
    employeeData = EmployeeDataSource(employeeData: getEmployeeData());
    // employeeDataSource = EmployeeDataSource(employeeData: employees);

    final DateTime today = DateTime.now();
    providentFundController.c_startDate.value =
        DateFormat('MMMM yyyy').format(today).toString();
    providentFundController.c_endDate.value = DateFormat('MMMM yyyy')
        .format(today.add(const Duration(days: 0)))
        .toString();
    _controller.selectedRange =
        PickerDateRange(today, today.add(const Duration(days: 0)));

    providentFundController.startMonthYearName.value =
        DateFormat('yyyy-MM').format(today).toString();
    providentFundController.endMonthYearName.value =
        DateFormat('yyyy-MM').format(today).toString();
    providentFundController.loadData();

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime startDate = args.value.startDate;
    DateTime endDate = args.value.endDate ?? args.value.startDate;

    setState(() {
      providentFundController.c_startDate.value =
          DateFormat('MMMM yyyy').format(startDate).toString();
      providentFundController.c_endDate.value =
          DateFormat('MMMM yyyy').format(endDate).toString();

      providentFundController.startMonthYearName.value =
          DateFormat('yyyy-MM').format(startDate).toString();
      providentFundController.endMonthYearName.value =
          DateFormat('yyyy-MM').format(endDate).toString();
    });
  }

  List<ProvidentFund> getEmployeeData() {
    return providentFundController.providentFundList.map((provident) {
      DateTime providentDate =
          DateTime(int.parse(provident.year!), int.parse(provident.month!));
      String formattedMonth =
          DateFormat('MMM').format(providentDate).toString();
      String formattedReserve = NumberFormat.decimalPattern('th_TH')
          .format(int.parse(provident.reserve!));
      String formattedContribution = NumberFormat.decimalPattern('th_TH')
          .format(int.parse(provident.contribution!));
      String formattedTotalMonth = NumberFormat.decimalPattern('th_TH')
          .format(int.parse(provident.totalMonth!));
      String formattedAccumulateBalance = NumberFormat.decimalPattern('th_TH')
          .format(int.parse(provident.accumulateBalance!));
      return ProvidentFund(
        '$formattedMonth ${provident.year}',
        '+ $formattedReserve.00',
        '+ $formattedContribution.00',
        '+ $formattedTotalMonth.00',
        '$formattedAccumulateBalance.00',
      );
    }).toList();
  }

  @override
  void dispose() {
    // leaveHistoryController.dispose();
    // providentFundController.clearHistory();
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
          'กองทุนสำรองเลี้ยงชีพ',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.filePen,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed('report-provident-fund');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'ข้อมูลกองทุนสำรองเลี้ยงชีพ',
                    style: TextStyle(
                      color: AppTheme.ognGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.pin_rounded,
                      color: AppTheme.ognOrangeGold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        'เลขที่กองทุนสำรองเลี้ยงชีพ',
                        style: TextStyle(color: AppTheme.ognGreen),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Obx(
                      () => Text(
                        providentFundController.providentFundList.isNotEmpty
                            ? providentFundController
                                .providentFundList.first.reserveFundNumber
                                .toString()
                            : '-',
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: AppTheme.ognGreen),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.percent_rounded,
                      color: AppTheme.ognOrangeGold,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'อัตราเงินสะสม',
                        style: TextStyle(color: AppTheme.ognGreen),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      '10% ของเงินเดือน',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: AppTheme.ognGreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 10,
            color: Colors.grey[300],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                        // size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'ตั้งแต่${providentFundController.c_startDate.value} - ${providentFundController.c_endDate.value}',
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
                      // size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => providentFundController.providentFundList.isNotEmpty
                ? Expanded(
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: Colors.grey[200],
                        selectionColor: Colors.grey[100],
                        gridLineStrokeWidth: 0.5,
                      ),
                      child: SfDataGrid(
                        // controller: _dataGridController,
                        source:
                            EmployeeDataSource(employeeData: getEmployeeData()),
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
                                'ประจำเดือน',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'reserve',
                            label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'เงินสะสม',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'contribution',
                            label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'เงินสมทบ',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'total_month',
                            label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'รวมเดือนนี้',
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'accumulate_balance',
                            label: Container(
                              padding: const EdgeInsets.all(0.0),
                              alignment: Alignment.center,
                              child: Text(
                                'ยอดสะสม',
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
      ),
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
                                    providentFundController.c_startDate.value,
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
                                    providentFundController.c_endDate.value,
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
                            // print(providentFundController.startMonthYearName);
                            // print(providentFundController.endMonthYearName);
                            providentFundController.loadData();
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
