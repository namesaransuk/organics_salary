import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/social_security_controller.dart';
import 'package:organics_salary/theme.dart';

class RequestSocialSecurityPage extends StatefulWidget {
  const RequestSocialSecurityPage({super.key});

  @override
  State<RequestSocialSecurityPage> createState() =>
      _RequestSocialSecurityPageState();
}

class _RequestSocialSecurityPageState extends State<RequestSocialSecurityPage> {
  final SocialSecurityController socialSecurityController =
      Get.put(SocialSecurityController());
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;

  @override
  void dispose() {
    Get.delete<SocialSecurityController>();
    super.dispose();
  }

  final ImagePicker picker = ImagePicker();
  Future pickFileOrImage() async {
    final result = await showModalBottomSheet<int>(
      showDragHandle: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 32),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.image, color: AppTheme.ognOrangeGold),
                title: const Text('เลือกภาพ'),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf,
                    color: AppTheme.ognOrangeGold),
                title: const Text('เลือกไฟล์ (PDF)'),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (result == 1) {
      // เลือกภาพ
      var img = await picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        socialSecurityController.selectedFiles.add({
          'type': 'image',
          'file': img,
        });
      }
    } else if (result == 2) {
      // เลือก PDF
      FilePickerResult? pdfResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['pdf'],
        withData: true,
      );
      if (pdfResult != null && pdfResult.files.isNotEmpty) {
        final fileSize = pdfResult.files.first.size;
        const maxFileSize = 10 * 1024 * 1024;

        if (fileSize > maxFileSize) {
          alertEmptyData(
              'ไฟล์เกินขนาด', 'กรุณาเลือกไฟล์ PDF ที่มีขนาดไม่เกิน 10 MB');

          // Get.snackbar(
          //   'ไฟล์เกินขนาด',
          //   'กรุณาเลือกไฟล์ PDF ที่มีขนาดไม่เกิน 10 MB',
          //   snackPosition: SnackPosition.BOTTOM,
          //   backgroundColor: Colors.red,
          //   colorText: Colors.white,
          // );
        } else {
          socialSecurityController.selectedFiles.add({
            'type': 'pdf',
            'file': pdfResult.files.first,
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    socialSecurityController.fetchSocialSecurity();
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
          'ยื่นสิทธิ์ประกันสังคม',
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
          child: Form(
            key: _formKey,
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
                                      'ประเภทสิทธิ์ประกันสังคม',
                                      style:
                                          TextStyle(color: AppTheme.ognMdGreen),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Obx(() {
                                  return DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'เลือกประเภท' ||
                                          value == null ||
                                          value.isEmpty) {
                                        return 'เลือกประเภท';
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
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: 'เลือกประเภท',
                                        enabled: false,
                                        child: Text(
                                          'เลือกประเภท',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      for (final socialSecurity
                                          in socialSecurityController
                                              .listSocialSecurity)
                                        DropdownMenuItem<String>(
                                          value: '${socialSecurity['id']}',
                                          child: Text(
                                            '${socialSecurity['name']}',
                                            overflow: TextOverflow.ellipsis,
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
                                        List listSS = socialSecurityController
                                                .listSubSocialSecurity.value =
                                            socialSecurityController
                                                .listSocialSecurity
                                                .where((item) =>
                                                    item['id'] ==
                                                    int.parse(value))
                                                .toList();

                                        socialSecurityController
                                            .selectedSocialSecurityId
                                            .value = value;
                                        socialSecurityController
                                            .selectedSocialSecurityText
                                            .value = listSS.first['name'];
                                      }
                                    },
                                    value: socialSecurityController
                                        .selectedSocialSecurityId.value,
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
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                      'เลขบัตรประชาชน 13 หลัก',
                                      style:
                                          TextStyle(color: AppTheme.ognMdGreen),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    socialSecurityController
                                        .selectedSocialSecurityIdCard
                                        .value = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรอกรายละเอียด';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  maxLength: 13,
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
                                    labelText: 'กรุณาระบุรหัสผ่าน',
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
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                      'รหัสในการเข้าระบบของผู้ประกันตน',
                                      style:
                                          TextStyle(color: AppTheme.ognMdGreen),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    socialSecurityController
                                        .selectedSocialSecurityPasswordSSO
                                        .value = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรอกรายละเอียด';
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      _isObscured, // ใช้สำหรับซ่อนข้อความ
                                  textAlign: TextAlign.start,
                                  maxLines: 1, // จำกัดให้มีเพียง 1 บรรทัด
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
                                    labelText: 'กรุณาระบุรหัสผ่าน',
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
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscured = !_isObscured;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidFileLines,
                                  size: 16,
                                  color: AppTheme.ognOrangeGold,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  child: Text(
                                    'แนบเอกสาร (หากมี)',
                                    style:
                                        TextStyle(color: AppTheme.ognMdGreen),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Obx(
                              () => socialSecurityController
                                      .selectedFiles.isEmpty
                                  ? InkWell(
                                      onTap: () {
                                        pickFileOrImage();
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 150,
                                        child: DottedBorder(
                                            color: Colors.grey,
                                            dashPattern: const [4, 2],
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(12),
                                            padding: const EdgeInsets.all(20),
                                            // child: image1 != null
                                            child: const Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    'ไฟล์ JPG, PNG หรือ PDF',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: DottedBorder(
                                            color: Colors.grey,
                                            dashPattern: const [4, 2],
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(12),
                                            padding: const EdgeInsets.all(12),
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const RangeMaintainingScrollPhysics(),
                                              padding: const EdgeInsets.all(0),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5.0,
                                                mainAxisSpacing: 5.0,
                                              ),
                                              itemCount: socialSecurityController
                                                      .selectedFiles.length +
                                                  1, // เพิ่ม 1 เพื่อใส่เครื่องหมาย "+"
                                              itemBuilder: (context, index) {
                                                if (index <
                                                    socialSecurityController
                                                        .selectedFiles.length) {
                                                  final fileData =
                                                      socialSecurityController
                                                          .selectedFiles[index];
                                                  if (fileData['type'] ==
                                                      'image') {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.file(
                                                        File((fileData['file']
                                                                as XFile)
                                                            .path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  } else {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        pickFileOrImage();
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .picture_as_pdf,
                                                              color: Colors.red,
                                                              size: 40,
                                                            ),
                                                            Text(
                                                              (fileData['file']
                                                                      as PlatformFile)
                                                                  .name,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      pickFileOrImage();
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.grey[600],
                                                        size: 40,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
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
                    if (_formKey.currentState?.validate() ?? false) {
                      socialSecurityController.sendData();
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
