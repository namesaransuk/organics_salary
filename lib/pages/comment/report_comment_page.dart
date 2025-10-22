import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/comment_controller.dart';
import 'package:organics_salary/theme.dart';

class ReportCommentPage extends StatefulWidget {
  const ReportCommentPage({super.key});

  @override
  State<ReportCommentPage> createState() => _ReportCommentPageState();
}

class _ReportCommentPageState extends State<ReportCommentPage> {
  final CommentController commentController = Get.put(CommentController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<CommentController>();
    super.dispose();
  }

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    if (img != null) {
      commentController.selectedImages.add(img);
    }
  }

  @override
  Widget build(BuildContext context) {
    // commentController.fetchComment();
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
          'เสนอความคิดเห็น',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.subtitles_rounded,
                                    size: 18,
                                    color: AppTheme.ognOrangeGold,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'ชื่อเรื่อง',
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
                                  commentController
                                      .selectedSubCommentText.value = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรอกรายละเอียด';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: AppTheme.ognMdGreen, fontSize: 14),
                                decoration: InputDecoration(
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
                                      'รายละเอียด',
                                      style:
                                          TextStyle(color: AppTheme.ognMdGreen),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  commentController
                                      .selectedCommentDetail.value = value;
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
                                    size: 18,
                                    color: AppTheme.ognOrangeGold,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'รูปภาพ (อุปกรณ์ / สถานที่หรืออื่น ๆ)',
                                      style:
                                          TextStyle(color: AppTheme.ognMdGreen),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Obx(() {
                                return commentController.selectedImages.isEmpty
                                    ? InkWell(
                                        onTap: () {
                                          getImage(ImageSource.gallery);
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
                                                    'ไฟล์ JPG, PNG',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Image.file(
                                        File(commentController
                                            .selectedImages[0].path),
                                      );
                              }),
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
                  commentController.sendData();
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
            )
          ],
        ),
      ),
    );
  }
}
