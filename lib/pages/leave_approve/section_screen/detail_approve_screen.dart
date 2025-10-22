import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/leave_approve_controller.dart';
import 'package:organics_salary/theme.dart';

// ========================= Helpers (Safe Access / Format) =========================
T? asT<T>(dynamic v) => v is T ? v : null;

Map<String, dynamic>? asMap(dynamic v) =>
    v is Map ? Map<String, dynamic>.from(v as Map) : null;

List asList(dynamic v) => v is List ? v : const [];

String? safeStr(dynamic v) {
  if (v == null) return null;
  final s = v.toString().trim();
  return s.isEmpty ? null : s;
}

int? safeInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is String) {
    return int.tryParse(v);
  }
  return null;
}

DateTime? parseDate(dynamic v) {
  final s = safeStr(v);
  if (s == null) return null;
  try {
    return DateTime.parse(s);
  } catch (_) {
    return null;
  }
}

String? formatDate(DateTime? dt, String pattern, {String? locale}) {
  if (dt == null) return null;
  try {
    final f = DateFormat(pattern, locale);
    return f.format(dt);
  } catch (_) {
    return null;
  }
}

/// สร้างชื่อผู้อนุมัติอย่างปลอดภัย (ซ่อนทั้งแถวถ้าสร้างไม่ได้)
String? buildApproverName(Map<String, dynamic>? data) {
  if (data == null) return null;

  final prefix = safeStr(data['prefix']);
  final fNames = asMap(data['fnames']);
  final lNames = asMap(data['lnames']);

  final fList = asList(fNames?['multitexts']);
  final lList = asList(lNames?['multitexts']);

  final fName = fList.isNotEmpty ? safeStr(asMap(fList[0])?['name']) : null;
  final lName = lList.isNotEmpty ? safeStr(asMap(lList[0])?['name']) : null;

  final parts = [prefix, fName, lName].whereType<String>().toList();
  return parts.isEmpty ? null : parts.join(' ');
}

/// rowDetail ที่รับ String? และ fallback เป็น "-" (เพื่อใช้ที่เดียวจบ)
Widget rowDetail(BuildContext context, IconData icon, String title, String? value,
    {bool hideIfEmpty = false, TextAlign valueAlign = TextAlign.right}) {
  final show = safeStr(value) ?? '-';
  if (hideIfEmpty && show == '-') return const SizedBox.shrink();

  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.ognOrangeGold, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$title :',
              style: TextStyle(color: AppTheme.ognMdGreen, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              show,
              textAlign: valueAlign,
              style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 12),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
    ],
  );
}

// ========================= Screen =========================
class DetailApproveScreen extends StatefulWidget {
  final dynamic item;
  final dynamic mode;

  const DetailApproveScreen(this.item, this.mode, {Key? key}) : super(key: key);

  @override
  State<DetailApproveScreen> createState() => _DetailApproveScreenState();
}

class _DetailApproveScreenState extends State<DetailApproveScreen> {
  late bool screenMode;

  final LeaveApproveController leaveApproveController =
      Get.put(LeaveApproveController());

