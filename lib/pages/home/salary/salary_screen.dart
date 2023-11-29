import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

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
    return FutureBuilder(
      future: salaryController.loadData(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Flexible(
                  //   child: ElevatedButton(
                  //     onPressed: () => _controller.previousPage(),
                  //     child: Text('←'),
                  //   ),
                  // ),
                  ...Iterable<int>.generate(salaryController.dataList.length)
                      .map(
                        (int pageIndex) => Flexible(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              // padding: MaterialStateProperty.resolveWith<
                              //     EdgeInsetsGeometry?>(
                              //   (Set<MaterialState> states) {
                              //     return states.contains(MaterialState.pressed)
                              //         ? EdgeInsets.all(16.0)
                              //         : EdgeInsets.all(16.0);
                              //   },
                              // ),
                              backgroundColor: pageIndex == selectedIndex
                                  ? MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 19, 110, 104))
                                  : null,
                            ),
                            onPressed: () {
                              _controller.animateToPage(pageIndex);
                            },
                            child: Text(
                              "${salaryController.dataList[pageIndex]['salaryMonth']}",
                              style: TextStyle(
                                  color: pageIndex == selectedIndex
                                      ? Colors.white
                                      : null),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  // Flexible(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       _controller.nextPage();
                  //     },
                  //     child: Text('→'),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 20),
              CarouselSlider(
                items: _buildSlipSliders(context),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.75,
                  initialPage: 2,
                  enlargeCenterPage: true,
                  onPageChanged: onPageChange,
                ),
                carouselController: _controller,
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildSlipSliders(context) {
    return salaryController.dataList
        .map(
          (item) => Card(
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
                    item['name'],
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
                                fontSize: 14)),
                        Text("รายการเงินเดือน (Earnings)",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14)),
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
                            decoration: TextDecoration.underline,
                            fontSize: 14)),
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
          ),
        )
        .toList();
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
