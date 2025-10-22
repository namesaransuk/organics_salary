import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/stepper_controller.dart';
import 'package:organics_salary/pages/leave/leave_page.dart';
import 'package:organics_salary/theme.dart';
import 'package:image_picker/image_picker.dart';

class StepOne extends StatefulWidget {
  final TextEditingController controller;
  final ExampleNotifier notifier;

  const StepOne({
    super.key,
    required this.controller,
    required this.notifier,
  });

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> with TickerProviderStateMixin {
  final TextEditingController _reasonController = TextEditingController(
      text: '${leaveHistoryController.selectedReasonLeave}');

  int? selectedOption;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media, int mode) async {
    var img = await picker.pickImage(source: media);

    if (img != null) {
      if (mode == 1) {
        leaveHistoryController.selectedImages.add(img);
      } else {
        leaveHistoryController.selectedSubImages.add(img);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectedOption = 1;
    leaveHistoryController.fetchLeaveType();
    leaveHistoryController.loadQuota();
    leaveHistoryController.loadEmpDept();
    leaveHistoryController.loadLeaveTotalUsed();
  }

  // @override
  // void dispose() {
  //   leaveHistoryController.clear();
  //   Get.delete<LeaveHistoryController>();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: leaveHistoryController.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ประเภทการลา',
                    style: TextStyle(
                      color: AppTheme.ognGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Obx(() {
                    final selectedItem =
                        leaveHistoryController.leaveTotalUsedList.firstWhere(
                      (item) =>
                          item['id'] ==
                          leaveHistoryController.selectedLeaveId.value,
                      orElse: () => null,
                    );
                    return leaveHistoryController.selectedLeave.value !=
                            'เลือกประเภทการลา'
                        ? Text(
                            leaveHistoryController.leaveTotalUsedList.isNotEmpty
                                ? '${selectedItem['holiday_name_type'] ?? 0}จำนวน ${selectedItem['limit'] ?? 0} วัน'
                                : '',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: AppTheme.ognOrangeGold,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                        : Container();
                  })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => DropdownButtonFormField(
                  validator: (value) {
                    if (value == 'เลือกประเภทการลา' ||
                        value == null ||
                        value.isEmpty) {
                      return 'เลือกประเภทการลา';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 25),
                    labelText: 'กรอกรายละเอียด',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.grey.shade300),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  hint: Text(
                    'เลือกประเภทการลา',
                    style: GoogleFonts.kanit(
                      textStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'เลือกประเภทการลา',
                      enabled: false,
                      child: Text(
                        'เลือกประเภทการลา',
                        style: GoogleFonts.kanit(
                          textStyle:
                              TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                      ),
                    ),
                    for (final leave in leaveHistoryController.listLeaveType)
                      DropdownMenuItem<String>(
                        value: '${leave['id']} ${leave['holiday_name_type']}',
                        child: Text(
                          '${leave['holiday_name_type']}',
                          style: GoogleFonts.kanit(
                            textStyle: const TextStyle(
                                color: AppTheme.ognMdGreen, fontSize: 14),
                          ),
                        ),
                      ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      leaveHistoryController.setupSubType.clear();

                      dynamic selectedValues = value.split(' ');
                      int leaveId = int.parse(selectedValues[0]);
                      String leaveName = selectedValues[1];

                      leaveHistoryController.selectedLeaveId.value = leaveId;
                      leaveHistoryController.selectedLeaveName.value =
                          leaveName;
                      leaveHistoryController.selectedLeave.value = value;
                      leaveHistoryController.selectedSubType.value = 0;

                      leaveHistoryController.selectedAssigner.value =
                          'เลือกผู้ปฏิบัติงานแทน';

                      leaveHistoryController.selectedReasonLeave.value = '';
                      _reasonController.clear();

                      // leaveHistoryController.leaveQuota.assignAll(leaveHistoryController.listLeaveType.firstWhere(
                      //   (item) => item['id'] == leaveHistoryController.selectedLeaveId.value,
                      //   orElse: () => null,
                      // ));
                      // print(leaveHistoryController.leaveQuota);
                    }
                  },
                  value: leaveHistoryController.selectedLeave.value,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey[400],
                    ),
                  ),
                  iconEnabledColor: Colors.white,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  dropdownColor: Colors.white,
                  // underline: Container(),
                  isExpanded: true,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(() {
                // if (leaveHistoryController.leaveTotalUsedList.isEmpty) {
                //   return CircularProgressIndicator(); // หรือ Widget อื่น ๆ
                // }

                final selectedItem =
                    leaveHistoryController.leaveTotalUsedList.firstWhere(
                  (item) =>
                      item['id'] ==
                      leaveHistoryController.selectedLeaveId.value,
                  orElse: () => null,
                );

                if (selectedItem == null) {
                  return Container();
                }

                // var remainingLeave = calculateRemainingLeave(selectedItem);
                Color textColors;
                Color bgColors;
                Color borderColors;
                if (selectedItem['remaining']?['days'] == 0 &&
                    selectedItem['remaining']?['hours'] == 0 &&
                    selectedItem['remaining']?['minutes'] == 0) {
                  textColors = Colors.red;
                  bgColors = Colors.red.withOpacity(0.1);
                  borderColors = Colors.red.withOpacity(0.2);
                  leaveHistoryController.nextPageTwo.value = false;
                } else {
                  textColors = AppTheme.ognGreen;
                  bgColors = AppTheme.ognGreen.withOpacity(0.1);
                  borderColors = AppTheme.ognGreen.withOpacity(0.2);
                  leaveHistoryController.nextPageTwo.value = true;
                }

                return leaveHistoryController.selectedLeave.value !=
                        'เลือกประเภทการลา'
                    ? Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: bgColors,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: borderColors, width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ใช้ไปแล้ว : ${selectedItem['leaveUsed']?['days']} วัน ${selectedItem['leaveUsed']?['hours']} ชม. ${selectedItem['leaveUsed']?['minutes']} นาที',
                                  style: TextStyle(
                                    color: textColors,
                                  ),
                                ),
                                Text(
                                  'คงเหลือ : ${selectedItem['remaining']?['days']} วัน ${selectedItem['remaining']?['hours']} ชม. ${selectedItem['remaining']?['minutes']} นาที',
                                  style: TextStyle(
                                    color: textColors,
                                  ),
                                ),
                                selectedItem['remaining']?['days'] == 0 &&
                                        selectedItem['remaining']?['hours'] ==
                                            0 &&
                                        selectedItem['remaining']?['minutes'] ==
                                            0
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Text(
                                          'ไม่สามารถลาได้ เนื่องจากวันลาหมด',
                                          style: TextStyle(
                                              color: textColors,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          selectedItem['remaining']?['days'] == 0 &&
                                  selectedItem['remaining']?['hours'] == 0 &&
                                  selectedItem['remaining']?['minutes'] == 0
                              ? Container()
                              : Column(
                                  children: [
                                    Obx(() {
                                      final selectedItem =
                                          leaveHistoryController.listLeaveType
                                              .firstWhere(
                                        (item) =>
                                            item['id'] ==
                                            leaveHistoryController
                                                .selectedLeaveId.value,
                                        orElse: () => null,
                                      );

                                      final subTypes =
                                          selectedItem?['sub_type_leave'] ?? [];

                                      subTypes.sort((a, b) => (b['id'] as int)
                                          .compareTo(a['id'] as int));

                                      return leaveHistoryController
                                                  .selectedLeaveId.value !=
                                              0
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  subTypes.map<Widget>((item) {
                                                return RadioListTile<int>(
                                                  fillColor:
                                                      const WidgetStatePropertyAll(
                                                          AppTheme.ognMdGreen),
                                                  value: item['id'],
                                                  groupValue:
                                                      leaveHistoryController
                                                          .selectedSubType
                                                          .value,
                                                  title: Text(
                                                    item['holiday_name_type'],
                                                    style: const TextStyle(
                                                      color:
                                                          AppTheme.ognMdGreen,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    leaveHistoryController
                                                        .selectedSubType
                                                        .value = value!;
                                                    leaveHistoryController
                                                        .setupSubType
                                                        .clear();
                                                    leaveHistoryController
                                                        .setupSubType
                                                        .add(item);
                                                    // print(value);
                                                    // print('Selected SubType ID: ${leaveHistoryController.selectedSubType.value}');
                                                  },
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 0),
                                                  dense: true,
                                                );
                                              }).toList(),
                                            )
                                          : Container();
                                    }),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Obx(() {
                                      // print(leaveHistoryController.leaveQuota.first.holidayNameType);
                                      // print(leaveHistoryController.listLeaveType);
                                      // print(leaveHistoryController.setupSubType);

                                      return leaveHistoryController
                                                  .selectedSubType.value !=
                                              0
                                          ? Column(
                                              children: [
                                                leaveHistoryController
                                                                .setupSubType
                                                                .first[
                                                            'detail_check'] ==
                                                        1
                                                    ? Column(
                                                        children: [
                                                          TextFormField(
                                                            onChanged: (value) {
                                                              leaveHistoryController
                                                                  .selectedSubDetailLeave
                                                                  .value = value;
                                                            },
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'กรอกรายละเอียด';
                                                              }
                                                              return null;
                                                            },
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: const TextStyle(
                                                                color: AppTheme
                                                                    .ognMdGreen,
                                                                fontSize: 14),
                                                            decoration:
                                                                InputDecoration(
                                                              alignLabelWithHint:
                                                                  true,
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .never,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          14,
                                                                      horizontal:
                                                                          25),
                                                              labelText: leaveHistoryController
                                                                          .setupSubType
                                                                          .first['description'] !=
                                                                      null
                                                                  ? '${leaveHistoryController.setupSubType.first['description']}'
                                                                  : '',
                                                              labelStyle:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              hintStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            25)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            25)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                                leaveHistoryController
                                                                .setupSubType
                                                                .first[
                                                            'file_upload_check'] ==
                                                        1
                                                    ? Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Expanded(
                                                                child: Text(
                                                                  'แนบรูปภาพหลักฐาน/ใบรับรองแพทย์เพิ่มเติม',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              Obx(
                                                                () => leaveHistoryController
                                                                        .selectedSubImages
                                                                        .isEmpty
                                                                    ? Container()
                                                                    : Expanded(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                leaveHistoryController.selectedSubImages.clear();
                                                                              },
                                                                              child: const Text(
                                                                                'ลบ',
                                                                                style: TextStyle(color: AppTheme.ognOrangeGold),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 7,
                                                          ),
                                                          Obx(
                                                            () => leaveHistoryController
                                                                    .selectedSubImages
                                                                    .isEmpty
                                                                ? Column(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          getImage(
                                                                              ImageSource.gallery,
                                                                              2);
                                                                        },
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              150,
                                                                          child:
                                                                              DottedBorder(
                                                                            color:
                                                                                Colors.grey,
                                                                            dashPattern: const [
                                                                              4,
                                                                              2
                                                                            ],
                                                                            borderType:
                                                                                BorderType.RRect,
                                                                            radius:
                                                                                const Radius.circular(12),
                                                                            padding:
                                                                                const EdgeInsets.all(20),
                                                                            // child: image1 != null
                                                                            child:
                                                                                const Center(
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  FaIcon(
                                                                                    FontAwesomeIcons.arrowUpFromBracket,
                                                                                    size: 40,
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    'อัพโหลดรูปภาพ',
                                                                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                                                                  ),
                                                                                  Text(
                                                                                    'ไฟล์ JPG, PNG',
                                                                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        child: Image
                                                                            .file(
                                                                          File(leaveHistoryController
                                                                              .selectedSubImages[0]
                                                                              .path),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                              ],
                                            )
                                          : Container();
                                    }),
                                    Obx(() {
                                      final selectedItem =
                                          leaveHistoryController.listLeaveType
                                              .firstWhere(
                                        (item) =>
                                            item['id'] ==
                                            leaveHistoryController
                                                .selectedLeaveId.value,
                                        orElse: () => null,
                                      );

                                      print(selectedItem);
                                      return Column(
                                        children: [
                                          selectedItem != null &&
                                                  selectedItem[
                                                          'detail_check'] ==
                                                      1
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'ระบุรายละเอียดเพิ่มเติม',
                                                      style: TextStyle(
                                                          color:
                                                              AppTheme.ognGreen,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      onChanged: (value) {
                                                        leaveHistoryController
                                                            .selectedDetailLeave
                                                            .value = value;
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'กรอกรายละเอียด';
                                                        }
                                                        return null;
                                                      },
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                          color: AppTheme
                                                              .ognMdGreen,
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .never,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 14,
                                                                horizontal: 25),
                                                        labelText:
                                                            'กรุณาระบุ (ถ้ามี)',
                                                        labelStyle:
                                                            const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 14),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .shade300),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .shade300),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          selectedItem != null &&
                                                  selectedItem[
                                                          'assign_check'] ==
                                                      1
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'ผู้ปฏิบัติงานแทน',
                                                      style: TextStyle(
                                                          color:
                                                              AppTheme.ognGreen,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    DropdownButtonFormField(
                                                      validator: (value) {
                                                        if (value ==
                                                                'เลือกผู้ปฏิบัติงานแทน' ||
                                                            value == null ||
                                                            value.isEmpty) {
                                                          return 'เลือกผู้ปฏิบัติงานแทน';
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .never,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 14,
                                                                horizontal: 25),
                                                        labelText:
                                                            'กรอกรายละเอียด',
                                                        labelStyle:
                                                            const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 14),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .shade300),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25)),
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .shade300),
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      hint: Text(
                                                        'เลือกผู้ปฏิบัติงานแทน',
                                                        style:
                                                            GoogleFonts.kanit(
                                                          textStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[500],
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      items: [
                                                        DropdownMenuItem<
                                                            String>(
                                                          value:
                                                              'เลือกผู้ปฏิบัติงานแทน',
                                                          enabled: false,
                                                          child: Text(
                                                            'เลือกผู้ปฏิบัติงานแทน',
                                                            style: GoogleFonts
                                                                .kanit(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                        for (final empDept
                                                            in leaveHistoryController
                                                                .listEmpDept)
                                                          DropdownMenuItem<
                                                              String>(
                                                            value:
                                                                '${empDept['id']}',
                                                            child: Text(
                                                              '${empDept['fnames']['multitexts'][0]['name']} ${empDept['lnames']['multitexts'][0]['name']}',
                                                              style: GoogleFonts
                                                                  .kanit(
                                                                textStyle: const TextStyle(
                                                                    color: AppTheme
                                                                        .ognMdGreen,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                      onChanged:
                                                          (String? value) {
                                                        if (value != null) {
                                                          leaveHistoryController
                                                              .selectedAssigner
                                                              .value = value;
                                                        }
                                                      },
                                                      value:
                                                          leaveHistoryController
                                                              .selectedAssigner
                                                              .value,
                                                      icon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      ),
                                                      iconEnabledColor:
                                                          Colors.white,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                      dropdownColor:
                                                          Colors.white,
                                                      // underline: Container(),
                                                      isExpanded: true,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          selectedItem != null &&
                                                  selectedItem[
                                                          'file_upload_check'] ==
                                                      1
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            'แนบรูปภาพเพิ่มเติม (ถ้ามี)',
                                                            style: TextStyle(
                                                                color: AppTheme
                                                                    .ognGreen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Obx(
                                                          () => leaveHistoryController
                                                                  .selectedImages
                                                                  .isEmpty
                                                              ? Container()
                                                              : Expanded(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          leaveHistoryController
                                                                              .selectedImages
                                                                              .clear();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'ลบ',
                                                                          style:
                                                                              TextStyle(color: AppTheme.ognOrangeGold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 7,
                                                    ),
                                                    Obx(
                                                      () =>
                                                          leaveHistoryController
                                                                  .selectedImages
                                                                  .isEmpty
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    getImage(
                                                                        ImageSource
                                                                            .gallery,
                                                                        1);
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 150,
                                                                    child:
                                                                        DottedBorder(
                                                                      color: Colors
                                                                          .grey,
                                                                      dashPattern: const [
                                                                        4,
                                                                        2
                                                                      ],
                                                                      borderType:
                                                                          BorderType
                                                                              .RRect,
                                                                      radius: const Radius
                                                                          .circular(
                                                                          12),
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          20),
                                                                      // child: image1 != null
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            FaIcon(
                                                                              FontAwesomeIcons.arrowUpFromBracket,
                                                                              size: 40,
                                                                              color: Colors.grey,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              'อัพโหลดรูปภาพ',
                                                                              style: TextStyle(fontSize: 12, color: Colors.grey),
                                                                            ),
                                                                            Text(
                                                                              'ไฟล์ JPG, PNG',
                                                                              style: TextStyle(fontSize: 12, color: Colors.grey),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .file(
                                                                    File(leaveHistoryController
                                                                        .selectedImages[
                                                                            0]
                                                                        .path),
                                                                  ),
                                                                ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      );
                                    }),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'ระบุเหตุผลในการลาการลา',
                                          style: TextStyle(
                                              color: AppTheme.ognGreen,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          onChanged: (value) {
                                            leaveHistoryController
                                                .updateInputCause(value);
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'กรอกรายละเอียด';
                                            }
                                            return null;
                                          },
                                          controller: _reasonController,
                                          textAlign: TextAlign.start,
                                          minLines: 4,
                                          maxLines: null,
                                          style: const TextStyle(
                                              color: AppTheme.ognMdGreen,
                                              fontSize: 14),
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            filled: true,
                                            fillColor: Colors.white,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 25),
                                            labelText: 'กรอกรายละเอียด',
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
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade300),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade300),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      )
                    : Container();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> calculateRemainingLeave(Map<String, dynamic> typeData) {
    var detailLeave = leaveHistoryController.workTimeList.first;

    DateTime currentDate = DateTime.now();
    String currentDateFormatted = DateFormat('yyyy-MM-dd').format(currentDate);

    DateTime setStartData = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['am_worktime_start']}");
    DateTime setEndData = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['pm_worktime_end']}");

    DateTime amEnd = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['am_worktime_end']}");
    DateTime pmStart = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['pm_worktime_start']}");

    Duration intervalBreak = pmStart.difference(amEnd);
    int hoursBreak = intervalBreak.inHours;
    int minutesBreak = intervalBreak.inMinutes % 60;

    Duration getDateTimeSetup = setEndData.difference(setStartData);
    int hoursSetup = getDateTimeSetup.inHours;
    int minutesSetup = getDateTimeSetup.inMinutes % 60;

    if ((hoursBreak > 0 || minutesBreak > 0)) {
      hoursSetup -= hoursBreak;
      minutesSetup -= minutesBreak;
    }

    print(minutesSetup);

    int totalUsedDays = typeData['total_used_days'];
    int totalUsedHours = typeData['total_used_hours'];
    int totalUsedMinutes = typeData['total_used_minutes'];

    int additionalHoursFromMinutes = totalUsedMinutes ~/ 60;
    int remainingMinutes = totalUsedMinutes % 60;

    totalUsedHours += additionalHoursFromMinutes;

    int additionalDaysFromHours = totalUsedHours ~/ hoursSetup;
    int remainingHours = totalUsedHours % hoursSetup;

    totalUsedDays += additionalDaysFromHours;

    int balanceDays = int.parse(typeData['amount']) - totalUsedDays;
    int balanceHours = 0 - remainingHours;
    int balanceMinutes = 0 - remainingMinutes;

    if (balanceMinutes < 0) {
      balanceMinutes += 60;
      balanceHours -= 1;
    }

    if (balanceHours < 0) {
      balanceHours += hoursSetup;
      balanceDays -= 1;
    }

    return {
      'Leaveused': {
        'days': totalUsedDays,
        'hours': remainingHours,
        'minutes': remainingMinutes,
        'hoursSetup': hoursSetup,
      },
      'LeaveBalance': {
        'days': balanceDays,
        'hours': balanceHours,
        'minutes': balanceMinutes,
      }
    };
  }
}
