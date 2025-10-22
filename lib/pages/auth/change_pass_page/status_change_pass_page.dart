import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/theme.dart';

class StatusChangePasswordPage extends StatelessWidget {
  const StatusChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt parameter = RxInt(0);

    final argParameter = Get.arguments ?? 0;
    parameter.value = argParameter;

    final isGesture = isGestureNavigation(context);
    return Scaffold(
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
                              'เปลี่ยนรหัสผ่านสำเร็จ',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.ognGreen),
                            ),
                            // const SizedBox(
                            //   height: 7,
                            // ),
                            // const Text(
                            //   'กรุณาเข้าสู่ระบบด้วยรหัสพนักงานและรหัสผ่านใหม่ของคุณ',
                            //   style: TextStyle(color: AppTheme.ognGreen),
                            // ),
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
                              'เปลี่ยนรหัสผ่านไม่สำเร็จ',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.ognGreen),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Text(
                              'กรุณาลองใหม่อีกครั้งในภายหลัง',
                              style: TextStyle(color: AppTheme.ognGreen),
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
            SizedBox(
              height: isGesture ? 12 : 35,
            )
          ],
        ),
      ),
    );
  }

  bool isGestureNavigation(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).viewPadding.bottom;
    return paddingBottom == 0;
  }
}
