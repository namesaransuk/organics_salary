import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/salary/salary_page.dart';
import 'package:organics_salary/pages/salary/step_request/step_one.dart';
import 'package:organics_salary/pages/salary/step_request/step_three.dart';
import 'package:organics_salary/pages/salary/step_request/step_two.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class SlipRequest extends StatefulWidget {
  const SlipRequest({super.key});

  @override
  State<SlipRequest> createState() => _SlipRequestState();
}

class _SlipRequestState extends State<SlipRequest> {
  // final StepperAController controller = StepperAController();
  late final ExampleNotifier notifier = ExampleNotifier();
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    salaryController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0.0),
          width: double.infinity,
          height: 120,
          child: Obx(
            () => Theme(
              data: ThemeData(
                textTheme: GoogleFonts.kanitTextTheme(),
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: const MaterialColor(
                    0xFFFA9583,
                    <int, Color>{
                      50: Color(0xFFFA9583),
                      100: Color(0xFFFA9583),
                      200: Color(0xFFFA9583),
                      300: Color(0xFFFA9583),
                      400: Color(0xFFFA9583),
                      500: Color(0xFFFA9583),
                      600: Color(0xFFFA9583),
                      700: Color(0xFFFA9583),
                      800: Color(0xFFFA9583),
                      900: Color(0xFFFA9583),
                    },
                  ),
                  cardColor: Colors.transparent,
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Stepper(
                  margin: const EdgeInsets.all(0.0),
                  physics: const NeverScrollableScrollPhysics(),
                  connectorThickness: 1,
                  elevation: 0,
                  type: StepperType.horizontal,
                  currentStep: notifier.currentStep.value,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    return const Row(
                      children: <Widget>[
                        SizedBox.shrink(),
                      ],
                    );
                  },
                  steps: [
                    Step(
                      title: const SizedBox.shrink(),
                      label: Text(
                        StepState.indexed == StepState.indexed
                            ? 'กรอกข้อมูล'
                            : "",
                        style: TextStyle(
                            fontSize: 12,
                            color: notifier.currentStep.value > 0
                                ? AppTheme.ognOrangeGold
                                : null),
                      ),
                      content:
                          Container(), // ใส่เนื้อหาของแต่ละ step ที่คุณต้องการ
                      isActive: notifier.currentStep.value >= 0,
                      state: notifier.currentStep.value > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const SizedBox.shrink(),
                      label: Text(
                        StepState.indexed == StepState.indexed
                            ? 'เลือกวันรับ'
                            : "",
                        style: TextStyle(
                            fontSize: 12,
                            color: notifier.currentStep.value > 1
                                ? AppTheme.ognOrangeGold
                                : null),
                      ),
                      content: Container(),
                      isActive: notifier.currentStep.value >= 1,
                      state: notifier.currentStep.value > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const SizedBox.shrink(),
                      label: Text(
                        StepState.indexed == StepState.indexed
                            ? 'ตรวจสอบข้อมูล'
                            : "",
                        style: TextStyle(
                            fontSize: 12,
                            color: notifier.currentStep.value > 2
                                ? AppTheme.ognOrangeGold
                                : null),
                      ),
                      content: Container(),
                      isActive: notifier.currentStep.value >= 2,
                      state: notifier.currentStep.value > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(() => Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: IndexedStack(
                  index: notifier.currentStep.value,
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    StepOne(
                        controller: notifier.controller, notifier: notifier),
                    StepTwo(
                        controller: notifier.controller, notifier: notifier),
                    StepThree(
                        controller: notifier.controller, notifier: notifier),
                  ],
                ),
              )),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: notifier.currentStep.value > 0
                      ? notifier.previousStep
                      : null, // ปิดการใช้งานเมื่อเป็น Step 0
                  child: const Text('ก่อนหน้า'),
                ),
                ElevatedButton(
                  onPressed: notifier.currentStep.value < 2
                      ? () {
                          if (notifier.currentStep.value == 0) {
                            // เช็คข้อมูลใน Step 1
                            if (salaryController.isStepOneCompleted()) {
                              notifier.nextStep();
                            } else {
                              alertEmptyData('แจ้งเตือน',
                                  'กรุณากรอกข้อมูลให้ครบก่อนดำเนินการต่อ');
                            }
                          } else if (notifier.currentStep.value == 1) {
                            if (salaryController.isStepTwoCompleted()) {
                              notifier.nextStep();
                            } else {
                              alertEmptyData('แจ้งเตือน',
                                  'กรุณากรอกข้อมูลให้ครบก่อนดำเนินการต่อ');
                            }
                          }
                        }
                      : () {
                          print('Submit data');
                          salaryController.sendSlipRequest();
                        },
                  child: notifier.currentStep.value < 2
                      ? const Text('ถัดไป')
                      : const Text('ยืนยัน'),
                ),
              ],
            ),
          ),
        ),
      ],
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
          color: AppTheme.ognGreen,
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
