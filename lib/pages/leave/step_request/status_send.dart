import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/pages/leave/leave_page.dart';
import 'package:organics_salary/theme.dart';

class StepSend extends StatefulWidget {
  const StepSend({super.key});

  @override
  State<StepSend> createState() => _StepSendState();
}

class _StepSendState extends State<StepSend> {
  @override
  void dispose() {
    // leaveHistoryController.dispose();
    // _selectedMonths.clear();asd
    leaveHistoryController.selectedLeaveId = 0.obs;
    leaveHistoryController.selectedImages.clear();
    leaveHistoryController.selectedReasonLeave = ''.obs;
    leaveHistoryController.selectedLeave = 'เลือกประเภทการลา'.obs;
    leaveHistoryController.startDate = ''.obs;
    leaveHistoryController.startTime = ''.obs;
    leaveHistoryController.endDate = ''.obs;
    leaveHistoryController.endTime = ''.obs;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RxInt parameter = RxInt(0);

    final argParameter = Get.arguments ?? 0;
    parameter.value = argParameter;
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
          'การลา',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
              () {
                return parameter.value == 1
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/img/success.png',
                              width: 120,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'บันทึกข้อมูลสำเร็จ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.ognGreen),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              'กรุณารอการตรวจสอบข้อมูล 1-2 วัน',
                              style: TextStyle(color: AppTheme.ognGreen),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/img/failed.png',
                              width: 120,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'บันทึกข้อมูลไม่สำเร็จ',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.ognGreen),
                            ),
                          ],
                        ),
                      );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ognOrangeGold,
              ),
              // onPressed: submit,
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      'ตกลง',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
