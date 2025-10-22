import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/leave_approve_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:intl/intl.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

// แบบเก่า 03/10/68
class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  late bool screenMode;
  final leaveApproveController = Get.find<LeaveApproveController>();
  final _scroll =
      ScrollController(); // สำหรับทำ infinite scroll (ตัวเลือกเสริม)

  @override
  void initState() {
    super.initState();

    // ====== ตัวอย่าง infinite scroll (ถ้าคุณมี API แบบแบ่งหน้า) ======
    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
        // เรียกโหลดหน้าถัดไป (คุณต้องมีเมธอดใน controller เอง)
        // leaveApproveController.fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = leaveApproveController.leaveApproveList;

      if (list.isEmpty) {
        return _buildEmpty(context);
      }

      return ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        itemCount: list.length,
        // ถ้าตัวการ์ดสูง “คงที่” ใส่ itemExtent จะเร็วขึ้นมาก
        // itemExtent: 120, // <- ใส่ได้ถ้าความสูงคงที่
        cacheExtent: 800, // ลองปรับตามที่เหมาะ ช่วย prebuild หน้าจอถัดไป
        itemBuilder: (context, index) {
          final item = list[index] as Map<String, dynamic>;
          return _buildLeaveCard(context, item);
        },
      );
    });
  }

  Widget _buildEmpty(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/menu/part-time.png',
          width: MediaQuery.of(context).size.width * (screenMode ? 0.10 : 0.25),
        ),
        const SizedBox(height: 20),
        Text(
          'ไม่มีข้อมูลของวันที่เลือก',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildLeaveCard(BuildContext context, Map<String, dynamic> item) {
    // ====== เตรียมข้อมูล / format วันที่ ======
    final createdAtStr = item['created_at']?.toString();
    final dateTime =
        createdAtStr != null ? DateTime.parse(createdAtStr) : DateTime.now();
    final thaiYear = dateTime.year + 543;
    const thaiMonths = [
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
    final thaiMonth = thaiMonths[dateTime.month - 1];
    final formattedDate = '${dateTime.day} $thaiMonth $thaiYear';

    Color colorStatus = Colors.grey;
    switch (item['status']) {
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
      case 6:
        colorStatus = Colors.red;
        break;
    }

    final startStr = item['leave_history']?['start_date'];
    final endStr = item['leave_history']?['end_date'];
    final leaveStartDateTime =
        startStr != null ? DateTime.parse(startStr) : null;
    final leaveEndDateTime = endStr != null ? DateTime.parse(endStr) : null;

    final formattedLeaveStartDate = leaveStartDateTime != null
        ? DateFormat("dd/MM/yyyy HH:mm").format(leaveStartDateTime)
        : '-';
    final formattedLeaveEndDate = leaveEndDateTime != null
        ? DateFormat("dd/MM/yyyy HH:mm").format(leaveEndDateTime)
        : '-';

    // final user = item['user_transection_data'] ?? {};
    // final dept = user['departments_th'] ?? '';
    // final fname = user['fname_th'] ?? '';
    // final lname = user['lname_th'] ?? '';
    // final reason = item['leave_history']?['reason_leave'] ?? '';
    // final typeName = item['leave_history']?['leave_detail']?['leavetype']
    //         ?['holiday_name_type'] ??
    //     '';
    // final statusName = item['status_logs']?['status_name'] ?? 'รายการใหม่';

    final user = item['user_transection_data'] ?? {};
    final dept = '${user['departments_th'] ?? ''}';
    final fname = '${user['fname_th'] ?? ''}';
    final lname = '${user['lname_th'] ?? ''}';
    final reason = '${item['leave_history']?['reason_leave'] ?? ''}';
    final typeName =
        '${item['leave_history']?['leave_detail']?['leavetype']?['holiday_name_type'] ?? ''}';
    final statusName = '${item['status_logs']?['status_name'] ?? 'รายการใหม่'}';

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        // BoxShadow แพง ถ้าลิสต์ยาว ลด/เอาออกจะลื่นขึ้น
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0.05,
            blurRadius: 1.5,
            offset: const Offset(0.5, 0.25),
          ),
        ],
      ),
      child: InkWell(
        // onTap: () {
        //   Get.toNamed('leave-section-approve', arguments: item['id']);
        // },
        onTap: () {
          final int id = item['id'] as int; // id เป็น int
          // ส่งเป็น int ตรง ๆ
          Get.toNamed('leave-section-approve', arguments: {'treId': id});
        },

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _cardBody(
            typeName: typeName,
            reason: reason,
            colorStatus: colorStatus,
            statusName: statusName,
            employeeLine: 'ชื่อพนักงาน : $fname $lname ($dept)',
            leaveLine:
                'วันที่ลา : $formattedLeaveStartDate - $formattedLeaveEndDate',
            submittedLine: 'วันที่ส่งข้อมูล : $formattedDate',
          ),
        ),
      ),
    );
  }

  Widget _cardBody({
    required String typeName,
    required String reason,
    required Color colorStatus,
    required String statusName,
    required String employeeLine,
    required String leaveLine,
    required String submittedLine,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // หัวบรรทัด + badge สถานะ
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    '[$typeName]',
                    style: const TextStyle(
                      color: AppTheme.ognOrangeGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      reason,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
              decoration: BoxDecoration(
                color: colorStatus,
                borderRadius: const BorderRadius.all(Radius.circular(35)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.fiber_manual_record,
                      size: 10, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    statusName,
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
        const SizedBox(height: 6),
        // รายละเอียด
        Text(employeeLine,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(leaveLine,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        Text(
          submittedLine,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  String numberToStringCurrency(int? amount) {
    final formattedAmount =
        NumberFormat('#,###.##', 'en_US').format(amount ?? 0);
    return "$formattedAmount บาท";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
