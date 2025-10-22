import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/request_doc_controller.dart';
import 'package:organics_salary/pages/request_doc/screen/confirm_sent_request_screen.dart';
import 'package:organics_salary/pages/salary/salary_page.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum DocType { salaryCert, workCert }

class LockCheck {
  final bool locked;
  final int? statusNumber;
  final DateTime? createdAt;
  const LockCheck({required this.locked, this.statusNumber, this.createdAt});
}

LockCheck _isLockedForCurrentMonth(
  DocType type,
  List<Map<String, dynamic>> data,
) {
  final now = DateTime.now();
  final int m = now.month;
  final int y = now.year;

  // คีย์เวิร์ดสำหรับจับจาก detail
  final salaryKeywords = <String>[
    'ขอหนังสือรับรองเงินเดือน',
  ];
  final workKeywords = <String>[
    'ขอหนังสือรับรองการทำงาน',
  ];

  bool matchDetail(String? d) {
    if (d == null) return false;
    final text = d.trim();
    if (type == DocType.salaryCert) {
      return salaryKeywords.any((k) => text.contains(k));
    } else {
      return workKeywords.any((k) => text.contains(k));
    }
  }

// ลูปและหยุดทันทีเมื่อเจอรายการแรกที่ซ้ำในเดือน/ปีเดียวกัน
  for (final item in data) {
    try {
      final detail = item['detail'] as String?;
      if (!matchDetail(detail)) continue;

      final createdRaw = item['created_at'] as String?;
      if (createdRaw == null) continue;

      final created = DateTime.parse(createdRaw).toLocal();
      if (created.month == m && created.year == y) {
        // ดึง status_number ให้ครบทุกกรณีที่อาจเจอใน payload
        final statusNum = (item['status_logs']?['status_number'] ??
            item['status_follower_data']?['curent_status']?['status_number'] ??
            item['status_assigner_data']?['curent_status']
                ?['status_number']) as int?;

        // ถ้าเป็น 99 หรือ 3 -> ไม่ถือว่าล็อก (ข้ามและไปเช็คอันถัดไป)
        if (statusNum == 99 || statusNum == 3) {
          continue;
        }

        // อื่นๆ -> ล็อก (ห้ามส่งซ้ำ)
        return LockCheck(
            locked: true, statusNumber: statusNum, createdAt: created);
      }
    } catch (_) {
      // ข้ามกรณี parse ไม่ได้
    }
  }

  return const LockCheck(locked: false);
}

class SentRequestScreen extends StatefulWidget {
  const SentRequestScreen({super.key});

  @override
  State<SentRequestScreen> createState() => _SentRequestScreenState();
}

class _SentRequestScreenState extends State<SentRequestScreen> {
  final RequestDocController requestDocController =
      Get.put(RequestDocController());
  final DateRangePickerController _controller = DateRangePickerController();
  final _formKey = GlobalKey<FormState>(); // <-- สร้าง FormKey

  bool salaryCert = false; // หนังสือรับรองเงินเดือน
  bool workCert = false; // หนังสือรับรองการทำงาน

