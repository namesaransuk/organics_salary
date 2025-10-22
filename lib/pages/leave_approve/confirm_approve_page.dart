import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/leave_approve_controller.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class ConfirmApprovePage extends StatefulWidget {
  const ConfirmApprovePage({super.key});

  @override
  State<ConfirmApprovePage> createState() {
    return _ConfirmApprovePageState();
  }
}

class _ConfirmApprovePageState extends State<ConfirmApprovePage>
    with TickerProviderStateMixin {
  final leaveApproveController = Get.find<LeaveApproveController>();

  late bool screenMode;

  @override
  void initState() {
    super.initState();

    print('start ${leaveApproveController.searchStartDate.value}');
    print('end ${leaveApproveController.searchEndDate.value}');
    print('start ${leaveApproveController.c_startDate.value}');
    print('end ${leaveApproveController.c_endDate.value}');
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final item = arguments['item'];
    final mode = arguments['mode'];

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
          'ยืนยันการบันทึกข้อมูล',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/warning.png',
                          width: MediaQuery.of(context).size.width *
                              (screenMode ? 0.10 : 0.25),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'คุณต้องการยืนยันใช่หรือไม่?',
                          style: TextStyle(
                            color: AppTheme.ognGreen,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 35),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(color: AppTheme.ognOrangeGold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ognOrangeGold,
                    ),
                    // onPressed: submit,
                    onPressed: () async {
                      leaveApproveController.sendData(mode, item);
                      // await leaveApproveController.loadData();

                      if (mode == 2) {
                        Get.back();
                      }
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
