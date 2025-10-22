import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/equipment_controller.dart';
import 'package:organics_salary/theme.dart';

class ReportMaintenanceReturnPage extends StatefulWidget {
  const ReportMaintenanceReturnPage({super.key});

  @override
  State<ReportMaintenanceReturnPage> createState() =>
      _ReportMaintenanceReturnPageState();
}

class _ReportMaintenanceReturnPageState
    extends State<ReportMaintenanceReturnPage> {
  final EquipmentController equipmentController =
      Get.put(EquipmentController());
  var baseUrl = dotenv.env['ASSET_URL'];

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    if (img != null) {
      equipmentController.selectedReportMaintenanceImages.add(img);
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<EquipmentController>();
    equipmentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;

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
          'ส่งคืนอุปกรณ์',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'ส่งคืนอุปกรณ์',
              //   style: TextStyle(
              //     color: AppTheme.ognMdGreen,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16,
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),
              const Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleExclamation,
                    size: 18,
                    color: AppTheme.ognOrangeGold,
                  ),
                  SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      'สาเหตุที่ต้องการส่งคืนอุปกรณ์',
                      style: TextStyle(color: AppTheme.ognMdGreen),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                onChanged: (value) => equipmentController
                    .selectedReturnMaintenanceDetail.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรอกรายละเอียด';
                  }
                  return null;
                },
                textAlign: TextAlign.start,
                minLines: 4,
                maxLines: null,
                style:
                    const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                decoration: _buildInputDecoration(),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.ognOrangeGold),
                onPressed: () {
                  equipmentController.selectedReturnMaintenanceId.value =
                      item['item_id'].toString();
                  equipmentController.sendReturnData();
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child:
                          Text('บันทึก', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(int mode, item) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          padding: const EdgeInsets.all(16.0),
          child: mode == 1 ? _buildMode1(item) : _buildMode2(item),
        );
      },
    );
  }

  Widget _buildMode1(item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ส่งคืนอุปกรณ์',
          style: TextStyle(
            color: AppTheme.ognMdGreen,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Row(
          children: [
            FaIcon(
              FontAwesomeIcons.circleExclamation,
              size: 18,
              color: AppTheme.ognOrangeGold,
            ),
            SizedBox(width: 7),
            Expanded(
              child: Text(
                'สาเหตุที่ต้องการส่งคืนอุปกรณ์',
                style: TextStyle(color: AppTheme.ognMdGreen),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          onChanged: (value) =>
              equipmentController.selectedReturnMaintenanceDetail.value = value,
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
          decoration: _buildInputDecoration(),
        ),
        const Spacer(),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppTheme.ognOrangeGold),
          onPressed: () {
            equipmentController.selectedReturnMaintenanceId.value =
                item['item_id'].toString();
            equipmentController.sendReturnData();
          },
          child: const SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text('บันทึก', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildMode2(item) {
    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'แจ้งซ่อมบำรุง',
            style: TextStyle(
              color: AppTheme.ognMdGreen,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.circleExclamation,
                size: 18,
                color: AppTheme.ognOrangeGold,
              ),
              SizedBox(width: 7),
              Expanded(
                child: Text(
                  'สาเหตุ / อาการ ที่ต้องการแจ้งบำรุงรักษา',
                  style: TextStyle(color: AppTheme.ognMdGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            onChanged: (value) => equipmentController
                .selectedReportMaintenanceDetail.value = value,
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
            decoration: _buildInputDecoration(),
          ),
          const SizedBox(height: 12),
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
                () => equipmentController
                        .selectedReportMaintenanceImages.isEmpty
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
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    'ไฟล์ JPG, PNG',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Image.file(
                        File(equipmentController
                            .selectedReportMaintenanceImages[0].path),
                      ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ognOrangeGold),
            onPressed: () {
              equipmentController.selectedReportMaintenanceId.value =
                  item['item_id'].toString();
              equipmentController.sendReportData();
            },
            child: const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text('บันทึก', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Widget _buildDetailRow(IconData icon, String title, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 12.0),
  //     child: Row(
  //       children: [
  //         Icon(icon, color: AppTheme.ognOrangeGold),
  //         const SizedBox(width: 8),
  //         Expanded(
  //           child: Text(
  //             title,
  //             style: const TextStyle(color: AppTheme.ognGreen),
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             value,
  //             textAlign: TextAlign.right,
  //             style: const TextStyle(color: Colors.teal),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  String formatDate(String dateTime) {
    // แปลง String เป็น DateTime
    final date = DateTime.parse(dateTime);

    // แปลงวันที่เป็นรูปแบบที่ต้องการ
    final thaiMonths = [
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม'
    ];
    final thaiYear = date.year + 543; // เพิ่ม 543 เพื่อแปลงปีเป็น พ.ศ.
    final thaiMonth = thaiMonths[date.month - 1];
    final time = DateFormat('HH:mm น.').format(date);

    return '${date.day} $thaiMonth $thaiYear ($time)';
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
      labelText: 'กรอกรายละเอียด',
      labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
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
    );
  }
}
