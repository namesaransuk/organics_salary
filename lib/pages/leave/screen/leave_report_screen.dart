import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/leave/leave_page.dart';
import 'package:organics_salary/pages/leave/step_request/step_one.dart';
import 'package:organics_salary/pages/leave/step_request/step_three.dart';
import 'package:organics_salary/pages/leave/step_request/step_two.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class LeaveReport extends StatefulWidget {
  const LeaveReport({super.key});

  @override
  State<LeaveReport> createState() => _LeaveReportState();
}

class _LeaveReportState extends State<LeaveReport>
    with TickerProviderStateMixin {
  // final StepperAController controller = StepperAController();
  late final ExampleNotifier notifier = ExampleNotifier();

  final box = GetStorage();
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    // leaveHistoryController.loadFlowLeave();
  }

  // @override
  // void dispose() {
  //   leaveHistoryController.clear();
  //   Get.delete<LeaveHistoryController>();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: leaveHistoryController.loadFlowLeave(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
          );
        } else {
          return Obx(
            () {
              // if (leaveHistoryController.flowLeaveList.isEmpty) {
              //   return Text('data');
              // }

              final list = leaveHistoryController.cHierarchysList;

              if (list.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel,
                      size: 100,
                      color: AppTheme.ognOrangeGold,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'คุณยังไม่มีข้อมูลในแผนผังองค์กร กรุณาติดต่อหัวหน้าของคุณ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ognOrangeGold,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                final headParent = list[0]?['head_parent_hierarchys'];

                if (headParent is List && headParent.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel,
                        size: 100,
                        color: AppTheme.ognOrangeGold,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'คุณไม่ได้อยู่ใต้การดูแลของใครในแผนผังองค์กร',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.ognOrangeGold,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
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
                                  controlsBuilder: (BuildContext context,
                                      ControlsDetails controls) {
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
                                            color:
                                                notifier.currentStep.value > 0
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
                                            color:
                                                notifier.currentStep.value > 1
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
                                            color:
                                                notifier.currentStep.value > 2
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
                          child: Obx(() => IndexedStack(
                                index: notifier.currentStep.value,
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  StepOne(
                                      controller: notifier.controller,
                                      notifier: notifier),
                                  StepTwo(
                                      controller: notifier.controller,
                                      notifier: notifier),
                                  StepThree(
                                      controller: notifier.controller,
                                      notifier: notifier),
                                ],
                              )),
                        ),
                        Obx(
                          () => Row(
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
                                    ? () async {
                                        if (notifier.currentStep.value == 0) {
                                          // เช็คข้อมูลใน Step 1
                                          leaveHistoryController
                                                      .isStepOneCompleted() &&
                                                  leaveHistoryController
                                                          .nextPageTwo.value ==
                                                      true
                                              ? notifier.nextStep()
                                              : null;
                                          // else {
                                          //   alertEmptyData('แจ้งเตือน',
                                          //       'กรุณากรอกข้อมูลให้ครบก่อนดำเนินการต่อ');
                                          // }
                                        } else if (notifier.currentStep.value ==
                                            1) {
                                          if (leaveHistoryController
                                              .isStepTwoCompleted()) {
                                            bool isAvailable =
                                                await leaveHistoryController
                                                    .checkTimeLeave();
                                            if (isAvailable) {
                                              notifier.nextStep();
                                            } else {
                                              alertEmptyData(
                                                'แจ้งเตือน',
                                                'พบวันลางานซ้ำกับคำขอที่ท่านเคยทำ\nกรุณาตรวจสอบอีกครั้ง',
                                                1,
                                              );
                                            }
                                          } else {
                                            alertEmptyData('แจ้งเตือน',
                                                'กรุณากรอกข้อมูลให้ครบก่อนดำเนินการต่อ');
                                          }
                                        } else {}
                                      }
                                    : () {
                                        print('Submit data');
                                        leaveHistoryController.sendData();
                                      },
                                child: notifier.currentStep.value < 2
                                    ? const Text('ถัดไป')
                                    : const Text('ยืนยัน'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                }
              }
            },
          );
        }
      },
    );
  }

  String formatDateTimeShort(String input) {
    try {
      DateTime dateTime = DateTime.parse(input);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} น.';
    } catch (e) {
      return input; // หรือจะ return 'Invalid date' ก็ได้ ถ้า parse ไม่ได้
    }
  }

  void alertEmptyData(String title, String detail, [int mode = 0]) {
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(detail, textAlign: TextAlign.center),
            SizedBox(
              height: 12,
            ),
            mode != 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: leaveHistoryController.checkLeaveList.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidCircle,
                                  color: Colors.grey[700],
                                  size: 4,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${item['leave_detail']?['leavetype']?['holiday_name_type'].toString() ?? 'ลา (ไม่ได้ระบุประเภท)'}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidCircle,
                                  color: Colors.white,
                                  size: 4,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${formatDateTimeShort(item['start_date'])} ถึง ${formatDateTimeShort(item['end_date'])}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : Container(),
          ],
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
      ),
    );
  }
}
