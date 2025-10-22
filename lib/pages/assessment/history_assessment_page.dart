import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/assessment_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:stepper_a/stepper_a.dart';

class HistoryAssessmentPage extends StatefulWidget {
  const HistoryAssessmentPage({super.key});

  @override
  State<HistoryAssessmentPage> createState() {
    return _HistoryAssessmentPageState();
  }
}

class _HistoryAssessmentPageState extends State<HistoryAssessmentPage>
    with TickerProviderStateMixin {
  final AssessmentController assessmentController =
      Get.put(AssessmentController());
  final DateRangePickerController _controller = DateRangePickerController();
  late bool screenMode;

  @override
  @override
  void initState() {
    final DateTime today = DateTime.now();
    assessmentController.c_startDate.value = DateFormat('MMMM yyyy')
        .format(today.add(const Duration(days: 0)))
        .replaceFirst(
          '${today.year}',
          '${today.year + 543}',
        )
        .toString();
    assessmentController.c_endDate.value = DateFormat('MMMM yyyy')
        .format(today.add(const Duration(days: 0)))
        .replaceFirst(
          '${today.year}',
          '${today.year + 543}',
        )
        .toString();

    print(assessmentController.c_startDate.value);
    print(assessmentController.c_endDate.value);

    _controller.selectedRange =
        PickerDateRange(today, today.add(const Duration(days: 0)));

    final DateTime firstDayOfMonth = DateTime(today.year, today.month, 1);
    final DateTime lastDayOfMonth = DateTime(today.year, today.month + 1, 0);

    assessmentController.searchStartDate.value = firstDayOfMonth.toString();
    assessmentController.searchEndDate.value = lastDayOfMonth.toString();

    // assessmentController.loadHistoryExchange();

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime startDate = args.value.startDate;
    DateTime endDate = args.value.endDate ?? args.value.startDate;

    print(startDate);
    print(endDate);

    assessmentController.c_startDate.value = DateFormat('MMMM yyyy', 'th')
        .format(startDate)
        .replaceFirst(
          '${startDate.year}',
          '${startDate.year + 543}',
        )
        .toString();

    assessmentController.c_endDate.value = DateFormat('MMMM yyyy', 'th')
        .format(endDate)
        .replaceFirst(
          '${endDate.year}',
          '${endDate.year + 543}',
        )
        .toString();

    if (endDate.isAtSameMomentAs(startDate)) {
      endDate = DateTime(startDate.year, startDate.month + 1, 0);
    }

    assessmentController.searchStartDate.value = startDate.toString();
    assessmentController.searchEndDate.value = endDate.toString();
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
          'ประวัติการประเมิน',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
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
                        'ตั้งแต่ ${assessmentController.c_startDate.value} - ${assessmentController.c_endDate.value}',
                        style: const TextStyle(color: AppTheme.ognGreen),
                      ),
                    ],
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
            Obx(() => assessmentController.historyAssessmentList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          color: AppTheme.ognOrangeGold,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'วันที่ทำแบบประเมิน',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'คะแนนที่ได้',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.05,
                                blurRadius: 2,
                                offset: const Offset(0.5, 0.025),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed('detail-assessment');
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '20/02/2025',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.ognMdGreen,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '30/40',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.ognMdGreen,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/menu/assessment.png',
                          width: MediaQuery.of(context).size.width *
                              (screenMode ? 0.10 : 0.25),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'ไม่มีแบบประเมินในขณะนี้',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
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
                                    assessmentController.c_startDate.value,
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
                                    assessmentController.c_endDate.value,
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
                            // assessmentController.loadData();
                            assessmentController.loadData();
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
}
