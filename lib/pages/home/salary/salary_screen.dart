import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:organics_salary/theme.dart';

class SalaryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SalaryScreenState();
  }
}

class _SalaryScreenState extends State<SalaryScreen>
    with TickerProviderStateMixin {
  String reason = '';
  final SalaryController salaryController = Get.put(SalaryController());
  int selectedIndex = 2;
  int month = 1;

  List<Map<String, dynamic>> listMonth = [
    {'mId': 1, 'mName': 'มกราคม'},
    {'mId': 2, 'mName': 'กุมภาพันธ์'},
    {'mId': 3, 'mName': 'มีนาคม'},
    {'mId': 4, 'mName': 'เมษายน'},
    {'mId': 5, 'mName': 'พฤษภาคม'},
    {'mId': 6, 'mName': 'มิถุนายน'},
    {'mId': 7, 'mName': 'กรกฎาคม'},
    {'mId': 8, 'mName': 'สิงหาคม'},
    {'mId': 9, 'mName': 'กันยายน'},
    {'mId': 10, 'mName': 'ตุลาคม'},
    {'mId': 11, 'mName': 'พฤศจิกายน'},
    {'mId': 12, 'mName': 'ธันวาคม'},
  ];
  // List<String> listYear = <String>['2566', '2567', '2568', '2569'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                slipview(context),
                slipRequest(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget slipview(context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppTheme.ognGreen, width: 2),
                  borderRadius: BorderRadius.circular(50),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                  // ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: DropdownButton(
                    // value: salaryController.monthName != null
                    //     ? '${salaryController.monthName}'
                    //     : null,
                    items: [
                      for (final month in listMonth)
                        DropdownMenuItem<String>(
                          value: '${month['mId']} ${month['mName']}',
                          child: Text(
                            '${month['mName']}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                    ],
                    onChanged: (String? value) {
                      if (value != null) {
                        dynamic selectedValues = value.split(' ');
                        int selectedMonth = int.parse(selectedValues[0]);
                        String selectedMonthName = selectedValues[1];

                        salaryController.loadData(selectedMonth);
                        salaryController.getMonthName(selectedMonthName);
                        print(selectedMonth);
                      }
                    },
                    icon: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        )),
                    iconEnabledColor: Colors.white,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    dropdownColor: Colors.white,
                    underline: Container(),
                    isExpanded: true,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildSlip(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget slipRequest(context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'กรุณาแจ้งขอสลิปก่อนวันที่นำไปใช้งาน 1-3 วัน',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                child: Text('ระบุเดือน'),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSlip(context) {
    salaryController.loadData(month);

    return Obx(() {
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
          children: salaryController.dataList.map((item) {
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
                    '${item['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text("รหัสพนักงาน : ${item['customer']}"),
                  Text("ตำแหน่ง : ${item['role']}"),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "เงินเดือนประจำเดือน ${item['salaryMonth']} ${item['yearValue']}",
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
                  _buildEarningItem("เงินเดือนค่าจ้าง", item['salary']),
                  _buildEarningItem("เบี้ยขยัน", item['da']),
                  _buildEarningItem("ค่าล่วงเวลา", item['ot']),
                  _buildEarningItem("ค่าน้ำมัน", item['fc']),
                  _buildEarningItem("โบนัส", item['bonus']),
                  _buildEarningItem("ดอกเบี้ย", item['interest']),
                  _buildEarningItem("เงินประจำตำแหน่ง", item['pm']),
                  _buildEarningItem("ค่าคอมมิชชั่น", item['oi']),
                  _buildEarningItem("รวมเงินได้", item['ti'], bold: true),
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
                  _buildDeductionItem("ประกันสังคม", item['ss']),
                  _buildDeductionItem("ภาษี", item['tax']),
                  _buildDeductionItem("ขาด/ลา/มาสาย", item['agl']),
                  _buildDeductionItem("เงินกู้ยืม", item['loan']),
                  _buildDeductionItem("กองทุนเงินฝาก", item['df']),
                  _buildDeductionItem("รายการหักอื่นๆ", item['od']),
                  _buildDeductionItem("รวมรายการหัก", item['td'], bold: true),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("รวมเป็นเงิน",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(numberToStringCurrency(item['total']),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
      selectedIndex = index;
    });
  }

  Widget _buildEarningItem(String label, int amount, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
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
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
          Text(numberToStringCurrency(amount),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : null)),
        ],
      ),
    );
  }

  String numberToStringCurrency(int amount) {
    // int value = amount.value;
    String formattedAmount = NumberFormat('#,###.##', 'en_US').format(amount);
    return formattedAmount != null ? "$formattedAmount บาท" : "0 บาท";
  }
}
