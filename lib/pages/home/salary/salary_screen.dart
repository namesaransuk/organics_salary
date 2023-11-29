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

class _SalaryScreenState extends State<SalaryScreen> {
  String reason = '';
  final CarouselController _controller = CarouselController();
  final SalaryController salaryController = Get.put(SalaryController());
  int selectedIndex = 2;
  String month = '1';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
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
            height: MediaQuery.of(context).size.height * 0.85,
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                viewSlip(context),
                Center(
                  child: Text('Test'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget viewSlip(context) {
    List<String> listMonth = <String>[
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
    // List<String> listYear = <String>['2566', '2567', '2568', '2569'];
// salaryController.loadData(month),
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                // value:
                //     '${selectTermController.selectedYear.value} ${selectTermController.selectedTerm.value}',
                items: [
                  for (final month in listMonth)
                    DropdownMenuItem<String>(
                      value: '$month',
                      child: Text(
                        '$month',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                ],
                onChanged: (String? value) {
                  if (value != null) {
                    // final selectedValues = value.split(' ');
                    // final selectedYear = selectedValues[0];
                    // final selectedTerm = selectedValues[1];

                    print(value);
                    // selectTermController.selectYear(selectedYear);
                    // selectTermController.selectTerm(selectedTerm);
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
    );
  }

  // return salaryController.dataList.map((item) {

  Widget _buildSlip(context) {
    var item = salaryController.dataList[0];
    return Card(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(30),
      //   border: Border.all(
      //     color: Colors.grey,
      //   ),
      // ),
      // surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                          decoration: TextDecoration.underline, fontSize: 14)),
                  Text("รายการเงินเดือน (Earnings)",
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 14)),
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
              child: Text("รายการเงินหัก (Deductions)",
                  style: TextStyle(
                      decoration: TextDecoration.underline, fontSize: 14)),
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
      ),
    );
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
