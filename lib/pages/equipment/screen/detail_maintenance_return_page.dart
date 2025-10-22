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

class DetailMaintenanceReturnPage extends StatefulWidget {
  const DetailMaintenanceReturnPage({super.key});

  @override
  State<DetailMaintenanceReturnPage> createState() => _DetailMaintenanceReturnPageState();
}

class _DetailMaintenanceReturnPageState extends State<DetailMaintenanceReturnPage> {
  final EquipmentController equipmentController = Get.put(EquipmentController());
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

    // Color colorStatus = Colors.grey;
    // if (item['status'] == 1) {
    //   colorStatus = Colors.grey;
    // } else if (item['status'] == 2) {
    //   colorStatus = Colors.amber;
    // } else if (item['status'] == 3) {
    //   colorStatus = Colors.orange;
    // } else if (item['status'] == 4) {
    //   colorStatus = AppTheme.stepperGreen;
    // } else if (item['status'] == 5) {
    //   colorStatus = Colors.red;
    // } else if (item['status'] == 6) {
    //   colorStatus = Colors.red;
    // }
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
          'อุปกรณ์',
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
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            item['item_data']?['asset_image']?['file_path'] != null ? '$baseUrl/${item['item_data']?['asset_image']?['file_path']}' : '-',
                            width: MediaQuery.of(context).size.height * 1,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                              return Image.asset('assets/img/logo-error-thumbnail.jpeg');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.bar_chart_rounded, color: AppTheme.ognOrangeGold),
                      //       const SizedBox(width: 8),
                      //       Expanded(
                      //         child: Text(
                      //           'สถานะการดำเนินการ',
                      //           style: const TextStyle(color: AppTheme.ognGreen),
                      //         ),
                      //       ),
                      //       Container(
                      //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      //         decoration: BoxDecoration(
                      //           color: colorStatus,
                      //           borderRadius: const BorderRadius.all(
                      //             Radius.circular(35),
                      //           ),
                      //         ),
                      //         child: Text(
                      //           item['status_follower_data']['curent_status'] != null ? (item['status_follower_data']['curent_status'] is List ? (item['status_follower_data']['curent_status'].isNotEmpty ? item['status_follower_data']['curent_status'][0]['emp_status_app'].toString() : 'รายการใหม่') : item['status_follower_data']['curent_status']['emp_status_app'].toString()) : 'รายการใหม่',
                      //           style: const TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 10,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      _buildDetailRow(Icons.assignment, 'รหัสสินทรัพย์ทาง HR', item['item_data']?['hr_code']?['code'] ?? '-'),
                      _buildDetailRow(Icons.assignment, 'รหัสสินทรัพย์ทางบัญชี', item['item_data']?['ac_code']?['code'] ?? '-'),
                      _buildDetailRow(Icons.autofps_select_outlined, 'ชื่อสินทรัพย์', item['name'] ?? '-'),
                      _buildDetailRow(Icons.category_rounded, 'หมวดหมู่สินทรัพย์', item['item_data']?['categories']?['name'] ?? '-'),
                      _buildDetailRow(Icons.type_specimen_rounded, 'ประเภทสินทรัพย์', item['item_data']?['asset_type']?['name'] ?? '-'),
                      _buildDetailRow(Icons.shape_line, 'ชนิดสินทรัพย์', item['item_data']?['asset_class']?['name'] ?? '-'),
                      _buildDetailRow(FontAwesomeIcons.barcode, 'Serial Number', item['item_data']?['serial_number'] ?? '-'),
                      _buildDetailRow(Icons.model_training_rounded, 'Model', item['item_data']?['model'] ?? '-'),
                      _buildDetailRow(FontAwesomeIcons.brandsFontAwesome, 'ยี่ห้อ', item['item_data']?['brand'] ?? '-'),
                      _buildDetailRow(Icons.info, 'รายละเอียดเพิ่มเติม', item['item_data']?['description'] ?? '-'),
                      _buildDetailRow(Icons.date_range, 'วันที่เบิกอุปกรณ์ล่าสุด', formatDate(item['item_data']?['created_at'])),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          // openBottomSheet(1, item);
                          Get.toNamed('report-maintenance-return', arguments: item);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppTheme.ognOrangeGold, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: const Text(
                            'ส่งคืนอุปกรณ์',
                            style: TextStyle(
                              color: AppTheme.ognOrangeGold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // openBottomSheet(2, item);
                          Get.toNamed('report-maintenance-repair', arguments: item);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.ognOrangeGold,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: const Text(
                            'แจ้งซ่อมบำรุง',
                            style: TextStyle(
                              color: Colors.white, // สีข้อความ
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
          onChanged: (value) => equipmentController.selectedReturnMaintenanceDetail.value = value,
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
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ognOrangeGold),
          onPressed: () {
            equipmentController.selectedReturnMaintenanceId.value = item['item_id'].toString();
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
            onChanged: (value) => equipmentController.selectedReportMaintenanceDetail.value = value,
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
                () => equipmentController.selectedReportMaintenanceImages.isEmpty
                    ? InkWell(
                        onTap: () {
                          getImage(ImageSource.gallery);
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
                      )
                    : Image.file(
                        File(equipmentController.selectedReportMaintenanceImages[0].path),
                      ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ognOrangeGold),
            onPressed: () {
              equipmentController.selectedReportMaintenanceId.value = item['item_id'].toString();
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

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.ognOrangeGold),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: AppTheme.ognGreen),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

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
