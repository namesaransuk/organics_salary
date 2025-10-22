import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

class StatusSuccess extends StatelessWidget {
  const StatusSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: ElevatedButton(
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
