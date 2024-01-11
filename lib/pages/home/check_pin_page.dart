import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/controllers/pin_controller.dart';
import 'package:organics_salary/theme.dart';

class CheckPinPage extends StatefulWidget {
  const CheckPinPage({Key? key}) : super(key: key);

  @override
  State<CheckPinPage> createState() => _CheckPinPageState();
}

class _CheckPinPageState extends State<CheckPinPage> {
  final box = GetStorage();
  final storedPin = GetStorage().read('pin');
  final storedIdCard = GetStorage().read('id_card');

  final PinController pinController = Get.put(PinController());
  String pin = "";
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.white,
  );

  final LoadingController loadingController = Get.put(LoadingController());
  final List<GlobalKey<_PinCodeFieldState>> pinCodeFieldKeys = List.generate(
    4,
    (index) => GlobalKey<_PinCodeFieldState>(),
  );

  late final LocalAuthentication auth;
  bool _supportState = false;

  bool _supportFingerprint = false;
  bool _supportFaceID = false;

  var inputIdCard;
  var _idCardController = TextEditingController();

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
    return Scaffold(
      backgroundColor: AppTheme.ognGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 35.0,
                  vertical: 10.0,
                ),
                child: Text(
                  "ใส่รหัส PIN",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 40,
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
              const SizedBox(height: 80),
              CustomKeyBoard(
                pinTheme: pinTheme,
                onChanged: (v) {
                  pin = v;
                  setState(() {
                    if (pin.length == 4 && int.tryParse(pin) != null) {
                      if (pin == storedPin) {
                        loadingController.dialogLoading();
                        Future.delayed(const Duration(seconds: 1), () {
                          Get.offAllNamed('/');
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text('แจ้งเตือน'),
                              content:
                                  Text('PIN ไม่ถูกต้อง โปรดลองใหม่อีกครั้ง'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.offNamedUntil('/pin', (route) => false);
                                  },
                                  child: Text('ตกลง'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      print('Invalid input');
                    }
                  });
                },
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
                specialKey: Text(
                  'ลืมรหัส PIN',
                  style: GoogleFonts.notoSansThai(
                      fontSize: 14, color: Colors.white),
                ),
                specialKeyOnTap: () {
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
                              Text(
                                  'กรอกเลขบัตรประชาชน 13 หลักเพื่อเปลี่ยนรหัส PIN'),
                              SizedBox(
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  labelText: 'รหัสบัตรประชาชน',
                                  // errorText: empIdError,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.ognGreen),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    checkIdCard();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.ognGreen,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text('ตรวจสอบ'),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      });
                },
                maxLength: 4,
              ),
              // _supportState ? Text('support') : Text('not support')
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
          actionsAlignment: MainAxisAlignment.center,
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
      },
    );
  }

  Future<void> _authenticate() async {
    try {
      final auth = LocalAuthentication();
      bool authenticated = await auth.authenticate(
        localizedReason: 'ยืนยันเข้าใช้งาน',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      print('Test Success : $authenticated');

      if (authenticated) {
        await Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed('/');
        });
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
    Key? key,
    required this.pin,
    required this.pinCodeFieldIndex,
    required this.theme,
  }) : super(key: key);

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
      height: 50,
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: getFillColorFromIndex(),
        borderRadius: BorderRadius.circular(7),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: getFillColorFromIndex(),
          width: 2,
        ),
      ),
      duration: const Duration(milliseconds: 400),
      child: widget.pin.length > widget.pinCodeFieldIndex
          ? const Icon(
              Icons.circle,
              color: Colors.white,
              size: 12,
            )
          : const SizedBox(),
    );
  }

  Color getFillColorFromIndex() {
    if (widget.pin.length > widget.pinCodeFieldIndex) {
      return AppTheme.ognSoftGreen;
    } else if (widget.pin.length == widget.pinCodeFieldIndex) {
      return Colors.white.withOpacity(0.7);
    }
    return Colors.grey.withOpacity(0.7);
  }

  void updatePin() {
    setState(() {});
  }
}
