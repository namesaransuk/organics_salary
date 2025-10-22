import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/maintenance_controller.dart';
import 'package:organics_salary/theme.dart';

class DetailMaintenancePage extends StatefulWidget {
  const DetailMaintenancePage({super.key});

  @override
  State<DetailMaintenancePage> createState() => _DetailMaintenancePageState();
}

class _DetailMaintenancePageState extends State<DetailMaintenancePage> {
  final MaintenanceController maintenanceController =
      Get.put(MaintenanceController());
  var baseUrl = dotenv.env['ASSET_URL'];

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;

    Color colorStatus = Colors.grey;
    if (item['status'] == 1) {
      colorStatus = Colors.grey;
    } else if (item['status'] == 2) {
      colorStatus = Colors.amber;
    } else if (item['status'] == 3) {
      colorStatus = Colors.orange;
    } else if (item['status'] == 4) {
      colorStatus = AppTheme.stepperGreen;
    } else if (item['status'] == 5) {
      colorStatus = Colors.red;
    } else if (item['status'] == 6) {
      colorStatus = Colors.red;
    }
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item['note2'] == 'asset') ...[
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item['supply_detail']?['asset_image']?['file_path'] !=
                                null
                            ? '$baseUrl/${item['supply_detail']['asset_image']['file_path']}'
                            : '', // ถ้าไม่มี file_path ให้ใช้ fallback เป็นค่าว่าง
                        width: MediaQuery.of(context).size.height * 1,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Image.asset(
                              'assets/img/logo-error-thumbnail.jpeg');
                        },
                      ),
                    ),
                  ),
                ],
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.bar_chart_rounded,
                          color: AppTheme.ognOrangeGold),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'สถานะการดำเนินการ',
                          style: TextStyle(color: AppTheme.ognGreen),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        decoration: BoxDecoration(
                          color: colorStatus,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(35),
                          ),
                        ),
                        child: Text(
                          item['status_follower_data']['curent_status'] != null
                              ? (item['status_follower_data']['curent_status']
                                      is List
                                  ? (item['status_follower_data']
                                              ['curent_status']
                                          .isNotEmpty
                                      ? item['status_follower_data']
                                                  ['curent_status'][0]
                                              ['emp_status_app']
                                          .toString()
                                      : 'รายการใหม่')
                                  : item['status_follower_data']
                                          ['curent_status']['emp_status_app']
                                      .toString())
                              : 'รายการใหม่',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (item['note2'] == 'location') ...[
                  _buildDetailRow(Icons.autofps_select_outlined, 'ชื่อสถานที่',
                      '${item['location_detail']['place_name']} (${item['location_detail']['building_location']['location_name']})'),
                  _buildDetailRow(
                      Icons.info,
                      'สาเหตุ / อาการ ที่ต้องการแจ้งบำรุงรักษา',
                      '${item['detail']}'),
                  if (item['transaction_requests_file'] != null &&
                      item['transaction_requests_file'].isNotEmpty &&
                      item['transaction_requests_file'][0]['file_path'] !=
                          null) ...[
                    _buildDetailRow(Icons.image_rounded, 'รูปภาพ', ''),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          '$baseUrl/${item['transaction_requests_file'][0]['file_path']}',
                          width: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
                if (item['note2'] == 'asset') ...[
                  _buildDetailRow(Icons.assignment, 'รหัสสินทรัพย์ทาง HR',
                      '${item['supply_detail']['hr_code']['code']}'),
                  _buildDetailRow(Icons.autofps_select_outlined,
                      'ชื่อสินทรัพย์', '${item['supply_detail']['name']}'),
                  _buildDetailRow(FontAwesomeIcons.barcode, 'Serial Number',
                      '${item['supply_detail']['serial_number']}'),
                  _buildDetailRow(
                      Icons.info,
                      'สาเหตุ / อาการ ที่ต้องการแจ้งบำรุงรักษา',
                      '${item['detail']}'),
                  if (item['transaction_requests_file'] != null &&
                      item['transaction_requests_file'].isNotEmpty &&
                      item['transaction_requests_file'][0]['file_path'] !=
                          null) ...[
                    _buildDetailRow(Icons.image_rounded, 'รูปภาพ', ''),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          '$baseUrl/${item['transaction_requests_file'][0]['file_path']}',
                          width: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
                if (item['note2'] == 'other') ...[
                  _buildDetailRow(
                      Icons.category, 'ชื่ออื่น ๆ', '${item['note1']}'),
                  _buildDetailRow(
                      Icons.info,
                      'สาเหตุ / อาการ ที่ต้องการแจ้งบำรุงรักษา',
                      '${item['detail']}'),
                  if (item['transaction_requests_file'] != null &&
                      item['transaction_requests_file'].isNotEmpty &&
                      item['transaction_requests_file'][0]['file_path'] !=
                          null) ...[
                    _buildDetailRow(Icons.image_rounded, 'รูปภาพ', ''),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          '$baseUrl/${item['transaction_requests_file'][0]['file_path']}',
                          width: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
                _buildDetailRow(Icons.date_range, 'วันที่แจ้งซ่อมบำรุง',
                    formatDate(item['created_at'])),
              ],
            ),
          ),
        ),
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
}