  @override
  Widget build(BuildContext context) {
    final baseUrl = dotenv.env['ASSET_URL'] ?? '';
    final Map<String, dynamic> item =
        asMap(widget.item) ?? <String, dynamic>{};
    final int mode = safeInt(widget.mode) ?? 0;

    // ------- Safe reads -------
    final statusLogs = asMap(item['status_logs']);
    final statusName = safeStr(statusLogs?['status_name']) ?? 'รายการใหม่';
    final statusNumber = safeInt(statusLogs?['status_number']) ?? 0;
    final approvedAtTh = safeStr(statusLogs?['created_at_th']);

    final leaveHistory = asMap(item['leave_history']);
    final leaveHistView = asMap(leaveHistory?['leave_histories_view']);
    final leaveDetail = asMap(leaveHistory?['leave_detail']);

    // รวมวันเวลา (รองรับ null ทุกจุด)
    final totalWorkDays = safeInt(leaveHistView?['total_workdays_used']) ?? 0;
    final leaveHours = safeInt(leaveHistView?['leave_hours']) ?? 0;
    final leaveMinutes = safeInt(leaveHistView?['leave_minutes']) ?? 0;

    // วันที่/เวลา
    final createdAt = parseDate(item['created_at']);
    final updatedAt = parseDate(item['updated_at']);
    final startDate = parseDate(leaveHistory?['start_date']);
    final endDate = parseDate(leaveHistory?['end_date']);

    final formattedLeaveRequestDate = formatDate(
      createdAt,
      "dd MMMM yyyy HH:mm",
      locale: 'th_TH',
    );
    final formattedLeaveUpdateDate = formatDate(
      updatedAt,
      "dd MMMM yyyy HH:mm",
      locale: 'th_TH',
    );

    final startDateDay = formatDate(startDate, "dd MMMM yyyy", locale: 'th_TH');
    final startDateTime = formatDate(startDate, "HH:mm", locale: 'th_TH');
    final endDateDayTime =
        formatDate(endDate, "dd MMMM yyyy HH:mm", locale: 'th_TH');
    final endDateTime = formatDate(endDate, "HH:mm", locale: 'th_TH');

    final formattedLeaveStartDate =
        (startDateDay != null && startDateTime != null)
            ? '$startDateDay ($startDateTime น.)'
            : null;

    final formattedLeaveEndDate =
        (endDateDayTime != null && endDateTime != null)
            ? '$endDateDayTime ($endDateTime น.)'
            : null;

    // ผู้ขอลา
    final userTx = asMap(item['user_transection_data']);
    final userFullName = [
      safeStr(userTx?['fname_th']),
      safeStr(userTx?['lname_th'])
    ].whereType<String>().join(' ');
    final userDept = safeStr(userTx?['departments_th']);
    final requester =
        [userFullName.isEmpty ? null : userFullName, userDept == null ? null : '($userDept)']
            .whereType<String>()
            .join(' ');

    // ประเภทการลา
    final leaveTypeName = safeStr(
        asMap(asMap(leaveDetail?['leavetype']) )?['holiday_name_type']);

    // sub leave
    final subLeave = asMap(leaveDetail?['sub_leave']);
    final subLeaveName = safeStr(subLeave?['holiday_name_type']);
    final subDetail = safeStr(leaveDetail?['subDetail']);

    // ไฟล์แนบ
    final leaveSubImage = asMap(item['leave_sub_image']);
    final subImagePath = safeStr(leaveSubImage?['file_path']);

    final leaveMainImage = asMap(item['leave_main_image']);
    final mainImagePath = safeStr(leaveMainImage?['file_path']);

    // เหตุผล/รายละเอียดเพิ่ม/ผู้ปฏิบัติงานแทน
    final reasonLeave = safeStr(leaveHistory?['reason_leave']);
    final moreDetail = safeStr(leaveDetail?['detail']);
    final assigner = asMap(leaveDetail?['assigner_data']);
    final assignerName = [
      safeStr(assigner?['fname_th']),
      safeStr(assigner?['lname_th'])
    ].whereType<String>().join(' ');
    final assignerDept = safeStr(assigner?['departments_th']);
    final assignerText =
        [assignerName.isEmpty ? null : assignerName, assignerDept == null ? null : '($assignerDept)']
            .whereType<String>()
            .join(' ');

    // ผู้อนุมัติ (ซ่อน ถ้าไม่มี)
    final approverName = buildApproverName(asMap(item['recipient_data']));

    // สถานะสี
    Color colorStatus;
    switch (safeInt(item['status']) ?? 0) {
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
      case 1:
      default:
        colorStatus = Colors.grey;
        break;
    }

    // ผู้มีสิทธิ์อนุมัติ (RichText)
    final approveLines = safeStr(leaveApproveController.userAprove.value)
            ?.trim()
            .split('\n')
            .where((line) =>
                !line.contains('ถัดไปลำดับที่1') && !line.contains('0 ช.ม.'))
            .toList() ??
        const <String>[];

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== แถบสถานะ =====
            Row(
              children: [
                Icon(FontAwesomeIcons.circleInfo,
                    color: AppTheme.ognOrangeGold, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text('สถานะ :',
                      style:
                          TextStyle(color: AppTheme.ognMdGreen, fontSize: 12)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: colorStatus,
                      borderRadius: const BorderRadius.all(Radius.circular(35)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          statusName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ===== รายละเอียดหลัก =====
            rowDetail(context, FontAwesomeIcons.briefcaseMedical, 'วันที่แจ้งลา',
                safeStr(item['format_date'])),
            rowDetail(context, FontAwesomeIcons.solidUser, 'ผู้แจ้งลา', requester),
            rowDetail(context, FontAwesomeIcons.solidCalendarDays,
                'ตั้งแต่วันที่/เวลา', formattedLeaveStartDate),
            rowDetail(context, FontAwesomeIcons.solidCalendarDays,
                'สิ้นสุดตั้งวันที่/เวลา', formattedLeaveEndDate),

            // รวมวันเวลา
            rowDetail(
                context,
                FontAwesomeIcons.solidClock,
                'รวมวันเวลา',
                '$totalWorkDays วัน $leaveHours ชม. $leaveMinutes นาที'),

            // ประเภทการลา
            rowDetail(context, Icons.work, 'ประเภทการลา', leaveTypeName),

            // sub leave (แสดงเมื่อมี)
            if (subLeaveName != null || subDetail != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${subLeaveName ?? 'ประเภทย่อย'} :',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    subDetail ?? '-',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // ไฟล์แนบเพิ่มเติม (sub)
            if (subImagePath != null && baseUrl.isNotEmpty) ...[
              const Text('ไฟล์แนบเพิ่มเติม :',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network('$baseUrl/$subImagePath'),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // เหตุผล/รายละเอียด/ผู้แทน
            rowDetail(context, FontAwesomeIcons.solidCircleQuestion, 'สาเหตุการลา',
                reasonLeave),
            rowDetail(context, FontAwesomeIcons.solidRectangleList, 'รายละเอียดเพิ่ม',
                moreDetail, hideIfEmpty: false),
            rowDetail(context, FontAwesomeIcons.solidUser, 'ผู้ปฏิบัติงานแทน',
                assignerText),

            // ไฟล์แนบหลัก
            if (mainImagePath != null && baseUrl.isNotEmpty) ...[
              Row(
                children: [
                  Icon(FontAwesomeIcons.solidFileImage,
                      color: AppTheme.ognOrangeGold, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('ไฟล์แนบเพิ่มเติม :',
                        style: TextStyle(
                            color: AppTheme.ognMdGreen, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network('$baseUrl/$mainImagePath'),
                ),
              ),
            ],

            const Divider(),

            // ===== ผู้มีสิทธิ์อนุมัติ (RichText) =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.idCard,
                    color: AppTheme.ognOrangeGold, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'ผู้มีสิทธ์อนุมัติ',
                    style: TextStyle(
                      color: AppTheme.ognMdGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (approveLines.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.kanit(fontSize: 14),
                    children: approveLines.expand((line) {
                      final isWarning = line.contains('เมื่อคนลำดับก่อนหน้า');
                      final isHead = line.contains('ผู้อนุมัติหลัก');
                      return [
                        TextSpan(
                          text: '$line\n',
                          style: TextStyle(
                            color:
                                isWarning ? Colors.red : AppTheme.ognGreen,
                            height: 1.3,
                          ),
                        ),
                        if (isHead) const TextSpan(text: '\n'),
                      ];
                    }).toList(),
                  ),
                ),
              ),

            // ===== รายละเอียดการอนุมัติ (แสดงเมื่อ mode == 2) =====
            if (mode == 2) ...[
              Text('รายละเอียดการอนุมัติ',
                  style: TextStyle(
                      color: AppTheme.ognGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // ผู้อนุมัติ: ซ่อนทั้งแถวหากไม่มีข้อมูล
              if (approverName != null)
                rowDetail(
                    context, FontAwesomeIcons.userTie, 'ผู้อนุมัติ', approverName),

              // วันที่อนุมัติ: เฉพาะเมื่อ status == 4
              if (statusNumber == 4 && approvedAtTh != null)
                rowDetail(context, FontAwesomeIcons.solidCalendarCheck,
                    'วันที่อนุมัติ', approvedAtTh),

              // ไม่อนุมัติ: status == 5
              if (statusNumber == 5) ...[
                rowDetail(context, FontAwesomeIcons.solidCalendarXmark,
                    'วันที่ไม่อนุมัติ', approvedAtTh),
                rowDetail(context, FontAwesomeIcons.solidNoteSticky,
                    'เหตุผลที่ไม่อนุมัติ', safeStr(item['detail'])),
              ],
            ],
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
