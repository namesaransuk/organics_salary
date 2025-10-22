import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/login_controller.dart';
import 'package:organics_salary/theme.dart';

class LoginPage extends StatefulWidget {
  final Function(String? email, String? password)? onSubmitted;

  const LoginPage({this.onSubmitted, super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String empId, password;
  String? empIdError, passwordError;
  Function(String? empId, String? password)? get onSubmitted =>
      widget.onSubmitted;
  final LoginController loginController = Get.put(LoginController());
  bool isPasswordVisible = false;

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
    final box = GetStorage();
    print(box.read('token'));

    return Scaffold(
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.ognSoftGreen,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/img/logo.jpg',
                            width: 140,
                          ),
                        ),
                        SizedBox(height: screenHeight * .02),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'ลงชื่อเข้าใช้',
                              style: TextStyle(
                                color: AppTheme.ognGreen,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ระบบ ',
                                  style: TextStyle(
                                    color: AppTheme.ognGreen,
                                    fontSize: 20,
                                    // color: Colors.black.withOpacity(.6),
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Organics HR',
                                  style: TextStyle(
                                    color: AppTheme.ognOrangeGold,
                                    fontSize: 20,
                                    // color: Colors.black.withOpacity(.6),
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .05),
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
                                  'รหัสพนักงาน',
                                  style: TextStyle(color: AppTheme.ognGreen),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  empId = value;
                                });
                              },
                              onSubmitted: (val) => submit(),
                              style: const TextStyle(
                                  color: AppTheme.ognMdGreen, fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 25),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade300),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * .02),
                        Column(
                          children: [
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
                              obscureText: !isPasswordVisible,
                              onChanged: (value) => setState(() {
                                password = value;
                              }),
                              onSubmitted: (val) => submit(),
                              style: const TextStyle(
                                  color: AppTheme.ognMdGreen, fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 25),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade300),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed('/resetpass');
                                  },
                                  child: const Text(
                                    'ลืมรหัสผ่าน',
                                    style: TextStyle(
                                      color: AppTheme.ognGreen,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppTheme.ognGreen,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Align(
                        //       child: TextButton(
                        //         onPressed: () {
                        //           Get.toNamed('/resetpass');
                        //         },
                        //         child: const Text(
                        //           'ลืมรหัสผ่าน',
                        //           style: TextStyle(
                        //             color: AppTheme.ognGreen,
                        //             decoration: TextDecoration.underline,
                        //             decorationColor: AppTheme.ognGreen,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 1.5,
                        //       height: 20,
                        //       color: AppTheme.ognOrangeGold,
                        //       margin: const EdgeInsets.symmetric(horizontal: 1),
                        //     ),
                        //     Align(
                        //       child: TextButton(
                        //         onPressed: () {
                        //           Get.toNamed('/register');
                        //         },
                        //         child: const Text(
                        //           'สมัครสมาชิก',
                        //           style: TextStyle(
                        //             color: AppTheme.ognGreen,
                        //             decoration: TextDecoration.underline,
                        //             decorationColor: AppTheme.ognGreen,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: screenHeight * .015,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.ognOrangeGold,
                          ),
                          // onPressed: submit,
                          onPressed: () {
                            if (empId.isNotEmpty && password.isNotEmpty) {
                              loginController.login(context, empId, password);
                            } else {
                              alertEmptyData('แจ้งเตือน',
                                  'กรุณากรอกข้อมูลให้ครบถ้วนเพื่อลงชื่อเข้าใช้');
                            }
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
