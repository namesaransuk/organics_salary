import 'package:flutter/material.dart';
import 'package:organics_salary/controllers/logout_controller.dart';
import 'package:organics_salary/theme.dart';

class FailedTokenPage extends StatefulWidget {
  const FailedTokenPage({super.key});

  @override
  State<FailedTokenPage> createState() => _FailedTokenPageState();
}

class _FailedTokenPageState extends State<FailedTokenPage> {
  LogoutController logoutController = LogoutController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/warning.png',
                            width: 120,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'เกิดข้อผิดพลาดหรือมีการเข้าใช้งานจากที่อื่น',
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: AppTheme.ognGreen,
                            ),
                          ),
                          const Text(
                            'กรุณาเข้าสู่ระบบใหม่อีกครั้ง',
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: AppTheme.ognGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ognOrangeGold,
                      ),
                      // onPressed: submit,
                      onPressed: () async {
                        logoutController.logout();
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              'เข้าสู่ระบบ',
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
            ),
          ),
        ],
      ),
    );
  }
}
