import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/car_controller.dart';
import 'package:organics_salary/theme.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final CarController carController = Get.put(CarController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<CarController>();
    super.dispose();
  }

  List listCar = [
    {'cId': 1, 'cName': 'รถยนต์'},
    {'cId': 2, 'cName': 'มอเตอร์ไซค์'},
  ];

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      if (img != null) {
        carController.selectedImages.add(img);
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
          'เพิ่มข้อมูลรถส่วนตัว',
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
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
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
                                              'ประเภทรถ',
                                              style: TextStyle(
                                                  color: AppTheme.ognMdGreen),
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
                                            if (value == 'เลือกประเภทรถ' ||
                                                value == null ||
                                                value.isEmpty) {
                                              return 'เลือกประเภทรถ';
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
                                                    vertical: 12,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          hint: Text(
                                            'เลือกประเภทรถ',
                                            style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 14),
                                            ),
                                          ),
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: 'เลือกประเภทรถ',
                                              enabled: false,
                                              child: Text(
                                                'เลือกประเภทรถ',
                                                style: GoogleFonts.kanit(
                                                  textStyle: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 14,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                            for (final car in listCar)
                                              DropdownMenuItem<String>(
                                                value: '${car['cId']}',
                                                child: Text(
                                                  '${car['cName']}',
                                                  style: GoogleFonts.kanit(
                                                    textStyle: const TextStyle(
                                                        color:
                                                            AppTheme.ognMdGreen,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                          ],
                                          onChanged: (String? value) {
                                            if (value != null) {
                                              // dynamic selectedValues = value.split(' ');
                                              // String leaveId = selectedValues[0];
                                              // String leaveName = selectedValues[1];

                                              carController.selectedCarText
                                                  .value = value;
                                              // leaveHistoryController.selectedLeaveId.value = leaveId;
                                              // leaveHistoryController.selectedLeaveName.value = leaveName;
                                              // leaveHistoryController.selectedLeave.value = value;

                                              // print(leaveHistoryController.selectedLeaveId.value);
                                              print(value);
                                            }
                                          },
                                          value: carController
                                              .selectedCarText.value,
                                          // value: carController.filteredCarList.first['car_category_id'],
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                          dropdownColor: Colors.white,
                                          // underline: Container(),
                                          isExpanded: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.pin_rounded,
                                            size: 18,
                                            color: AppTheme.ognOrangeGold,
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                              child: Text(
                                            'ทะเบียน',
                                            style: TextStyle(
                                                color: AppTheme.ognMdGreen),
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรอกรายละเอียด';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) => carController
                                            .selectedCarRegistration
                                            .value = value,
                                        // onSubmitted: (val) => submit(),
                                        style: const TextStyle(
                                            color: AppTheme.ognMdGreen,
                                            fontSize: 14),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 25),
                                          labelText: 'กรอกเลขทะเบียน',
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
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.carTunnel,
                                            size: 18,
                                            color: AppTheme.ognOrangeGold,
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                              child: Text(
                                            'ยี่ห้อ',
                                            style: TextStyle(
                                                color: AppTheme.ognMdGreen),
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรอกรายละเอียด';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) => carController
                                            .selectedCarBrand.value = value,
                                        // onSubmitted: (val) => submit(),
                                        style: const TextStyle(
                                            color: AppTheme.ognMdGreen,
                                            fontSize: 14),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 25),
                                          labelText: 'กรอกข้อมูล',
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
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.palette_rounded,
                                            size: 18,
                                            color: AppTheme.ognOrangeGold,
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                              child: Text(
                                            'สี',
                                            style: TextStyle(
                                                color: AppTheme.ognMdGreen),
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'กรอกรายละเอียด';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) => carController
                                            .selectedCarColor.value = value,
                                        // onSubmitted: (val) => submit(),
                                        style: const TextStyle(
                                            color: AppTheme.ognMdGreen,
                                            fontSize: 14),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 25),
                                          labelText: 'กรอกข้อมูล',
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
                                      FontAwesomeIcons.solidImage,
                                      size: 16,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'รูปถ่าย',
                                        style: TextStyle(
                                            color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                    // Obx(
                                    //   () => carController.selectedImages.isEmpty
                                    //       ? Container()
                                    //       : Expanded(
                                    //           child: Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment.end,
                                    //             children: [
                                    //               InkWell(
                                    //                 onTap: () {
                                    //                   getImage(
                                    //                       ImageSource.gallery);
                                    //                 },
                                    //                 child: const Text(
                                    //                   'เลือกรูปภาพใหม่',
                                    //                   style: TextStyle(
                                    //                       color: AppTheme
                                    //                           .ognOrangeGold),
                                    //                 ),
                                    //               ),
                                    //               const Padding(
                                    //                 padding:
                                    //                     EdgeInsets.symmetric(
                                    //                         horizontal: 10),
                                    //                 child: Text(
                                    //                   '|',
                                    //                   style: TextStyle(
                                    //                       color: AppTheme
                                    //                           .ognOrangeGold),
                                    //                 ),
                                    //               ),
                                    //               InkWell(
                                    //                 onTap: () {
                                    //                   carController
                                    //                       .selectedImages
                                    //                       .isEmpty;
                                    //                 },
                                    //                 child: const Text(
                                    //                   'ลบ',
                                    //                   style: TextStyle(
                                    //                       color: AppTheme
                                    //                           .ognOrangeGold),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Obx(
                                  () => carController.selectedImages.isEmpty
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
                                          File(carController
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
                  // Get.toNamed('confirm-changepass');
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.back();
                    carController.sendData();
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
