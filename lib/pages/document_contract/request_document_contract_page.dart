import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/contract_controller.dart';
import 'package:organics_salary/theme.dart';

class RequestDocumentContractPage extends StatefulWidget {
  const RequestDocumentContractPage({super.key});

  @override
  State<RequestDocumentContractPage> createState() => _RequestDocumentContractPageState();
}

class _RequestDocumentContractPageState extends State<RequestDocumentContractPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    contractController.fetchContract();
  }

  @override
  void dispose() {
    Get.delete<ContractController>();
    super.dispose();
  }

  final ContractController contractController = Get.put(ContractController());

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
                leading: const Icon(Icons.picture_as_pdf, color: AppTheme.ognOrangeGold),
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
        contractController.selectedFiles.add({
          'type': 'image',
          'file': img,
        });
      }
    } else if (result == 2) {
      // เลือก PDF
      FilePickerResult? pdfResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: [
          'pdf'
        ],
        withData: true,
      );
      if (pdfResult != null && pdfResult.files.isNotEmpty) {
        final fileSize = pdfResult.files.first.size;
        const maxFileSize = 10 * 1024 * 1024;

        if (fileSize > maxFileSize) {
          alertEmptyData('ไฟล์เกินขนาด', 'กรุณาเลือกไฟล์ PDF ที่มีขนาดไม่เกิน 10 MB');

          // Get.snackbar(
          //   'ไฟล์เกินขนาด',
          //   'กรุณาเลือกไฟล์ PDF ที่มีขนาดไม่เกิน 10 MB',
          //   snackPosition: SnackPosition.BOTTOM,
          //   backgroundColor: Colors.red,
          //   colorText: Colors.white,
          // );
        } else {
          contractController.selectedFiles.add({
            'type': 'pdf',
            'file': pdfResult.files.first,
          });
        }
      }
    }
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
          'แจ้งเพิ่มเอกสารและสัญญา',
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
                                    FaIcon(
                                      FontAwesomeIcons.solidFileLines,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'สัญญาที่ต้องการเปลี่ยนแปลงข้อมูล',
                                        style: TextStyle(color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Obx(
                                  () => DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'เลือกประเภทสัญญา' || value == null || value.isEmpty) {
                                        return 'เลือกประเภทสัญญา';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
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
                                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: 'เลือกประเภทสัญญา',
                                        enabled: false,
                                        child: Text(
                                          'เลือกประเภทสัญญา',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      for (final contract in contractController.listContract)
                                        DropdownMenuItem<String>(
                                          value: '${contract['id']}',
                                          child: Text(
                                            '${contract['title']}',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.kanit(
                                              textStyle: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                            ),
                                          ),
                                        ),
                                    ],
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        // dynamic selectedValues = value.split(' ');
                                        // String honorId = selectedValues[0];
                                        // String honorName = selectedValues[1];

                                        contractController.selectedContractText.value = value;
                                        // leaveHistoryController.selectedLeaveId.value = leaveId;
                                        // leaveHistoryController.selectedLeaveName.value = leaveName;
                                        // leaveHistoryController.selectedLeave.value = value;

                                        // print(leaveHistoryController.selectedLeaveId.value);
                                        print(value);
                                      }
                                    },
                                    value: contractController.selectedContractText.value,
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
                                      FontAwesomeIcons.solidFile,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'ข้อมูลที่ต้องการเปลี่ยนแปลง',
                                      style: TextStyle(color: AppTheme.ognMdGreen),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    contractController.selectedContractDetail.value = value;
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
                                  style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                                    labelText: 'กรุณาระบุข้อมูลที่ต้องการเปลี่ยนแปลง',
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
                                      borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                                      borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
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
                                        'แนบเอกสารที่ต้องการเปลี่ยนแปลง (หากมี)',
                                        style: TextStyle(color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Obx(
                                  () => contractController.selectedFiles.isEmpty
                                      ? InkWell(
                                          onTap: () {
                                            pickFileOrImage();
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 150,
                                            child: DottedBorder(
                                                color: Colors.grey,
                                                dashPattern: const [
                                                  4,
                                                  2
                                                ],
                                                borderType: BorderType.RRect,
                                                radius: const Radius.circular(12),
                                                padding: const EdgeInsets.all(20),
                                                // child: image1 != null
                                                child: const Center(
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
                                                        'อัพโหลดไฟล์และรูปภาพ',
                                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                                      ),
                                                      Text(
                                                        'ไฟล์ JPG, PNG หรือ PDF',
                                                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
                                                dashPattern: const [
                                                  4,
                                                  2
                                                ],
                                                borderType: BorderType.RRect,
                                                radius: const Radius.circular(12),
                                                padding: const EdgeInsets.all(12),
                                                child: GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const RangeMaintainingScrollPhysics(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 5.0,
                                                    mainAxisSpacing: 5.0,
                                                  ),
                                                  itemCount: contractController.selectedFiles.length + 1, // เพิ่ม 1 เพื่อใส่เครื่องหมาย "+"
                                                  itemBuilder: (context, index) {
                                                    if (index < contractController.selectedFiles.length) {
                                                      final fileData = contractController.selectedFiles[index];
                                                      if (fileData['type'] == 'image') {
                                                        return ClipRRect(
                                                          borderRadius: BorderRadius.circular(12),
                                                          child: Image.file(
                                                            File((fileData['file'] as XFile).path),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        );
                                                      } else {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            pickFileOrImage();
                                                          },
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey[200],
                                                              borderRadius: BorderRadius.circular(12),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                const Icon(
                                                                  Icons.picture_as_pdf,
                                                                  color: Colors.red,
                                                                  size: 40,
                                                                ),
                                                                Text(
                                                                  (fileData['file'] as PlatformFile).name,
                                                                  style: const TextStyle(fontSize: 12),
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
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[200],
                                                            borderRadius: BorderRadius.circular(12),
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
                  // Get.toNamed('confirm-changepass');
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.back();
                    contractController.sendData();
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        'แจ้งเปลี่ยนแปลง',
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