  Future<void> _goToConfirm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => const ConfirmSentRequestScreen()),
    );
    if (result == "go_tab2") {
      final tabController = DefaultTabController.of(context);
      if (tabController != null) {
        tabController.animateTo(1); // Tab index 1 = ประวัติคำขอ
      }
    }
  }

  @override
  void initState() {
    final DateTime currentDate = DateTime.now();
    print('NOW $currentDate');

    final DateTime previousMonth =
        DateTime(currentDate.year, currentDate.month - 0, currentDate.day);

    salaryController.c_startDate.value =
        DateFormat('MMMM yyyy').format(previousMonth).toString();
    salaryController.c_endDate.value =
        DateFormat('MMMM yyyy').format(previousMonth).toString();

    _controller.selectedDate = previousMonth;

    int currentMonth = previousMonth.month;
    int currentYear = previousMonth.year;

    salaryController.monthSelected.value = currentMonth.toString();
    salaryController.yearSelected.value = currentYear.toString();

    salaryController.loadData();

    super.initState();
    requestDocController.loadDataSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
        child: Form(
          key: _formKey, // <-- ห่อด้วย Form
          child: ListView(
            children: [
              const Text(
                'เลือกเอกสารที่ต้องการ',
                style: TextStyle(
                  color: AppTheme.ognGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ========== Checkbox: หนังสือรับรองเงินเดือน ==========
                    Obx(() {
                      final list = List<Map<String, dynamic>>.from(
                          requestDocController.transectionSuccessList);
                      final lock =
                          _isLockedForCurrentMonth(DocType.salaryCert, list);

                      if (lock.locked && requestDocController.salaryCert.value) {
                        requestDocController.salaryCert.value = false;
                      }

                      return CheckboxListTile(
                        title: Text(
                          'หนังสือรับรองเงินเดือน',
                          style: TextStyle(
                            color: lock.locked
                                ? Colors.grey
                                : AppTheme.ognGreen, // <-- เปลี่ยนสีตามสถานะ
                            fontSize: 16,
                          ),
                        ),
                        subtitle: lock.locked
                            ? const Text(
                                'คุณขอไปแล้วในเดือน',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              )
                            : null,
                        value: requestDocController.salaryCert.value,
                        onChanged: lock.locked
                            ? null
                            : (value) {
                                requestDocController.salaryCert.value =
                                    value ?? false;
                              },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    }),

                    // ========== Checkbox: หนังสือรับรองการทำงาน ==========
                    Obx(() {
                      final list = List<Map<String, dynamic>>.from(
                          requestDocController.transectionSuccessList);
                      final lock =
                          _isLockedForCurrentMonth(DocType.workCert, list);

                      if (lock.locked && requestDocController.workCert.value) {
                        requestDocController.workCert.value = false;
                      }

                      return CheckboxListTile(
                        title: Text(
                          'หนังสือรับรองการทำงาน',
                          style: TextStyle(
                            color: lock.locked
                                ? Colors.grey
                                : AppTheme.ognGreen, // <-- เช่นเดียวกัน
                            fontSize: 16,
                          ),
                        ),
                        subtitle: lock.locked
                            ? const Text(
                                'คุณขอไปแล้วในเดือน',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              )
                            : null,
                        value: requestDocController.workCert.value,
                        onChanged: lock.locked
                            ? null
                            : (value) {
                                requestDocController.workCert.value =
                                    value ?? false;
                              },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'ระบุเหตุผลในเอกสาร',
                style: TextStyle(
                  color: AppTheme.ognGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: requestDocController.inputCauseController,
                autofocus: false,
                style: const TextStyle(color: AppTheme.ognMdGreen, fontSize: 14),
                minLines: 6,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'กรุณากรอกเหตุผล';
                  }
                  return null;
                },
                onChanged: (val) => requestDocController.inputCause.value = val,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'กรอกเหตุผล',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.ognOrangeGold,
          ),
          // ===================== onPressed: ใช้โค้ด "ชุดเดิมของคุณ" =====================
          onPressed: () {
            // ตรวจสอบว่ามีเอกสารถูกเลือก
            if (!requestDocController.salaryCert.value &&
                !requestDocController.workCert.value) {
              Get.dialog(
                AlertDialog(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  actionsAlignment: MainAxisAlignment.center,
                  backgroundColor: Colors.white,
                  titlePadding: EdgeInsets.zero,
                  title: Container(
                    width: double.infinity,
                    color: AppTheme.ognSmGreen,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: const Text(
                      "แจ้งเตือน",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: const Text(
                    "กรุณาเลือกเอกสารอย่างน้อย 1 รายการ",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ognSmGreen,
                      ),
                      child: const Text("ตกลง",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
              return;
            }

            // ตรวจสอบ validator ของ Form
            if (_formKey.currentState!.validate()) {
              _goToConfirm();
            }
          },
          child: const Text(
            'ส่งคำขอ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
