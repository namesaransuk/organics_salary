import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/honor_controller.dart';
import 'package:organics_salary/theme.dart';

class RequestAddHonorPage extends StatefulWidget {
  const RequestAddHonorPage({super.key});

  @override
  State<RequestAddHonorPage> createState() => _RequestAddHonorPageState();
}

class _RequestAddHonorPageState extends State<RequestAddHonorPage> {
  final HonorController honorController = Get.put(HonorController());
  final _formKey = GlobalKey<FormState>();
  bool _imageError = false;

  @override
  void dispose() {
    Get.delete<HonorController>();
    super.dispose();
  }

  List listHonor = [
    {'hId': 1, 'hName': 'มาตรฐาน'},
    {'hId': 2, 'hName': 'พิเศษ'},
  ];

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      if (img != null) {
        // honorController.selectedImages.value = img;
        honorController.selectedImages.add(img);
        _imageError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          'แจ้งขอเพิ่มเติมข้อมูล',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'กรุณาระบุข้อมูลให้ครบถ้วน',
                      style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.widgets_rounded,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'ประเภทเกียรติประวัติ',
                                      style:
                                          TextStyle(color: AppTheme.ognMdGreen),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Obx(
                                  () => DropdownButtonFormField(
                                    validator: (value) {
                                      if (value ==
                                              'เลือกประเภทเกียรติประวัติ' ||
                                          value == null ||
                                          value.isEmpty) {
                                        return 'เลือกประเภทเกียรติประวัติ';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 25),
                                      labelText: 'กรอกรายละเอียด',
                                      labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      hintStyle: const TextStyle(fontSize: 14),
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
                                    borderRadius: BorderRadius.circular(20),
                                    hint: Text(
                                      'เลือกประเภทเกียรติประวัติ',
                                      style: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 14),
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: 'เลือกประเภทเกียรติประวัติ',
                                        enabled: false,
                                        child: Text(
                                          'เลือกประเภทเกียรติประวัติ',
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      for (final honor in listHonor)
                                        DropdownMenuItem<String>(
                                          value: '${honor['hId']}',
                                          child: Text(
                                            '${honor['hName']}',
                                            style: GoogleFonts.kanit(
                                              textStyle: const TextStyle(
                                                  color: AppTheme.ognMdGreen,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                    ],
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        honorController
                                            .selectedHonorText.value = value;
                                        print(value);
                                      }
                                    },
                                    value:
                                        honorController.selectedHonorText.value,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    dropdownColor: Colors.white,
                                    // underline: Container(),
                                    isExpanded: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.filePen,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'ชื่อ / รายละเอียด',
                                        style: TextStyle(
                                            color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    honorController.selectedDetail.value =
                                        value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรอกรายละเอียด';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.start,
                                  minLines: 4,
                                  maxLines: null,
                                  style: const TextStyle(
                                      color: AppTheme.ognMdGreen, fontSize: 14),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.solidFileLines,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'แนบเอกสารหรือหลักฐาน (จำเป็น)',
                                        style: TextStyle(
                                            color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                    Obx(
                                      () =>
                                          honorController.selectedImages.isEmpty
                                              ? Container()
                                              : Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          honorController
                                                              .selectedImages
                                                              .clear();
                                                        },
                                                        child: const Text(
                                                          'ลบ',
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .ognOrangeGold),
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
                                  () => honorController.selectedImages.isEmpty
                                      ? Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                getImage(ImageSource.gallery);
                                                setState(() {
                                                  _imageError = false;
                                                });
                                              },
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 150,
                                                child: DottedBorder(
                                                  color: _imageError
                                                      ? Colors.red.shade900
                                                      : Colors.grey,
                                                  dashPattern: const [4, 2],
                                                  borderType: BorderType.RRect,
                                                  radius:
                                                      const Radius.circular(12),
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  // child: image1 != null
                                                  child: const Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .arrowUpFromBracket,
                                                          size: 40,
                                                          color: Colors.grey,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'อัพโหลดรูปภาพ',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          'ไฟล์ JPG, PNG',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_imageError)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 24),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'กรุณาเลือกรูปภาพ',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.red.shade900,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                      : Image.file(
                                          File(honorController
                                              .selectedImages[0].path),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ognOrangeGold,
                ),
                onPressed: () {
                  if (honorController.selectedImages.isEmpty) {
                    setState(() {
                      _imageError = true;
                    });
                    return;
                  }

                  if (_formKey.currentState?.validate() ?? false) {
                    honorController.sendData();
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        'บันทึก',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
