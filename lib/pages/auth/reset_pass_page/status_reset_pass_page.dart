import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/theme.dart';

class StatusResetPasswordPage extends StatefulWidget {
  const StatusResetPasswordPage({super.key});

  @override
  State<StatusResetPasswordPage> createState() =>
      _StatusResetPasswordPageState();
}

class _StatusResetPasswordPageState extends State<StatusResetPasswordPage> {
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
          'ลืมรหัสผ่าน',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      'กรุณาเข้าสู่ระบบด้วยรหัสพนักงานและรหัสผ่านใหม่ของคุณ',
                                      style:
                                          TextStyle(color: AppTheme.ognGreen),
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
                                      style:
                                          TextStyle(color: AppTheme.ognGreen),
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
                        Get.offAllNamed('login');
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
