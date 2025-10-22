import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/password_controller.dart';
import 'package:organics_salary/theme.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  PasswordController passwordController = Get.put(PasswordController());
  TextEditingController datePickerController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    passwordController.birthday.value =
        DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                Icons.account_circle_rounded,
                                size: 20,
                                color: AppTheme.ognOrangeGold,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'รหัสพนักงาน',
                                style: TextStyle(color: AppTheme.ognGreen),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                passwordController.empCode.value = value,
                            // onSubmitted: (val) => submit(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรอกรายละเอียด';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: AppTheme.ognMdGreen, fontSize: 14),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 25),
                              labelText: 'รหัสพนักงาน',
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
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: <Widget>[
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cake_rounded,
                                size: 20,
                                color: AppTheme.ognOrangeGold,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'วัน/เดือน/ปีเกิด',
                                style: TextStyle(color: AppTheme.ognGreen),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            readOnly: true, // ป้องกันการพิมพ์
                            controller: datePickerController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรอกรายละเอียด';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: AppTheme.ognMdGreen,
                              fontSize: 14,
                            ),
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                locale: const Locale('th', 'TH'),
                              );

                              if (selectedDate != null) {
                                String formattedDate =
                                    '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
                                datePickerController.text = formattedDate;

                                String selectDate =
                                    '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

                                passwordController.birthday.value = selectDate;
                                print(passwordController.birthday.value);
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 13,
                                horizontal: 25,
                              ),
                              labelText: 'วว/ดด/ปปปป',
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
                          )
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
                                Icons.badge_rounded,
                                size: 20,
                                color: AppTheme.ognOrangeGold,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'เลขประจำตัวประชาชน',
                                style: TextStyle(color: AppTheme.ognGreen),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                passwordController.idCard.value = value,
                            // onSubmitted: (val) => submit(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรอกรายละเอียด';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: AppTheme.ognMdGreen, fontSize: 14),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 25),
                              labelText: 'เลขประจำตัวประชาชน',
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
                          // Get.toNamed('confirm-resetpass');
                          if (formKey.currentState?.validate() ?? false) {
                            passwordController.checkPasswordBefore();
                          }
                          // print(passwordController.empCode);
                          // print(passwordController.birthday);
                          // print(passwordController.idCard);
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
