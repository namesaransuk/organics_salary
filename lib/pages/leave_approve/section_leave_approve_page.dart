import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/controllers/leave_approve_controller.dart';
import 'package:organics_salary/pages/leave_approve/section_screen/detail_approve_screen.dart';
import 'package:organics_salary/pages/leave_approve/section_screen/history_leave_approve_screen.dart';
import 'package:organics_salary/theme.dart';

// import 'package:stepper_a/stepper_a.dart';
class SectionLeaveApprovePage extends StatefulWidget {
  const SectionLeaveApprovePage({super.key});

  @override
  State<SectionLeaveApprovePage> createState() {
    return _SectionLeaveApprovePageState();
  }
}

class _SectionLeaveApprovePageState extends State<SectionLeaveApprovePage>
    with TickerProviderStateMixin {
  // final leaveApproveController = Get.find<LeaveApproveController>();
  final LeaveApproveController leaveApproveController =
      Get.put(LeaveApproveController());

  dynamic item;
  dynamic mode;
  final box = GetStorage();

  @override
  void initState() {
    // leaveApproveController.loadLeaveTotalUsed();
    // leaveApproveController.loadFlowLeave();
    super.initState();
  }

  Future<bool> loadItemData() async {
    // 1) รับ arguments แบบ dynamic
    final args = Get.arguments;

    // 2) รองรับทั้งรูปแบบ {'treId': 894} หรือ 894 ตรง ๆ
    final treIdDynamic = (args is Map) ? args['treId'] : args;
    final treIdStr = treIdDynamic?.toString();

    // 3) โหลดเฉพาะข้อมูลที่ต้องการด้วย treId
    await leaveApproveController.loadDataSection(treId: treIdDynamic);

    // 4) หา item จาก list ที่ได้มา
    item = leaveApproveController.leaveApproveSectionList.firstWhere(
      (i) => i['id']?.toString() == treIdStr,
      orElse: () => null,
    );

    if (item == null) return true; // จะไปขึ้น "ไม่พบข้อมูล" ใน UI ต่อ

    // 5) logic เดิม
    mode = item['status_logs']?['status_number'] != 4 &&
            item['status_logs']?['status_number'] != 5
        ? 1
        : 2;

    await leaveApproveController.loadLeaveTotalUsed(item['emp_id']);
    await leaveApproveController.loadFlowLeave();

    return true;
  }

  // Future<bool> loadItemData() async {
  //   // leaveApproveController.searchStartDate.value = '';
  //   // leaveApproveController.searchEndDate.value = '';

  //   await leaveApproveController.loadDataSection();

  //   final arguments = Get.arguments;
  //   item = leaveApproveController.leaveApproveSectionList.firstWhere(
  //     (i) => i['id'].toString() == arguments.toString(),
  //     orElse: () => null,
  //   );
  //   mode = item['status_logs']['status_number'] != 4 &&
  //           item['status_logs']['status_number'] != 5
  //       ? 1
  //       : 2;

  //   await leaveApproveController.loadLeaveTotalUsed(item['emp_id']);
  //   await leaveApproveController.loadFlowLeave();

  //   // print('start ${leaveApproveController.searchStartDate.value}');
  //   // print('end ${leaveApproveController.searchEndDate.value}');
  //   // print('start ${leaveApproveController.c_startDate.value}');
  //   // print('end ${leaveApproveController.c_endDate.value}');
  //   // print(arguments);
  //   // print(item);

  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    // final arguments = Get.arguments as Map<String, dynamic>;
    // final item = arguments['item'];
    // final mode = arguments['mode'];

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
          'คำขอลางาน',
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (item == null) {
              return const Center(
                child: Text('ไม่พบข้อมูล'),
              );
            }

            processApproval(item, box.read('id'));
            final uniqueApprovedUsers = approvedUsers.toSet().toList();
            final userAprove = uniqueApprovedUsers.join('\n');
            leaveApproveController.userAprove.value = userAprove;
            // print('canApprove: $canApprove');
            // print('canNotApprove: $canNotApprove');
            // print('approvedUsers:\n${approvedUsers.join('\n')}');
            // print('userAprove:${uniqueApprovedUsers}');
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ButtonsTabBar(
                              buttonMargin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              backgroundColor: AppTheme.ognGreen,
                              unselectedBackgroundColor: Colors.grey[300],
                              unselectedLabelStyle: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              labelStyle: GoogleFonts.kanit(
                                textStyle: TextStyle(color: Colors.white),
                              ),
                              radius: 100,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              tabs: [
                                Tab(
                                  text: "รายละเอียด",
                                ),
                                Tab(
                                  text: "ประวัติการลา",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: <Widget>[
                                DetailApproveScreen(item, mode),
                                HistoryLeaveApproveScreen(item, mode),
                              ],
                            ),
                          ),
                          mode == 1
                              // (item['hierarchys_request'] as List?)?.any(
                              //         (e) =>
                              //             e?['head_parent_hierarchys']
                              //                 ?['emp_id'] ==
                              //             box.read('id')) ==
                              // true
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 10, 25, 12),
                                  child: Row(
                                    children: [
                                      canNotApprove
                                          ? Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppTheme.ognOrangeGold,
                                                  ),
                                                  // onPressed: submit,
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        'cause-leave-not-approve',
                                                        arguments: item);
                                                  },
                                                  child: const SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Center(
                                                        child: Text(
                                                          'ไม่อนุมัติ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      canApprove
                                          ? Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppTheme.ognMdGreen,
                                                  ),
                                                  // onPressed: submit,
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      'confirm-leave-approve',
                                                      arguments: {
                                                        'item': item,
                                                        'mode': 1,
                                                      },
                                                    );
                                                  },
                                                  child: const SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Center(
                                                        child: Text(
                                                          'อนุมัติ',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 12,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  bool canApprove = false;
  bool canNotApprove = false;
  List<String> approvedUsers = [];
  String userAprove = '';
  int countHours = 0;
  int displaySave = 0;

  void processApproval(Map<String, dynamic> detailLeave, int userId) {
    List<dynamic>? hierarchys = detailLeave['hierarchys_request'];
    Map<String, dynamic>? headParent = hierarchys?[0]['head_parent_hierarchys'];
    List<dynamic> nextPermissions =
        headParent?['next_hierarchys_permissions'] ?? [];
    Map<String, dynamic>? empHeadData = headParent?['employee_data'];

    // print('nextPermissions : ${nextPermissions}');

    double countHours = 0;
    int? displaySave;

    if (empHeadData != null) {
      String userName =
          "ผู้อนุมัติหลัก : ${empHeadData['fname_th']} ${empHeadData['lname_th']}";
      approvedUsers.add(userName);
    }

    for (var permission in nextPermissions) {
      int displayOrder = permission['display_order'] ?? 0;
      if (displaySave != displayOrder) {
        countHours += permission['timeout_hours'] ?? 0;
      }

      Map<String, dynamic>? nextEmp =
          permission['next_approve']?['employee_data'];
      if (nextEmp != null) {
        String nextUserName =
            "ถัดไปลำดับที่${displayOrder} : ${nextEmp['fname_th']} ${nextEmp['lname_th']}"
            "\nเมื่อคนลำดับก่อนหน้าไม่อนุมัติภายใน ${countHours.toInt()} ช.ม.";
        approvedUsers.add(nextUserName);
      }

      displaySave = displayOrder;

      /// ✅ ตรวจสอบสิทธิ์ผู้ใช้ (ใช้ employeeId ของผู้ใช้ที่ล็อกอิน)
      String currentUserId =
          box.read('id').toString(); // จาก storage หรือ token
      String nextEmpId = permission['next_approve']?['emp_id'].toString() ?? '';

      Map<String, dynamic>? flowApprove =
          permission['next_approve']?['flow_aprove'];
      int currentStatus = detailLeave['status'];

      if (nextEmpId == currentUserId && flowApprove != null) {
        if (flowApprove['step_approve_number'] == 4 &&
            currentStatus != flowApprove['step_approve_number']) {
          canApprove = true;
        }
        if (flowApprove['status_reject_number'] == 5 &&
            currentStatus != flowApprove['step_approve_number']) {
          canNotApprove = true;
        }
        break;
      }
    }

    DateTime currentTime = DateTime.now();
    DateTime requestTime = DateTime.parse(detailLeave['updated_at']);
    Duration diff = currentTime.difference(requestTime);
    double hours = diff.inSeconds / 3600;

    print('hours : ${hours}');
    print('countHours : ${countHours}');

    if (hours >= countHours) {
      String headEmpId = headParent?['emp_id']?.toString() ?? '';
      // print('countHours : ${headEmpId == box.read('id').toString()}');

      if (headEmpId == box.read('id').toString()) {
        Map<String, dynamic>? flow = headParent?['flow_aprove'];
        int currentStatus = detailLeave['status'];

        // print('flow : ${flow}');

        if (flow != null) {
          if (flow['step_approve_number'] == 4 &&
              currentStatus != flow['step_approve_number']) {
            canApprove = true;
          }
          if (flow['status_reject_number'] == 5 &&
              currentStatus != flow['step_approve_number']) {
            canNotApprove = true;
          }
        }
      }
    } else {
      if (empHeadData?['id'].toString() == box.read('id').toString()) {
        var flowApprove = nextPermissions.first['next_approve']?['flow_aprove'];
        int currentStatus = detailLeave['status'];

        if (flowApprove != null) {
          if (flowApprove['step_approve_number'] == 4 &&
              currentStatus != flowApprove['step_approve_number']) {
            canApprove = true;
          }
          if (flowApprove['status_reject_number'] == 5 &&
              currentStatus != flowApprove['step_approve_number']) {
            canNotApprove = true;
          }
        }
      } else {
        canApprove = false;
        canNotApprove = false;
      }
    }
  }
}
