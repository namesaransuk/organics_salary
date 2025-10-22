import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organics_salary/controllers/maintenance_controller.dart';
import 'package:organics_salary/theme.dart';

class ReportMaintenancePage extends StatefulWidget {
  const ReportMaintenancePage({super.key});

  @override
  State<ReportMaintenancePage> createState() => _ReportMaintenancePageState();
}

class _ReportMaintenancePageState extends State<ReportMaintenancePage> {
  final MaintenanceController maintenanceController = Get.put(MaintenanceController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    maintenanceController.fetchMaintenance();
    maintenanceController.fetchLocation();
  }

  @override
  void dispose() {
    Get.delete<MaintenanceController>();
    super.dispose();
  }

  List types = [
    {
      'id': 1,
      'name': 'สถานที่'
    },
    {
      'id': 2,
      'name': 'สินทรัพย์'
    },
    {
      'id': 3,
      'name': 'อื่นๆ'
    },
  ];

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media, mode) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      if (img != null) {
        maintenanceController.selectedImages.add(img);
      }
    });
  }

  final TextEditingController selectedMaintenanceController = TextEditingController();

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
          'แจ้งซ่อมบำรุง',
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
                                      Icons.widgets_rounded,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'หมวดหมู่',
                                      style: TextStyle(color: AppTheme.ognMdGreen),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == 'เลือกหมวดหมู่' || value == null || value.isEmpty) {
                                      return 'เลือกหมวดหมู่';
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
                                  hint: Text(
                                    'เลือกหมวดหมู่',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: 'เลือกหมวดหมู่',
                                      enabled: false,
                                      child: Text(
                                        'เลือกหมวดหมู่',
                                        style: GoogleFonts.kanit(
                                          textStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    for (final type in types)
                                      DropdownMenuItem<String>(
                                        value: '${type['id']}',
                                        child: Text(
                                          '${type['name']}',
                                          style: GoogleFonts.kanit(
                                            textStyle: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                  ],
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      print(value);
                                      maintenanceController.selectedMaintenanceType.value = value;
                                    }
                                  },
                                  value: maintenanceController.selectedMaintenanceType.value,
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
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () {
                                return maintenanceController.selectedMaintenanceType.value == '1'
                                    ? Column(
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
                                                'สถานที่',
                                                style: TextStyle(color: AppTheme.ognMdGreen),
                                              )),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            controller: selectedMaintenanceController,
                                            onTap: () {
                                              maintenanceOne();
                                            },
                                            // onChanged: (value) {
                                            //   maintenanceController.maintenanceDetail.value = value;
                                            // },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'กรอกรายละเอียด';
                                              }
                                              return null;
                                            },
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              filled: true,
                                              fillColor: Colors.white,
                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
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
                                          ),
                                          // SearchChoices.single(
                                          //   validator: (value) {
                                          //     if (value == 'เลือกประเภทการแจ้งซ่อม' || value == null || value.isEmpty) {
                                          //       return 'เลือกประเภทการแจ้งซ่อม';
                                          //     }
                                          //     return null;
                                          //   },
                                          //   padding: const EdgeInsets.symmetric(horizontal: 0),
                                          //   displayClearIcon: false,
                                          //   searchInputDecoration: InputDecoration(
                                          //     icon: const Icon(Icons.search),
                                          //     border: OutlineInputBorder(
                                          //       borderRadius: BorderRadius.circular(35.0),
                                          //     ),
                                          //   ),
                                          //   fieldDecoration: BoxDecoration(
                                          //     color: Colors.white,
                                          //     shape: BoxShape.rectangle,
                                          //     borderRadius: BorderRadius.circular(25),
                                          //     border: Border.all(
                                          //       color: Colors.grey.shade300,
                                          //       width: 1,
                                          //       // style: BorderStyle.solid,
                                          //     ),
                                          //   ),
                                          //   items: maintenanceController.listLocation.map((item) {
                                          //     return DropdownMenuItem(
                                          //       value: item['id'].toString(),
                                          //       child: Padding(
                                          //         padding: const EdgeInsets.symmetric(horizontal: 26),
                                          //         child: Text(
                                          //           item['place_name'],
                                          //           style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                          //         ),
                                          //       ),
                                          //     );
                                          //   }).toList(),
                                          //   value: maintenanceController.selectedMaintenanceId.value,
                                          //   // selectedItems: selectedItemsMultiDialog,
                                          //   hint: const Padding(
                                          //     padding: EdgeInsets.symmetric(horizontal: 26),
                                          //     child: Text(
                                          //       "เลือกประเภทการแจ้งซ่อม",
                                          //       style: TextStyle(color: Colors.grey, fontSize: 14),
                                          //     ),
                                          //   ),
                                          //   searchHint: "เลือกประเภทการแจ้งซ่อม",
                                          //   isCaseSensitiveSearch: false,
                                          //   onChanged: (value) {
                                          //     print(value);
                                          //     maintenanceController.selectedMaintenanceId.value = value.toString();
                                          //   },
                                          //   isExpanded: true,
                                          // ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )
                                    : maintenanceController.selectedMaintenanceType.value == '2'
                                        ? Column(
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
                                                    'หมวดหมู่',
                                                    style: TextStyle(color: AppTheme.ognMdGreen),
                                                  )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                controller: selectedMaintenanceController,
                                                onTap: () {
                                                  maintenanceTwo();
                                                },
                                                // onChanged: (value) {
                                                //   maintenanceController.maintenanceDetail.value = value;
                                                // },
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'กรอกรายละเอียด';
                                                  }
                                                  return null;
                                                },
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                                decoration: InputDecoration(
                                                  alignLabelWithHint: true,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
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
                                              ),
                                              // SearchChoices.single(
                                              //   validator: (value) {
                                              //     if (value == 'เลือกประเภทการแจ้งซ่อม' || value == null || value.isEmpty) {
                                              //       return 'เลือกประเภทการแจ้งซ่อม';
                                              //     }
                                              //     return null;
                                              //   },
                                              //   padding: const EdgeInsets.symmetric(horizontal: 0),
                                              //   displayClearIcon: false,
                                              //   searchInputDecoration: InputDecoration(
                                              //     icon: const Icon(Icons.search),
                                              //     border: OutlineInputBorder(
                                              //       borderRadius: BorderRadius.circular(35.0),
                                              //     ),
                                              //   ),
                                              //   fieldDecoration: BoxDecoration(
                                              //     color: Colors.white,
                                              //     shape: BoxShape.rectangle,
                                              //     borderRadius: BorderRadius.circular(25),
                                              //     border: Border.all(
                                              //       color: Colors.grey.shade300,
                                              //       width: 1,
                                              //       // style: BorderStyle.solid,
                                              //     ),
                                              //   ),
                                              //   items: maintenanceController.listMaintenance.map((item) {
                                              //     return DropdownMenuItem(
                                              //       value: item['id'].toString(),
                                              //       child: Padding(
                                              //         padding: const EdgeInsets.symmetric(horizontal: 26),
                                              //         child: Text(
                                              //           item['name'],
                                              //           style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                              //         ),
                                              //       ),
                                              //     );
                                              //   }).toList(),
                                              //   value: maintenanceController.selectedMaintenanceId.value,
                                              //   // selectedItems: selectedItemsMultiDialog,
                                              //   hint: const Padding(
                                              //     padding: EdgeInsets.symmetric(horizontal: 26),
                                              //     child: Text(
                                              //       "เลือกประเภทการแจ้งซ่อม",
                                              //       style: TextStyle(color: Colors.grey, fontSize: 14),
                                              //     ),
                                              //   ),
                                              //   searchHint: "เลือกประเภทการแจ้งซ่อม",
                                              //   onChanged: (value) {
                                              //     print(value);
                                              //     maintenanceController.selectedMaintenanceId.value = value.toString();
                                              //   },
                                              //   // closeButton: (selectedItems) {
                                              //   //   return (selectedItems.isNotEmpty ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}" : "Save without selection");
                                              //   // },
                                              //   isExpanded: true,
                                              // ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          )
                                        : maintenanceController.selectedMaintenanceType.value == '3'
                                            ? Column(
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
                                                        'หัวข้อ (อื่นๆ)',
                                                        style: TextStyle(color: AppTheme.ognMdGreen),
                                                      )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFormField(
                                                    onChanged: (value) {
                                                      maintenanceController.selectedMaintenanceTitle.value = value;
                                                    },
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'กรอกรายละเอียด';
                                                      }
                                                      return null;
                                                    },
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                                                    decoration: InputDecoration(
                                                      alignLabelWithHint: true,
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
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
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              )
                                            : Container();
                              },
                            ),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.circleInfo,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'สาเหตุ / อาการที่ต้องการแจ้ง',
                                        style: TextStyle(color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    maintenanceController.maintenanceDetail.value = value;
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
                                        style: TextStyle(color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Obx(
                                  () => maintenanceController.selectedImages.isNotEmpty
                                      ? Image.file(
                                          File(maintenanceController.selectedImages[0].path),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            getImage(ImageSource.gallery, 1);
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
                  if (_formKey.currentState?.validate() ?? false) {
                    // Get.back();
                    maintenanceController.sendData();
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
      ),
    );
  }

  void maintenanceOne() {
    return DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Text(
            "เลือกสถานที่",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: maintenanceController.listLocation
            .map((item) => SelectedListItem(
                  name: item['place_name'], // ชื่อที่แสดง
                  value: item['id'].toString(), // ค่าที่ใช้ในการเก็บข้อมูล
                ))
            .toList(),
        onSelected: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty && selectedList.first is SelectedListItem) {
            final selectedItem = selectedList.first as SelectedListItem;
            maintenanceController.selectedMaintenanceId.value = selectedItem.value.toString();

            selectedMaintenanceController.text = selectedItem.name;
            print('Selected: ${selectedItem.value} - ${selectedItem.name}');
          }
        },
        enableMultipleSelection: false, // ปิดการเลือกหลายค่า
      ),
    ).showModal(context);
  }

  void maintenanceTwo() {
    return DropDownState(
      DropDown(
        bottomSheetTitle: const Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Text(
            "เลือกประเภทการแจ้งซ่อม",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: maintenanceController.listMaintenance
            .map((item) => SelectedListItem(
                  name: item['name'], // ชื่อที่แสดง
                  value: item['id'].toString(), // ค่าที่ใช้ในการเก็บข้อมูล
                ))
            .toList(),
        onSelected: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty && selectedList.first is SelectedListItem) {
            final selectedItem = selectedList.first as SelectedListItem;
            maintenanceController.selectedMaintenanceId.value = selectedItem.value.toString();

            selectedMaintenanceController.text = selectedItem.name;
            print('Selected: ${selectedItem.value} - ${selectedItem.name}');
          }
        },
        enableMultipleSelection: false, // ปิดการเลือกหลายค่า
      ),
    ).showModal(context);
  }
}
