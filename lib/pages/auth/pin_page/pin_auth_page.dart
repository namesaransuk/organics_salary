import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/pin_controller.dart';
import 'package:organics_salary/theme.dart';

class PinAuthPage extends StatefulWidget {
  const PinAuthPage({Key? key}) : super(key: key);

  @override
  State<PinAuthPage> createState() => _PinAuthPageState();
}

class _PinAuthPageState extends State<PinAuthPage> {
  final PinController pinController = Get.put(PinController());
  String pin = "";
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.white,
  );
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
                  "ระบุรหัส PIN",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              // const SizedBox(
              //   height: 5,
              // ),
              const Text(
                "กรอกรหัส 4 หลักเพื่อเข้าใช้งานในครั้งต่อไป",
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    PinCodeField(
                      key: Key('pinField$i'),
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
                  if (kDebugMode) {
                    print(v);
                    pin = v;
                    setState(() {
                      if (pin.length == 4 && int.tryParse(pin) != null) {
                        // Get.offAndToNamed('/');
                        pinController.savepin(pin);
                      } else {
                        print('Invalid input');
                      }
                    });
                  }
                },
                specialKey: SizedBox(),
                // specialKeyOnTap: () {
                //   if (kDebugMode) {
                //     print('fingerprint');
                //   }
                // },
                maxLength: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinCodeField extends StatelessWidget {
  const PinCodeField({
    Key? key,
    required this.pin,
    required this.pinCodeFieldIndex,
    required this.theme,
  }) : super(key: key);

  /// The pin code
  final String pin;

  /// The the index of the pin code field
  final PinTheme theme;

  /// The index of the pin code field
  final int pinCodeFieldIndex;

  Color get getFillColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return AppTheme.ognSoftGreen;
    } else if (pin.length == pinCodeFieldIndex) {
      return Colors.white.withOpacity(0.7);
    }
    return Colors.grey.withOpacity(0.7);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: getFillColorFromIndex,
        borderRadius: BorderRadius.circular(7),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: getFillColorFromIndex,
          width: 2,
        ),
      ),
      duration: const Duration(microseconds: 40000),
      child: pin.length > pinCodeFieldIndex
          ? const Icon(
              Icons.circle,
              color: Colors.white,
              size: 12,
            )
          : const SizedBox(),
    );
  }
}
