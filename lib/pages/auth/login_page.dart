import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/pages/auth/extention.dart';
import 'package:organics_salary/theme.dart';

class LoginPage extends StatefulWidget {
  final Function(String? email, String? password)? onSubmitted;

  const LoginPage({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String empId, password;
  String? empIdError, passwordError;
  Function(String? empId, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    empId = '';
    password = '';

    empIdError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      empIdError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp empIdExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (empId.isEmpty || !empIdExp.hasMatch(empId)) {
      setState(() {
        empIdError = 'รหัสพนักงานไม่ถูกต้อง';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'กรุณาใส่รหัสผ่าน';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(empId, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ลงชื่อเข้าใช้',
                      style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ระบบ Organics HR',
                      style: TextStyle(
                        fontSize: 20,
                        // color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'img/organics_legendary.png',
                  width: 170,
                ),
              ],
            ),
            SizedBox(height: screenHeight * .05),
            InputField(
              onChanged: (value) {
                setState(() {
                  empId = value;
                });
              },
              labelText: 'รหัสพนักงาน',
              errorText: empIdError,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              onSubmitted: (val) => submit(),
              labelText: 'รหัสผ่าน',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'ลืมรหัสผ่าน?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .05,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ognGreen,
              ),
              // onPressed: submit,
              onPressed: () {
                Get.toNamed('home');
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
            // SizedBox(
            //   height: screenHeight * .15,
            // ),
            // TextButton(
            //   onPressed: () {
            //     Get.toNamed('/register');
            //   },
            //   // onPressed: () => Navigator.push(
            //   //   context,
            //   //   MaterialPageRoute(
            //   //     builder: (_) => const RegisterPage(),
            //   //   ),
            //   // ),
            //   child: RichText(
            //     text: const TextSpan(
            //       text: "ไม่มีบัญชีพนักงาน, ",
            //       style: TextStyle(color: Colors.black),
            //       children: [
            //         TextSpan(
            //           text: 'ลงทะเบียน',
            //           style: TextStyle(
            //             color: Colors.blue,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
