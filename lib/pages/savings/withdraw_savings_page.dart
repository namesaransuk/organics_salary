import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organics_salary/pages/savings/savings_page.dart';
import 'package:organics_salary/theme.dart';

class WithdrawSavingsPage extends StatelessWidget {
  const WithdrawSavingsPage({super.key});

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
          'แจ้งถอนเงินออม',
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
                                    FontAwesomeIcons.coins,
                                    size: 18,
                                    color: AppTheme.ognOrangeGold,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'จำนวนเงินที่ต้องการถอน',
                                    style:
                                        TextStyle(color: AppTheme.ognMdGreen),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                onChanged: (value) => savingsController
                                    .savingsAmount.value = value,
                                // onSubmitted: (val) => submit(),
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    color: AppTheme.ognMdGreen, fontSize: 14),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 25),
                                  labelText: 'กรอกจำนวน',
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
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.circleInfo,
                                    size: 18,
                                    color: AppTheme.ognOrangeGold,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'หมายเหตุ',
                                    style:
                                        TextStyle(color: AppTheme.ognMdGreen),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                onChanged: (value) => savingsController
                                    .savingsDetail.value = value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรอกรายละเอียด';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.start,
                                minLines: 4,
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
                  savingsController.sendData();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
