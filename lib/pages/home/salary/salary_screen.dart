import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

final SalaryController salaryController = Get.put(SalaryController());
String reason = '';
int selectedIndex = 2;
final box = GetStorage();

List listYear = [
  '2023',
  '2024',
  '2025',
  '2026',
];

List listMonth = [
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
  'ธันวาคม',
];

List abbrelistMonth = [
  'ม.ค.',
  'ก.พ.',
  'มี.ค.',
  'เม.ย',
  'พ.ค.',
  'มิ.ย.',
  'ก.ค.',
  'ส.ค.',
  'ก.ย.',
  'ต.ค.',
  'พ.ย.',
  'ธ.ค.',
];

class SalaryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SalaryScreenState();
  }
}

class _SalaryScreenState extends State<SalaryScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SegmentedTabControl(
                radius: const Radius.circular(0),
                backgroundColor: Colors.grey.shade500,
                indicatorColor: Color.fromARGB(255, 19, 110, 104),
                tabTextColor: Colors.white,
                selectedTabTextColor: Colors.white,
                squeezeIntensity: 2,
                height: 55,
                tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                textStyle: Theme.of(context).textTheme.bodyLarge,
                tabs: [
                  SegmentTab(label: 'เงินเดือน'),
                  SegmentTab(label: 'ขอสลิป'),
                ],
              ),
            ),
            // Sample pages
            Container(
              padding: EdgeInsets.only(top: 55),
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SlipView(),
                  SlipRequest(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
      selectedIndex = index;
    });
  }
}

class SlipView extends StatefulWidget {
  const SlipView({super.key});

  @override
  State<SlipView> createState() => _SlipViewState();
}

class _SlipViewState extends State<SlipView> {
  late bool screenMode;

