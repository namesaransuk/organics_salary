import 'package:flutter/material.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/controllers/pin_controller.dart';
import 'package:organics_salary/controllers/token_controller.dart';
import 'package:organics_salary/theme.dart';

class CheckPinToChangePage extends StatefulWidget {
  const CheckPinToChangePage({super.key});

  @override
  State<CheckPinToChangePage> createState() => _CheckPinToChangePageState();
}

class _CheckPinToChangePageState extends State<CheckPinToChangePage> {
  final storedPin = GetStorage().read('pin');
  final storedIdCard = GetStorage().read('id_card');

  final PinController pinController = Get.put(PinController());
  String pin = "";
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.white,
  );

  final LoadingController loadingController = Get.put(LoadingController());
  final TokenController tokenController = Get.put(TokenController());

  List<GlobalKey<_PinCodeFieldState>> pinCodeFieldKeys = List.generate(
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
    if (inputIdCard == storedIdCard) {
      loadingController.dialogLoading();
      await Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed('pinauth');
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
    // auth.isDeviceSupported().then(
    //       (bool isSupported) => setState(() {
    //         _supportState = isSupported;
    //       }),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    print(storedPin);
    print(storedIdCard);

    return Scaffold(
      backgroundColor: AppTheme.ognSmGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "ใส่รหัส PIN เดิม 4 หลัก",
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
                  onTap: () {},
                  // splashColor: Colors.white,
                  splashColor: Colors.transparent,
                  child: const SizedBox(
                    height: 55,
                    width: 40,
                  ),
                ),
                // specialKey: Icon(
                //   Icons.fingerprint,
                //   key: const Key('fingerprint'),
                //   color: pinTheme.keysColor,
                //   size: 50,
                // ),
                // specialKeyOnTap: () {
                //   _authenticate();
                //   print('fingerprint');
                // },
                // specialKey: Text(
                //   'ลืมรหัส PIN',
                //   style: GoogleFonts.notoSansThai(
                //       fontSize: 14, color: Colors.white),
                // ),
                // specialKeyOnTap: () {
                //   showModalBottomSheet<void>(
                //       isScrollControlled: true,
                //       showDragHandle: true,
                //       context: context,
                //       builder: (BuildContext context) {
                //         return Padding(
                //           padding: EdgeInsets.only(
                //               left: 40.0,
                //               right: 40.0,
                //               bottom: MediaQuery.of(context).viewInsets.bottom),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             mainAxisSize: MainAxisSize.min,
                //             children: <Widget>[
                //               const Text(
                //                   'กรอกเลขบัตรประชาชน 13 หลักเพื่อเปลี่ยนรหัส PIN'),
                //               const SizedBox(
                //                 height: 20,
                //               ),
                //               TextField(
                //                 controller: _idCardController,
                //                 keyboardType: TextInputType.number,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     inputIdCard = value;
                //                     print(value);
                //                   });
                //                 },
                //                 decoration: InputDecoration(
                //                   contentPadding: const EdgeInsets.symmetric(
                //                       vertical: 10, horizontal: 16),
                //                   labelText: 'รหัสบัตรประชาชน',
                //                   // errorText: empIdError,
                //                   alignLabelWithHint: true,
                //                   border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10.0),
                //                   ),
                //                   focusedBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10.0),
                //                     borderSide: const BorderSide(
                //                         color: AppTheme.ognGreen),
                //                   ),
                //                   enabledBorder: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(10.0),
                //                     borderSide:
                //                         const BorderSide(color: Colors.grey),
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 5,
                //               ),
                //               SizedBox(
                //                 width: double.infinity,
                //                 child: ElevatedButton(
                //                   onPressed: () {
                //                     checkIdCard();
                //                   },
                //                   style: ElevatedButton.styleFrom(
                //                     backgroundColor: AppTheme.ognGreen,
                //                     foregroundColor: Colors.white,
                //                   ),
                //                   child: const Text('ตรวจสอบ'),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 30,
                //               ),
                //             ],
                //           ),
                //         );
                //       });
                // },
                maxLength: 4,
              ),
              // _supportState ? Text('support') : Text('not support')
              const SizedBox(
                height: 30,
              ),
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
                              bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 25),
                                  labelText: 'รหัสบัตรประชาชน',
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
                                    backgroundColor: AppTheme.ognOrangeGold,
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
                  style: GoogleFonts.kanit(fontSize: 14, color: Colors.white),
                ),
              )
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
      Get.toNamed('/pinauth', arguments: 2);
    } else {
      print('ไม่สำเร็จ: ${result['message']}');
      // Get.offAllNamed('/pinauth-tochange');
      // setState(() {});
      alertEmptyData('แจ้งเตือน', result['message']);
    }

    // if (isPinValid) {
    //   // loadingController.dialogLoading();
    //   if (FirebaseMessagingHandler.pendingNotificationData != null) {
    //     Future.delayed(Duration.zero, () {
    //       FirebaseMessagingHandler.handleNotificationNavigation(
    //         FirebaseMessagingHandler.pendingNotificationData!,
    //       );
    //       FirebaseMessagingHandler.pendingNotificationData = null;
    //     });
    //   }
    //   // await Future.delayed(const Duration(seconds: 1), () {
    //   //   Get.offAllNamed('/');
    //   // });
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         backgroundColor: Colors.white,
    //         title: const Text('แจ้งเตือน'),
    //         content: const Text('PIN ไม่ถูกต้อง โปรดลองใหม่อีกครั้ง'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Get.offNamedUntil('/pin', (route) => false);
    //             },
    //             child: const Text('ตกลง'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  // Future<void> _authenticate() async {
  //   try {
  //     final auth = LocalAuthentication();
  //     bool authenticated = await auth.authenticate(
  //       localizedReason: 'ยืนยันเข้าใช้งาน',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //         biometricOnly: true,
  //       ),
  //     );
  //     print('Test Success : $authenticated');
  //     if (authenticated) {
  //       await Future.delayed(const Duration(seconds: 1), () {
  //         Get.offAllNamed('/');
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }

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
  //       await auth.getAvailableBiometrics();sd

  //   print('List of availableBiometrics : $availableBiometrics);

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
