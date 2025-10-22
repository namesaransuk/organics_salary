import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/password_controller.dart';
import 'package:organics_salary/theme.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final box = GetStorage();
  PasswordController passwordController = Get.put(PasswordController());
  final TextEditingController checkPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _checkPassword() {
    String enteredPassword = checkPasswordController.text;

    bool isPasswordCorrect =
        BCrypt.checkpw(enteredPassword, box.read('password'));

    if (isPasswordCorrect) {
      print('รหัสผ่านถูกต้อง');
      Get.toNamed('confirm-changepass');
    } else {
      print('รหัสผ่านไม่ถูกต้อง');
      Get.dialog(
        AlertDialog(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          title: Container(
            color: AppTheme.ognSmGreen,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: const Center(
              child: Text(
                'แจ้งเตือน',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          content: const Text('รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ognSmGreen,
              ),
              child: const Text(
                "ตกลง",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

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
          'เปลี่ยนรหัสผ่าน',
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
          Form(
            key: formKey,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'ยืนยันตัวตน',
                        style: TextStyle(
                          color: AppTheme.ognGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: <Widget>[
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_open_rounded,
                                size: 20,
                                color: AppTheme.ognOrangeGold,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'รหัสผ่านเดิม',
                                style: TextStyle(color: AppTheme.ognGreen),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            // onChanged: (value) => passwordController.old_password.value = value,
                            // onSubmitted: (val) => submit(),
                            controller: checkPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรอกรายละเอียด';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(
                                color: AppTheme.ognMdGreen, fontSize: 14),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 25),
                              labelText: 'กรอกรหัสผ่าน',
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              hintStyle: const TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.ognOrangeGold,
                        ),
                        // onPressed: submit,
                        onPressed: () {
                          // Get.toNamed('confirm-changepass');
                          // passwordController.checkPasswordAfter();
                          if (formKey.currentState?.validate() ?? false) {
                            _checkPassword();
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Center(
                              child: Text(
                                'ถัดไป',
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
          ),
        ],
      ),
    );
  }
}
