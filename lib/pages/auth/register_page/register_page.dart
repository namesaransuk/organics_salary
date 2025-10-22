import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/controllers/login_controller.dart';
import 'package:organics_salary/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final LoginController loginController = Get.put(LoginController());

  List listPrefix = [
    {'pId': 1, 'pName': 'นาย'},
    {'pId': 2, 'pName': 'นาง'},
    {'pId': 3, 'pName': 'นางสาว'},
  ];

  @override
  void dispose() {
    loginController.selectedPrefixName = 'เลือกคำนำหน้า'.obs;
    super.dispose();
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
          'สมัครสมาชิก',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Column(
                  children: [
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
                          'คำนำหน้า',
                          style: TextStyle(color: AppTheme.ognGreen),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => DropdownButtonFormField(
                        validator: (value) {
                          if (value == 'เลือกคำนำหน้า' ||
                              value == null ||
                              value.isEmpty) {
                            return 'เลือกคำนำหน้า';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: Colors.white,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 25),
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
                        borderRadius: BorderRadius.circular(20),
                        hint: Text(
                          'เลือกคำนำหน้า',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 14),
                          ),
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'เลือกคำนำหน้า',
                            enabled: false,
                            child: Text(
                              'เลือกคำนำหน้า',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 14),
                              ),
                            ),
                          ),
                          for (final prefix in listPrefix)
                            DropdownMenuItem<String>(
                              value: '${prefix['pId']} ${prefix['pName']}',
                              child: Text(
                                '${prefix['pName']}',
                                style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                      color: AppTheme.ognMdGreen, fontSize: 14),
                                ),
                              ),
                            ),
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            loginController.selectedPrefixName.value = value;
                          }
                        },
                        value: loginController.selectedPrefixName.value,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey[400],
                          ),
                        ),
                        iconEnabledColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        dropdownColor: Colors.white,
                        // underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.title_rounded,
                          size: 20,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ชื่อ',
                          style: TextStyle(color: AppTheme.ognGreen),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onChanged: (value) =>
                          loginController.firstname.value = value,
                      // onSubmitted: (val) => submit(),
                      style: const TextStyle(
                          color: AppTheme.ognMdGreen, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 25),
                        labelText: 'ใส่ชื่อ',
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
                          Icons.text_fields_rounded,
                          size: 20,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'นามสกุล',
                          style: TextStyle(color: AppTheme.ognGreen),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onChanged: (value) =>
                          loginController.lastname.value = value,
                      // controller: dateInput,
                      // onSubmitted: (val) => submit(),
                      style: const TextStyle(
                          color: AppTheme.ognMdGreen, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 25),
                        labelText: 'ใส่นามสกุล',
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
                // const SizedBox(
                //   height: 15,
                // ),
                const Divider(
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          size: 20,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'อีเมล์ (สำหรับเข้าสู่ระบบ)',
                          style: TextStyle(color: AppTheme.ognGreen),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onChanged: (value) => loginController.email.value = value,
                      // onSubmitted: (val) => submit(),
                      style: const TextStyle(
                          color: AppTheme.ognMdGreen, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 25),
                        labelText: 'ใส่อีเมล์',
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
                          Icons.lock_rounded,
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
                    TextField(
                      obscureText: true,
                      onChanged: (value) =>
                          loginController.password.value = value,
                      // onSubmitted: (val) => submit(),
                      style: const TextStyle(
                          color: AppTheme.ognMdGreen, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 25),
                        labelText: 'ใส่รหัสผ่าน',
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
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ognOrangeGold,
              ),
              // onPressed: submit,
              onPressed: () {
                if (loginController.selectedPrefixName != 'เลือกคำนำหน้า' &&
                    loginController.firstname != '' &&
                    loginController.lastname != '' &&
                    loginController.email != '' &&
                    loginController.password != '') {
                  loginController.register();
                } else {
                  alertEmptyData(
                      'แจ้งเตือน', 'กรุณากรอกข้อมูลให้ครบถ้วนเพื่อสมัครสมาชิก');
                }
              },
              child: const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      'สมัครสมาชิก',
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

  void alertEmptyData(String title, String detail) {
    Get.dialog(
      AlertDialog(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: AppTheme.ognMdGreen,
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
      ),
    );
  }
}
