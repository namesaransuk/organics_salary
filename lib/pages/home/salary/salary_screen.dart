import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final List<String> slipList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: _buildImageSliders(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.83,
              initialPage: 2,
              enlargeCenterPage: true,
              onPageChanged: onPageChange,
            ),
            carouselController: _controller,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: ElevatedButton(
                  onPressed: () => _controller.previousPage(),
                  child: Text('←'),
                ),
              ),
              ...Iterable<int>.generate(slipList.length).map(
                (int pageIndex) => Flexible(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        // backgroundColor: pageIndex,
                        ),
                    onPressed: () {
                      _controller.animateToPage(pageIndex);
                      // salaryController.loadData();
                    },
                    child: Text("$pageIndex"),
                  ),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    _controller.nextPage();
                  },
                  child: Text('→'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildImageSliders() {
    salaryController.loadData();

    return salaryController.dataList
        .map(
          (item) => Card(
            surfaceTintColor: Colors.white,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            "https://organicscosme.com/image/bg_head/organics.png",
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
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
                      _buildDeductionItem("รวมรายการหัก", item['td'],
                          bold: true),
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
              ],
            ),
          ),
        )
        .toList();
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
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