  int sendMonth = 0;
  String textMonth = 'เดือน';
  String sendYear = 'ปี';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          // color: AppTheme.ognSoftGreen,
          shape: RoundedRectangleBorder(
            // side: BorderSide(
            //   color: Colors.greenAccent,
            // ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          margin: EdgeInsets.all(0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    salaryController.monthName.value == 'เดือน' &&
                            salaryController.yearName.value == 'ปี'
                        ? 'กรุณาเลือกเดือนและปี'
                        : '${salaryController.monthName.value} ${salaryController.yearName.value}',
                    style: TextStyle(
                        // color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        barrierLabel: '12',
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    // child: Text('เลือกเดือน/ปี'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // boxShadow: <BoxShadow>[
                                              //   BoxShadow(
                                              //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                                              // ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 10),
                                              child: DropdownButton<String>(
                                                // value: salaryController
                                                //     .monthName.value,
                                                value: salaryController
                                                    .ddMonthName.value,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    enabled: false,
                                                    value: 'เดือน',
                                                    child: Text(
                                                      'เดือน',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                  for (final month in listMonth)
                                                    DropdownMenuItem<String>(
                                                      value: month,
                                                      child: Text(
                                                        month,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                ],
                                                onChanged: (String? value) {
                                                  if (value != null) {
                                                    int selectedIndex =
                                                        listMonth.indexOf(
                                                                value) +
                                                            1;
                                                    textMonth = value;
                                                    sendMonth = selectedIndex;

                                                    salaryController
                                                        .getMonthName(
                                                            textMonth);

                                                    // Get.back();
                                                  }
                                                },
                                                icon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                iconEnabledColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                dropdownColor: Colors.white,
                                                underline: Container(),
                                                isExpanded: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Obx(
                                          () => DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // boxShadow: <BoxShadow>[
                                              //   BoxShadow(
                                              //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                                              // ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 10),
                                              child: DropdownButton<String>(
                                                // value: salaryController
                                                //     .yearName.value,
                                                value: salaryController
                                                    .ddYearName.value,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    enabled: false,
                                                    value: 'ปี',
                                                    child: Text(
                                                      'ปี',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                  for (final year in listYear)
                                                    DropdownMenuItem<String>(
                                                      value: year,
                                                      child: Text(
                                                        year,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                ],
                                                onChanged: (String? value) {
                                                  if (value != null) {
                                                    sendYear = value;

                                                    salaryController
                                                        .getYear(sendYear);
                                                    // Get.back();
                                                  }
                                                },
                                                icon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                iconEnabledColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                dropdownColor: Colors.white,
                                                underline: Container(),
                                                isExpanded: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // !isButtonPressed
                                //     ? Container()
                                //     : sendMonth == 0 && sendYear == 'ปี'
                                Obx(() {
                                  return Column(
                                    children: [
                                      (salaryController.ddMonthName.value !=
                                                      'เดือน' &&
                                                  salaryController
                                                          .ddYearName.value ==
                                                      'ปี') ||
                                              (salaryController
                                                          .ddMonthName.value ==
                                                      'เดือน' &&
                                                  salaryController
                                                          .ddYearName.value !=
                                                      'ปี')
                                          ? Center(
                                              child: Text(
                                                'กรุณาเลือกข้อมูลให้ครบ',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  );
                                }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      child: const Text('ปิด'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      child: const Text('ตกลง'),
                                      onPressed: () {
                                        if (sendMonth != 0 &&
                                            sendYear != 'ปี') {
                                          salaryController.loadData(
                                              textMonth, sendMonth, sendYear);
                                          Get.back();
                                        } else {
                                          print('0000000000000');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('เลือกเดือน/ปี'))
              ],
            ),
          ),
        ),
        // SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: screenMode ? _buildSlipTablet(context) : _buildSlip(context),
        ),
      ],
    );
  }

  Widget _buildSlip(context) {
    // salaryController.loadData(month);

    return Obx(() {
      if (salaryController.salaryList.isNotEmpty) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            children: salaryController.salaryList.map((item) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          "https://organicscosme.com/image/bg_head/organics.png",
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${box.read('company_name_en')}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "${box.read('company_name_th')}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${box.read('f_name')} ${box.read('l_name')}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text("รหัสพนักงาน : ${box.read('employee_code')}"),
                    Text("ตำแหน่ง : ${box.read('department_name_th')}"),
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "เงินเดือนประจำเดือน ${item.salaryMonth} ${item.yearValue}",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "รายการเงินเดือน (Earnings)",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // รายการเงินเดือน
                    _buildEarningItem("เงินเดือนค่าจ้าง", item.salary ?? 0),
                    _buildEarningItem("เบี้ยขยัน", item.da ?? 0),
                    _buildEarningItem("ค่าล่วงเวลา", item.ot ?? 0),
                    _buildEarningItem("ค่าน้ำมัน", item.fc ?? 0),
                    _buildEarningItem("โบนัส", item.bonus ?? 0),
                    _buildEarningItem("ดอกเบี้ย", item.interest ?? 0),
                    _buildEarningItem("ค่าคอมมิชชั่น", item.oi ?? 0),
                    _buildEarningItem("เงินได้อื่นๆ", item.pm ?? 0),
                    _buildEarningItem("รวมเงินได้", item.ti ?? 0, bold: true),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "รายการเงินหัก (Deductions)",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // รายการหัก
                    _buildDeductionItem("ประกันสังคม", item.ss ?? 0),
                    _buildDeductionItem("ภาษี", item.tax ?? 0),
                    _buildDeductionItem("เงินประกัน", item.dp ?? 0),
                    _buildDeductionItem("ขาด/ลา/มาสาย", item.agl ?? 0),
                    _buildDeductionItem("เงินกู้ยืม", item.loan ?? 0),
                    _buildDeductionItem("กองทุนเงินฝาก", item.df ?? 0),
                    _buildDeductionItem("รายการหักอื่นๆ", item.od ?? 0),
                    _buildDeductionItem("รวมรายการหัก", item.td ?? 0,
                        bold: true),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("รวมเป็นเงิน",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(numberToStringCurrency(item.total),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ไม่มีข้อมูล",
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      }
    });
  }

  Widget _buildSlipTablet(context) {
    // salaryController.loadData(month);

    return Obx(() {
      if (salaryController.salaryList.isNotEmpty) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            children: salaryController.salaryList.map((item) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          "https://organicscosme.com/image/bg_head/organics.png",
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Organics Cosme CO.,LTD.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "บริษัท ออกานิกส์ คอสเม่ จำกัด",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${item.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text("รหัสพนักงาน : ${item.customer}"),
                    Text("ตำแหน่ง : ${item.role}"),
                    SizedBox(height: 10),
                    // Center(
                    //   child: Column(
                    //     children: [
                    //       Text(
                    //         "เงินเดือนประจำเดือน ${item['salaryMonth']} ${item['yearValue']}",
                    //         style: TextStyle(
                    //           decoration: TextDecoration.underline,
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // รายการเงินเดือน
                        Expanded(
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "รายการเงินเดือน (Earnings)",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              _buildEarningItem(
                                  "เงินเดือนค่าจ้าง", item.salary ?? 0),
                              _buildEarningItem("เบี้ยขยัน", item.da ?? 0),
                              _buildEarningItem("ค่าล่วงเวลา", item.ot ?? 0),
                              _buildEarningItem("ค่าน้ำมัน", item.fc ?? 0),
                              _buildEarningItem("โบนัส", item.bonus ?? 0),
                              _buildEarningItem("ดอกเบี้ย", item.interest ?? 0),
                              _buildEarningItem(
                                  "เงินประจำตำแหน่ง", item.pm ?? 0),
                              _buildEarningItem("ค่าคอมมิชชั่น", item.oi ?? 0),
                              _buildEarningItem("รวมเงินได้", item.ti ?? 0,
                                  bold: true),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          thickness: 2,
                          width: 30,
                        ),
                        // รายการหัก
                        Expanded(
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "รายการเงินหัก (Deductions)",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              _buildDeductionItem("ประกันสังคม", item.ss ?? 0),
                              _buildDeductionItem("ภาษี", item.tax ?? 0),
                              _buildDeductionItem(
                                  "ขาด/ลา/มาสาย", item.agl ?? 0),
                              _buildDeductionItem("เงินกู้ยืม", item.loan ?? 0),
                              _buildDeductionItem(
                                  "กองทุนเงินฝาก", item.df ?? 0),
                              _buildDeductionItem(
                                  "รายการหักอื่นๆ", item.od ?? 0),
                              _buildDeductionItem("รวมรายการหัก", item.td ?? 0,
                                  bold: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("รวมเป็นเงิน",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(numberToStringCurrency(item.total),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ไม่มีข้อมูล",
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      }
    });
  }

  Widget _buildEarningItem(String label, int amount, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : null)),
          Text(numberToStringCurrency(amount),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : null)),
        ],
      ),
    );
  }

  Widget _buildDeductionItem(String label, int amount, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : null)),
          Text(numberToStringCurrency(amount),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : null)),
        ],
      ),
    );
  }

  String numberToStringCurrency(int? amount) {
    String formattedAmount =
        NumberFormat('#,###.##', 'en_US').format(amount ?? 0);
    return "$formattedAmount บาท";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width >= 600;
  }
}

class SlipRequest extends StatefulWidget {
  const SlipRequest({Key? key}) : super(key: key);

  @override
  State<SlipRequest> createState() => _SlipRequestState();
}

class _SlipRequestState extends State<SlipRequest> {
  DateRangePickerController _datePickerController = DateRangePickerController();
  int _stepIndex = 0;
  bool hide = false;
  TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    // leaveHistoryController.dispose();
    salaryController.clear();
    Get.delete<SalaryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'กรุณาแจ้งขอสลิปก่อนวันที่นำไปใช้งาน 1-3 วัน',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Stepper(
            physics: ClampingScrollPhysics(),
            currentStep: _stepIndex,
            onStepCancel: () {
              if (_stepIndex > 0) {
                setState(() {
                  _stepIndex -= 1;
                });
              }
            },
            onStepContinue: () {
              if (_stepIndex == 0) {
                if (salaryController.selectedMonths.isEmpty) {
                  alertEmptyData(
                      'แจ้งเตือน', 'กรุณาเลือกเดือนที่ต้องการขอสลิป');
                } else {
                  setState(() {
                    _stepIndex += 1;
                  });
                }
              } else if (_stepIndex == 1) {
                if (salaryController.inputCause.isEmpty) {
                  alertEmptyData(
                      'แจ้งเตือน', 'กรุณาระบุสาเหตุที่ต้องการขอสลิป');
                } else {
                  setState(() {
                    _stepIndex += 1;
                  });
                }
              } else if (_stepIndex == 2) {
                if (salaryController.usedDate.isEmpty) {
                  alertEmptyData('แจ้งเตือน', 'กรุณาระบุวันที่ต้องการนำไปใช้');
                } else {
                  setState(() {
                    _stepIndex += 1;
                  });
                }
              }
            },
            // onStepTapped: (int index) {
            //   setState(() {
            //     _stepIndex = index;
            //   });
            // },
            steps: <Step>[
              Step(
                title: Text('ระบุเดือนที่ต้องการขอสลิป'),
                content: _buildChoseMonthItem(),
                isActive: _stepIndex == 0 ||
                    salaryController.selectedMonths.isNotEmpty,
                state: salaryController.selectedMonths.isNotEmpty
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: Text('ระบุสาเหตุที่ต้องการนำไปใช้'),
                content: _buildCauseItem(),
                isActive:
                    _stepIndex == 1 || salaryController.inputCause.isNotEmpty,
                state: salaryController.inputCause.isNotEmpty
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: Text('ระบุวันที่ต้องการนำไปใช้'),
                content: _buildUsedDateItem(),
                isActive:
                    _stepIndex == 2 || salaryController.usedDate.isNotEmpty,
                state: salaryController.usedDate.isNotEmpty
                    ? StepState.complete
                    : StepState.indexed,
              ),
              Step(
                title: Text('ตรวจสอบข้อมูล'),
                content: _buildCheckSelectedValues(),
                isActive: _stepIndex == 3,
              ),
            ],
            controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _stepIndex == 0
                        ? Container()
                        : ElevatedButton(
                            onPressed: dtl.onStepCancel,
                            child: Text('ย้อนกลับ'),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    _stepIndex == 3
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.ognGreen,
                                ),
                                onPressed: () {
                                  // salaryController.sendSlipRequest();

                                  salaryController
                                      .sendSlipRequest()
                                      .then((responseBody) {
                                    if (responseBody['statusCode'] == '00') {
                                      salaryController.clear();
                                      // selectedLeave = 'เลือกประเภทการลา';
                                      _reasonController.clear();
                                      setState(() {
                                        _stepIndex = 0;
                                      });

                                      alertEmptyData('แจ้งเตือน',
                                          'บันทึกคำร้องขอสลิปสำเร็จ อยู่ในระหว่างรอการอนุมัติ');
                                    } else {
                                      print('show alert');
                                      alertEmptyData('แจ้งเตือน',
                                          'บันทึกใบลาไม่สำเร็จ ลองใหม่อีกครั้งในภายหลัง');
                                    }
                                  });
                                },
                                child: Text(
                                  'ส่งคำร้อง',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppTheme.ognGreen)),
                            onPressed: dtl.onStepContinue,
                            child: Text(
                              'ต่อไป',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void alertEmptyData(String title, String detail) {
    Get.dialog(
      AlertDialog(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: AppTheme.ognGreen,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Text(detail),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("ตกลง"),
          ),
        ],
      ),
    );
  }

  Widget _buildChoseMonthItem() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: (abbrelistMonth.length / 3).ceil(),
      itemBuilder: (context, rowIndex) {
        int startIndex = rowIndex * 3;
        int endIndex = (rowIndex + 1) * 3;
        if (endIndex > abbrelistMonth.length) {
          endIndex = abbrelistMonth.length;
        }

        return Row(
          children: List.generate(endIndex - startIndex, (colIndex) {
            int index = startIndex + colIndex;

            return Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: index < salaryController.checkedMonths.length
                        ? salaryController.checkedMonths[index]
                        : false,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          salaryController.checkedMonths[index] = value;
                          if (value) {
                            salaryController.selectedMonths.add(index + 1);
                            salaryController.selectedMonths.sort();
                          } else {
                            salaryController.selectedMonths.remove(index + 1);
                          }
                          print(salaryController.selectedMonths);
                        }
                      });
                    },
                  ),
                  Text(
                    abbrelistMonth[index],
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildCauseItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'ระบุสาเหตุที่ต้องการนำไปใช้',
        //   style: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        TextField(
          controller: _reasonController,
          onChanged: (value) {
            salaryController.updateInputCause(value);
          },
          minLines: 3,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: 'เช่น นำไปทำธุรกรรม',
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: AppTheme.ognGreen),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsedDateItem() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Obx(
            //   () => Text(
            //     'ระบุวันที่ต้องการนำไปใช้ : ${salaryController.formatDate}',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Card(
              child: SfDateRangePicker(
                headerHeight: 60,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                ),
                showNavigationArrow: true,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  DateTime selectedDate = args.value;
                  String formattedDate =
                      DateFormat('dd MMMM yyyy', 'th_TH').format(selectedDate);

                  String _selectedDate = args.value.toString();
                  salaryController.selectedUsedDate(
                      _selectedDate, formattedDate);
                },
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                controller: _datePickerController,
                selectionColor: AppTheme.ognGreen,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildCheckSelectedValues() {
    String? formattedDate;
    List<String> monthNames = [];
    String? resultMonthNames;

    for (int index in salaryController.selectedMonths) {
      if (index >= 1 && index <= listMonth.length) {
        monthNames.add(listMonth[index - 1]);
        resultMonthNames = monthNames.join(', ');
      } else {
        monthNames.add('');
      }
    }

    if (salaryController.usedDate.isNotEmpty) {
      String originalDate = "${salaryController.usedDate}";
      DateTime dateTime = DateTime.parse(originalDate);

      formattedDate = DateFormat('dd MMMM yyyy', 'th').format(dateTime);
    }

    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('เดือนที่ขอสลิป : $resultMonthNames'),
          Text('สาเหตุที่นำไปใช้ : ${salaryController.inputCause}'),
          Text('วันที่จะนำไปใช้ : $formattedDate'),
        ],
      ),
    );
  }
}
