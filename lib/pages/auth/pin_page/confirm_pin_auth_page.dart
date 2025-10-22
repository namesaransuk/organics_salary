import 'package:flutter/material.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/pin_controller.dart';
import 'package:organics_salary/theme.dart';

class ConfirmPinAuthpage extends StatefulWidget {
  const ConfirmPinAuthpage({super.key});

  @override
  State<ConfirmPinAuthpage> createState() => _ConfirmPinAuthpageState();
}

class _ConfirmPinAuthpageState extends State<ConfirmPinAuthpage> {
  final PinController pinController = Get.put(PinController());

  String pin = "";
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.white,
  );

  final List<GlobalKey<_PinCodeFieldState>> pinCodeFieldKeys = List.generate(
    4,
    (index) => GlobalKey<_PinCodeFieldState>(),
  );
  final TextEditingController _keyboardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RxInt parameter = RxInt(0);

    final argParameter = Get.arguments ?? 0;
    parameter.value = argParameter;
    print(parameter.value);
    return Scaffold(
      backgroundColor: AppTheme.ognSmGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "ยืนยันรหัส PIN",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "ยืนยันรหัส 4 หลักอีกครั้ง",
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
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
                  // print(v);
                  pin = v;
                  setState(() {
                    if (pin.length == 4 && int.tryParse(pin) != null) {
                      pinController.confirmpin(context, pin, parameter.value);
                      print('ใช้ได้');
                    }
                    // else {
                    //   alertEmptyData(context, 'แจ้งเตือน',
                    //       'รหัส PIN ไม่ตรงกันกรุณาลองใหม่อีกครั้ง');
                    // }
                  });
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
                maxLength: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alertEmptyData(BuildContext context, String title, String detail) {
    Get.dialog(
      AlertDialog(
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
      ),
    );
  }
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
