import 'package:flutter/material.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/controllers/logout_controller.dart';
import 'package:organics_salary/controllers/pin_controller.dart';
import 'package:organics_salary/controllers/token_controller.dart';
import 'package:organics_salary/service/firebase_messaging_handler.dart';
import 'package:organics_salary/theme.dart';

class CheckPinPage extends StatefulWidget {
  const CheckPinPage({super.key});

  @override
  State<CheckPinPage> createState() => _CheckPinPageState();
}

class _CheckPinPageState extends State<CheckPinPage> {
  final storedPin = GetStorage().read('pin');
  final storedIdCard = GetStorage().read('idCard');
  final box = GetStorage();

  final PinController pinController = Get.put(PinController());
  String pin = "";
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.white,
  );

  final LoadingController loadingController = Get.put(LoadingController());
  final TokenController tokenController = Get.put(TokenController());
  final LogoutController logoutController = Get.put(LogoutController());

  final List<GlobalKey<_PinCodeFieldState>> pinCodeFieldKeys = List.generate(
    4,
    (index) => GlobalKey<_PinCodeFieldState>(),
  );

  late final LocalAuthentication auth;
  // final bool _supportState = false;

  bool _supportFingerprint = false;
  bool _supportFaceID = false;

  var inputIdCard;
  final _idCardController = TextEditingController();
  final TextEditingController _keyboardController = TextEditingController();

  void checkIdCard() async {
    String formattedIdCard =
        '${inputIdCard[0]}-${inputIdCard.substring(1, 5)}-${inputIdCard.substring(5, 10)}-${inputIdCard.substring(10, 12)}-${inputIdCard[12]}';
    print(storedIdCard);

    if (formattedIdCard == storedIdCard) {
      Get.back();
      loadingController.dialogLoading();
      await Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed('/pinauth', arguments: 2);
      });
    } else {
      alertEmptyData(
          'แจ้งเตือน', 'เลขบัตรประชาชนไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง');
    }
  }

  @override
  void initState() {
    super.initState();

    auth = LocalAuthentication();
    _checkBiometricsSupport();
    _authenticate();
    // auth.isDeviceSupported().then(
    //       (bool isSupported) => setState(() {
    //         _supportState = isSupported;
    //       }),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    // print(storedPin);
    // print(storedIdCard);

    return Scaffold(
      backgroundColor: AppTheme.ognSmGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "ใส่รหัส PIN",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    PinCodeField(
                      key: pinCodeFieldKeys[i],
                      pin: pin,
                      pinCodeFieldIndex: i,
                      theme: pinTheme,
                    ),
                ],
              ),
              const SizedBox(height: 40),
              CustomKeyBoard(
                controller: _keyboardController,
                pinTheme: pinTheme,
                onChanged: (v) {
                  setState(() {
                    pin = v;
                  });

                  if (pin.length == 4 && int.tryParse(pin) != null) {
                    _handlePinCheck(pin);

                    Future.delayed(Duration(milliseconds: 100), () {
                      setState(() {
                        pin = '';
                      });
                    });

                    _keyboardController.clear();
                  } else {
                    print('Invalid input');
                  }
                },
                specialKey: InkWell(
                  onTap: () {
                    if (_supportFaceID || _supportFingerprint) {
                      _authenticate();
                    }
                  },
                  // splashColor: Colors.white,
                  splashColor: Colors.transparent,
                  child: Icon(
                    _supportFaceID
                        ? Symbols.frame_person
                        : _supportFingerprint
                            ? Symbols.fingerprint
                            : null,
                    color: Colors.white,
                    size: 30,
                  ),
                  // child: const SizedBox(
                  //   height: 55,
                  //   width: 40,
                  // ),
                ),
                maxLength: 4,
              ),
              // _supportState ? Text('support') : Text('not support')
              const SizedBox(
                height: 30,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            showDragHandle: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text(
                                      'กรอกเลขบัตรประชาชน 13 หลักเพื่อเปลี่ยนรหัส PIN',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      controller: _idCardController,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          inputIdCard = value;
                                          print(value);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        filled: true,
                                        fillColor: Colors.white,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 14, horizontal: 25),
                                        labelText: 'รหัสบัตรประชาชน',
                                        labelStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        hintStyle:
                                            const TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          checkIdCard();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppTheme.ognOrangeGold,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('ตรวจสอบ'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text(
                        'ลืมรหัส PIN ?',
                        style: GoogleFonts.kanit(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      width: 10,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              clipBehavior: Clip.antiAlias,
                              actionsAlignment: MainAxisAlignment.center,
                              backgroundColor: Colors.white,
                              titlePadding: EdgeInsets.zero,
                              title: Container(
                                color: AppTheme.ognSmGreen,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
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
                              content: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'ต้องการเข้าสู่ระบบใหม่อีกครั้งใช่หรือไม่?'),
                                ],
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ยกเลิก"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // box.erase();
                                    // Get.offAllNamed('/login');
                                    logoutController.logout();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.ognSmGreen,
                                  ),
                                  child: const Text(
                                    "ตกลง",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'เข้าสู่ระบบใหม่',
                        style: GoogleFonts.kanit(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alertEmptyData(String title, String detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          title: Container(
            color: AppTheme.ognSmGreen,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          content: Text(
            detail,
            textAlign: TextAlign.center,
          ),
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
        );
      },
    );
  }

  Future<void> _handlePinCheck(String pin) async {
    // bool isPinValid = BCrypt.checkpw(pin, storedPin);
    var result = await pinController.checkpin(context, pin);

    if (result['success']) {
      print('สำเร็จ: ${result['message']}');
      // loadingController.dialogLoading();
      if (FirebaseMessagingHandler.pendingNotificationData != null) {
        final data = FirebaseMessagingHandler.pendingNotificationData!;
        FirebaseMessagingHandler.pendingNotificationData = null;

        Future.delayed(Duration.zero, () {
          FirebaseMessagingHandler.handleNotificationNavigation(data);
        });
      } else {
        // ไม่มี notification → กลับหน้า home
        Get.offAllNamed('/home');
      }
    } else {
      print('ไม่สำเร็จ: ${result['message']}');
      alertEmptyData('แจ้งเตือน', result['message']);
    }
  }

  Future<void> _authenticate() async {
    try {
      final auth = LocalAuthentication();
      bool authenticated = await auth.authenticate(
        localizedReason: 'ยืนยันเข้าใช้งาน',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      print('Test Success : $authenticated');

      if (authenticated) {
        // await tokenController.checkToken();

        // loadingController.dialogLoading();

        if (FirebaseMessagingHandler.pendingNotificationData != null) {
          final data = FirebaseMessagingHandler.pendingNotificationData!;
          FirebaseMessagingHandler.pendingNotificationData = null;

          Future.delayed(Duration.zero, () {
            FirebaseMessagingHandler.handleNotificationNavigation(data);
          });
        } else {
          // ไม่มี notification → กลับหน้า home
          Get.offAllNamed('/home');
        }

        // await Future.delayed(const Duration(seconds: 1), () {
        // Get.offAllNamed('/');
        // });
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _checkBiometricsSupport() async {
    try {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      setState(() {
        _supportFingerprint =
            availableBiometrics.contains(BiometricType.fingerprint);
        _supportFaceID = availableBiometrics.contains(BiometricType.face);
      });

      print('Support: $availableBiometrics');
      print('Support Fingerprint: $_supportFingerprint');
      print('Support Face ID: $_supportFaceID');
    } on PlatformException catch (e) {
      print('Error checking biometrics support: $e');
    }
  }

  // Future<void> _getAvailableBiometrics() async {
  //   List<BiometricType> availableBiometrics =
  //       await auth.getAvailableBiometrics();

  //   print('List of availableBiometrics : $availableBiometrics');

  //   if (!mounted) {
  //     return;
  //   }
  // }
}

class PinCodeField extends StatefulWidget {
  const PinCodeField({
    super.key,
    required this.pin,
    required this.pinCodeFieldIndex,
    required this.theme,
  });

  final String pin;
  final PinTheme theme;
  final int pinCodeFieldIndex;

  @override
  _PinCodeFieldState createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 40,
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      // decoration: BoxDecoration(
      //   color: getFillColorFromIndex(),
      //   borderRadius: BorderRadius.circular(7),
      //   shape: BoxShape.rectangle,
      //   border: Border.all(
      //     color: getFillColorFromIndex(),
      //     width: 2,
      //   ),
      // ),
      duration: const Duration(milliseconds: 400),
      child: widget.pin.length > widget.pinCodeFieldIndex
          ? Icon(
              Icons.circle,
              color: getFillColorFromIndex(),
              size: 18,
            )
          : const Icon(
              Icons.circle,
              color: Colors.white,
              size: 18,
            ),
    );
  }

  Color getFillColorFromIndex() {
    if (widget.pin.length > widget.pinCodeFieldIndex) {
      return AppTheme.stepperYellow;
    } else if (widget.pin.length == widget.pinCodeFieldIndex) {
      return Colors.white;
    }
    return Colors.white;
  }

  void updatePin() {
    setState(() {});
  }
}
