import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/password_controller.dart';
import 'package:organics_salary/theme.dart';

class ConfirmChangePassPage extends StatefulWidget {
  const ConfirmChangePassPage({super.key});

  @override
  State<ConfirmChangePassPage> createState() => _ConfirmChangePassPageState();
}

class _ConfirmChangePassPageState extends State<ConfirmChangePassPage> {
  PasswordController passwordController = Get.put(PasswordController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isGesture = isGestureNavigation(context);
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
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'กำหนดรหัสผ่าน',
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
                        Icons.lock_open_outlined,
                        size: 20,
                        color: AppTheme.ognOrangeGold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'รหัสผ่าน',
                        style: TextStyle(color: AppTheme.ognGreen),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    onChanged: (value) =>
                        passwordController.new_password.value = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรอกรายละเอียด';
                      }
                      return null;
                    },
                    obscureText: true,
                    // onSubmitted: (val) => submit(),
                    style: const TextStyle(
                        color: AppTheme.ognMdGreen, fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 25),
                      labelText: 'รหัสผ่าน',
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
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_open_outlined,
                        size: 20,
                        color: AppTheme.ognOrangeGold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'ยืนยันรหัสผ่านใหม่',
                        style: TextStyle(color: AppTheme.ognGreen),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    onChanged: (value) =>
                        passwordController.confirm_password.value = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรอกรายละเอียด';
                      }
                      return null;
                    },
                    obscureText: true,
                    // onSubmitted: (val) => submit(),
                    style: const TextStyle(
                        color: AppTheme.ognMdGreen, fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 25),
                      labelText: 'ยืนยันรหัสผ่านใหม่',
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
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ognOrangeGold,
                ),
                // onPressed: submit,
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    if (passwordController.new_password.value ==
                        passwordController.confirm_password.value) {
                      passwordController.sendData();
                      Get.back();
                      // Get.toNamed('status-resetpass');
                    } else {
                      print('trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                      showDialog(
                        context: context,
                        builder: (context) {
                          return alertEmptyData('แจ้งเตือน',
                              'รหัสผ่านที่กรอกไม่ตรงกัน กรุณากรอกข้อมูลใหม่อีกครั้ง');
                        },
                      );
                    }
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        'ยืนยันการเปลี่ยนแปลง',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isGestureNavigation(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).viewPadding.bottom;
    return paddingBottom == 0;
  }

  Widget alertEmptyData(String title, String detail) {
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        color: AppTheme.ognGreen,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      content: Text(detail),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("ตกลง"),
        ),
      ],
    );
  }
}
