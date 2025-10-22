import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/provident_fund_controller.dart';
import 'package:organics_salary/theme.dart';

class ReportProvidentFundPage extends StatelessWidget {
  ReportProvidentFundPage({super.key});

  final ProvidentFundController providentFundController =
      Get.put(ProvidentFundController());
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'กรุณาระบุข้อมูลให้ครบถ้วน',
                      style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.filePen,
                                    size: 18,
                                    color: AppTheme.ognOrangeGold,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'แจ้งความประสงค์ในการถอนเงิน',
                                    style:
                                        TextStyle(color: AppTheme.ognMdGreen),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  providentFundController
                                      .providentFundDetail.value = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรอกรายละเอียด';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.start,
                                minLines: 5,
                                maxLines: null,
                                style: const TextStyle(
                                    color: AppTheme.ognMdGreen, fontSize: 14),
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 25),
                                  labelText: 'กรอกรายละเอียด',
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  hintStyle: const TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey.shade300),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'หมายเหตุ :',
                                  style: TextStyle(
                                      color: AppTheme.ognOrangeGold,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                    child: Text(
                                      '1.',
                                      style: TextStyle(
                                          color: AppTheme.ognOrangeGold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'หากถอนกองทุนสำรองเลี้ยงชีพแล้ว จะไม่สามารถสมทบเงินเพิ่มเติมได้อีกในระยะเวลา 6 เดือน',
                                      style: TextStyle(
                                          color: AppTheme.ognOrangeGold),
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                    child: Text(
                                      '2.',
                                      style: TextStyle(
                                          color: AppTheme.ognOrangeGold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'ยอดเงินที่ถอนจากบัญชีอาจมีการเปลี่ยนแปลง เนื่องจากมีการเสียภาษีและเงื่อนไขของอายุงาน และระยะเวลาที่ทำการหักเบี้ยสำหรับกองทุนทดแทนโดยบริษัทจะแจ้งยอดเงินและรายละเอียดที่ชัดเจนอีกครั้ง',
                                      style: TextStyle(
                                          color: AppTheme.ognOrangeGold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ognOrangeGold,
                ),
                onPressed: () {
                  providentFundController.sendData();
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        'บันทึก',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
