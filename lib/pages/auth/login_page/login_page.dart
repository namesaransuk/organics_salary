import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/login_controller.dart';
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
  final LoginController loginController = Get.put(LoginController());

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: screenHeight * .05),
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
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ระบบ Organics HR',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/img/organics_legendary.png',
                  width: 145,
                ),
              ],
            ),
            SizedBox(height: screenHeight * .05),
            TextField(
              onChanged: (value) {
                setState(() {
                  empId = value;
                });
              },
              onSubmitted: (val) => submit(),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                labelText: 'รหัสพนักงาน',
                // errorText: empIdError,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppTheme.ognGreen),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: screenHeight * .02),
            TextField(
              obscureText: true,
              onChanged: (value) => setState(() {
                password = value;
              }),
              onSubmitted: (val) => submit(),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                labelText: 'รหัสผ่าน',
                // errorText: passwordError,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppTheme.ognGreen),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
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
                if (empId.isNotEmpty && password.isNotEmpty) {
                  loginController.login(context, empId, password);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alertEmptyData('แจ้งเตือน',
                          'กรุณากรอกข้อมูลให้ครบถ้วนเพื่อลงชื่อเข้าใช้');
                    },
                  );
                }
              },
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
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

  Widget alertEmptyData(String title, String detail) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title),
      content: Text(detail),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("ตกลง"),
        ),
      ],
    );
  }
}
