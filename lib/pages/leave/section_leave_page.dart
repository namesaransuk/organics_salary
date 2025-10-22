import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/leave_history_controller.dart';
import 'package:organics_salary/controllers/notification_controller.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

class SectionLeavePage extends StatefulWidget {
  const SectionLeavePage({super.key});

  @override
  State<SectionLeavePage> createState() {
    return _SectionLeavePageState();
  }
}

class _SectionLeavePageState extends State<SectionLeavePage>
    with TickerProviderStateMixin {
  final LeaveHistoryController leaveHistoryController =
      Get.put(LeaveHistoryController());
  final NotificationController notificationController =
      Get.put(NotificationController());
  dynamic item;
  Color colorStatus = Colors.grey;

  @override
  void initState() {
    // loadItemData();
    super.initState();
  }

  Future<bool> loadItemData() async {
    // leaveHistoryController.searchStartDate.value = '';
    // leaveHistoryController.searchEndDate.value = '';
    await leaveHistoryController.loadDataSection();

    final arguments = Get.arguments;
    item = leaveHistoryController.leaveHistorySectionList.firstWhere(
      (i) => i['id'].toString() == arguments.toString(),
      orElse: () => null,
    );
    print('arg section :$arguments');
    print('item section :$item');

    // คำนวณ colorStatus
    if (item != null) {
      switch (item!['status']) {
        case 1:
          colorStatus = Colors.grey;
          break;
        case 2:
          colorStatus = Colors.amber;
          break;
        case 3:
          colorStatus = Colors.orange;
          break;
        case 4:
          colorStatus = AppTheme.stepperGreen;
          break;
        case 5:
          colorStatus = Colors.red;
          break;
        case 6:
          colorStatus = Colors.red;
          break;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = Get.arguments as Map<String, dynamic>;
    // final item = arguments['item'];
    var baseUrl = dotenv.env['ASSET_URL'];
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
          'ข้อมูลการลา',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: loadItemData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (item == null) {
              return const Scaffold(
                body: Center(child: Text('ไม่พบข้อมูล')),
              );
            }

            // DateTime leaveApproveDateTime =
            //     DateTime.parse(item!['status_logs']['created_at_th']);
            // String formattedLeaveApproveDate =
            //     '${DateFormat("dd MMMM yyyy HH:mm").format(item!['status_logs']['created_at_th'])} (${DateFormat("HH:mm").format(item!['status_logs']['created_at_th'])} น.)';

            // DateTime leaveUpdateDateTime = DateTime.parse(item['updated_at']);
            // String formattedLeaveUpdateDate =
            //     DateFormat("dd/MM/yyyy").format(leaveUpdateDateTime);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.circleExclamation,
                            color: AppTheme.ognOrangeGold,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'สถานะการดำเนินการ',
                              style: TextStyle(
                                color: AppTheme.ognGreen,
                                fontSize: 12,
                              ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  item!['status_logs']['status_name'] != null
                                      ? (item!['status_logs']['status_name']
                                              is List
                                          ? (item!['status_logs']['status_name']
                                                  .isNotEmpty
                                              ? item!['status_logs']
                                                          ['status_name'][0]
                                                      ['emp_status_app']
                                                  .toString()
                                              : 'รายการใหม่')
                                          : item!['status_logs']['status_name']
                                              .toString())
                                      : 'ขออนุมัติ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDetailRow(
                        FontAwesomeIcons.calendarDay,
                        'วันที่แจ้ง',
                        // item!['status_logs']['created_at_th']),
                        item!['format_date']),
                    item['recipient_data'] != null
                        ? Container(
                            width: double.infinity,
                            // height: 150,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.ognGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppTheme.ognGreen.withOpacity(0.2),
                                  width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'รายละเอียดการอนุมัติ',
                                  style: TextStyle(
                                    color: AppTheme.ognGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _buildDetailRow(
                                    FontAwesomeIcons.userTie,
                                    'ผู้อนุมัติ',
                                    '${item['recipient_data']['prefix']}${item['recipient_data']['fnames']['multitexts'][0]['name']} ${item['recipient_data']['lnames']['multitexts'][0]['name']}'),
                                item['status_logs']['status_number'] == 4
                                    ? _buildDetailRow(
                                        FontAwesomeIcons.solidCalendarCheck,
                                        'วันที่อนุมัติ',
                                        item!['status_logs']['created_at_th'])
                                    : Container(),
                                item['status_logs']['status_number'] == 5
                                    ? Column(
                                        children: [
                                          _buildDetailRow(
                                              FontAwesomeIcons
                                                  .solidCalendarXmark,
                                              'วันที่ไม่อนุมัติ',
                                              item!['status_logs']
                                                  ['created_at_th']),
                                          _buildDetailRow(
                                              FontAwesomeIcons.solidNoteSticky,
                                              'เหตุผลที่ไม่อนุมัติ',
                                              '${item['detail'] ?? '-'}'),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          )
                        : Container(),
                    const Divider(
                      color: Colors.teal,
                      indent: 30,
                      endIndent: 30,
                      height: 30,
                    ),
                    _buildDetailRow(
                        FontAwesomeIcons.notesMedical,
                        'ประเภทการลา',
                        '${item!['leave_history']['leave_detail']['leavetype']['holiday_name_type']}'),
                    _buildDetailRow(
                        FontAwesomeIcons.solidFileLines,
                        'รายละเอียดเพิ่มเติม',
                        item!['leave_history']?['leave_detail']?['sub_leave']
                                ?['holiday_name_type'] ??
                            'ไม่มีข้อมูล'),
                    // _buildDetailRow(Icons.person, 'ผู้ปฏิบัติงานแทน', 'นายแอดมิน ทดสอบ'),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              item['leave_history']['leave_detail']
                                          ['sub_leave'] !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '-',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${item['leave_history']['leave_detail']['sub_leave']['holiday_name_type']} :',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${item['leave_history']['leave_detail']['subDetail'] != null ? item['leave_history']['leave_detail']['subDetail'] : '-'}',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              item!['leave_main_image'] != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '-',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'ไฟล์แนบเพิ่มเติม :',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: InkWell(
                                              onTap: () {
                                                showImageViewer(
                                                  context,
                                                  Image.network(
                                                          '$baseUrl/${item!['leave_main_image']['file_path']}')
                                                      .image,
                                                  useSafeArea: true,
                                                  swipeDismissible: true,
                                                  doubleTapZoomable: true,
                                                );
                                              },
                                              child: Image.network(
                                                '$baseUrl/${item!['leave_main_image']['file_path']}',
                                                fit: BoxFit.cover,
                                              ),
                                            ), // หรือใช้ Icon(Icons.image_not_supported)
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              item!['leave_sub_image'] != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '-',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  'ไฟล์แนบเพิ่มเติม :',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: InkWell(
                                              onTap: () {
                                                showImageViewer(
                                                  context,
                                                  Image.network(
                                                          '$baseUrl/${item!['leave_sub_image']['file_path']}')
                                                      .image,
                                                  useSafeArea: true,
                                                  swipeDismissible: true,
                                                  doubleTapZoomable: true,
                                                );
                                              },
                                              child: Image.network(
                                                '$baseUrl/${item!['leave_sub_image']['file_path']}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _buildDetailRow(FontAwesomeIcons.circleInfo, 'สาเหตุการลา',
                        '${item!['leave_history']['reason_leave']}'),
                    const Divider(
                      color: Colors.teal,
                      indent: 30,
                      endIndent: 30,
                      height: 30,
                    ),
                    _buildDetailRow(
                        FontAwesomeIcons.solidClock,
                        'ตั้งแต่วันที่/เวลา',
                        formatDate(item!['leave_history']['start_date'])),
                    _buildDetailRow(
                        FontAwesomeIcons.solidClock,
                        'จนถึงวันที่/เวลา',
                        formatDate(item!['leave_history']['end_date'])),
                    // _buildDetailRow(Icons.timer, 'จำนวนทั้งหมด', '0 วัน 0 ชั่วโมง 5 นาที')
                    _buildDetailRow(
                      FontAwesomeIcons.solidClock,
                      'จำนวนทั้งหมด',
                      '${item['leave_history']['leave_histories_view']['total_workdays_used']} วัน ${item['leave_history']['leave_histories_view']['leave_hours']} ชม. ${item['leave_history']['leave_histories_view']['leave_minutes']} นาที',
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppTheme.ognOrangeGold,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            // textAlign: TextAlign.justify,
            style: const TextStyle(
              color: AppTheme.ognGreen,
              fontSize: 12,
            ),
          ),
          SizedBox(
            width: 40,
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppTheme.ognGreen,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateTime) {
    final date = DateTime.parse(dateTime);
    return DateFormat("dd MMMM yyyy (HH:mm น.)", "th_TH").format(date);
  }
}
