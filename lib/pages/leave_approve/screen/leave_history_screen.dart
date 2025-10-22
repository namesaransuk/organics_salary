import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/leave_approve_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:intl/intl.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  // final LeaveApproveController leaveApproveController =
  //     Get.put(LeaveApproveController());
  final leaveApproveController = Get.find<LeaveApproveController>();
  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => leaveApproveController.leaveApproveHistoryList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: leaveApproveController.leaveApproveHistoryList
                          .map((item) {
                        DateTime dateTime =
                            DateTime.parse(item['created_at'].toString());
                        final thaiYear = dateTime.year + 543;
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
                        final thaiMonth = thaiMonths[dateTime.month - 1];
                        String formattedDate =
                            '${dateTime.day} $thaiMonth $thaiYear';

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

                        DateTime leaveStartDateTime = DateTime.parse(
                            item['leave_history']?['start_date']);
                        DateTime leaveEndDateTime =
                            DateTime.parse(item['leave_history']?['end_date']);

                        String formattedLeaveStartDate =
                            DateFormat("dd/MM/yyyy HH:mm")
                                .format(leaveStartDateTime);
                        String formattedLeaveEndDate =
                            DateFormat("dd/MM/yyyy HH:mm")
                                .format(leaveEndDateTime);

                        return Container(
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.05,
                                blurRadius: 2,
                                offset: const Offset(0.5, 0.025),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                'leave-section-approve',
                                arguments: item['id'],
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '[${item['leave_history']?['leave_detail']?['leavetype']?['holiday_name_type']}]',
                                                              style:
                                                                  const TextStyle(
                                                                color: AppTheme
                                                                    .ognOrangeGold,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Expanded(
                                                              child: Text(
                                                                '${item['leave_history']?['reason_leave']}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style:
                                                                    const TextStyle(
                                                                  color: AppTheme
                                                                      .ognGreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3,
                                                                horizontal: 12),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorStatus,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          35)),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .fiber_manual_record,
                                                              size: 10,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            const SizedBox(
                                                                width: 2),
                                                            Text(
                                                              item['status_logs']
                                                                      [
                                                                      'status_name'] ??
                                                                  'รายการใหม่',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'ชื่อพนักงาน : ${item['user_transection_data']?['fname_th']} ${item['user_transection_data']?['lname_th']} (${item['user_transection_data']?['departments_th']})',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          'วันที่ลา : ${formattedLeaveStartDate} - ${formattedLeaveEndDate}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'วันที่ส่งข้อมูล : $formattedDate',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/menu/part-time.png',
                  width: MediaQuery.of(context).size.width *
                      (screenMode ? 0.10 : 0.25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'ไม่มีข้อมูลของวันที่เลือก',
                  style: TextStyle(
                    color: Colors.grey[400],
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
    );
  }

  // Widget _buildCardRow(List<dynamic> row) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
  //     child: Container(
  //       height: 75,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(
  //           color: Colors.grey.shade400,
  //           width: 0.5,
  //         ),
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.shade300.withOpacity(0.5),
  //             spreadRadius: 0.5,
  //             blurRadius: 0.5,
  //             offset: const Offset(1, 0.5),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Container(
  //             alignment: Alignment.center,
  //             width: 100,
  //             child: Text(
  //               row[2],
  //               style: const TextStyle(
  //                 color: AppTheme.ognMdGreen,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(width: 2),
  //           ...List.generate(6, (index) {
  //             if (row.length < 15) {
  //               row.addAll(List.filled(15 - row.length, 'N/A'));
  //             }

  //             Color colorStatus = Colors.grey;
  //             var indexValue = row[4 + index * 2];
  //             // String test = '+08:01';
  //             if (indexValue != row[10]) {
  //               if (indexValue.toString().startsWith('+')) {
  //                 colorStatus = AppTheme.ognMdGreen;
  //               } else {
  //                 colorStatus = AppTheme.ognOrangeGold;
  //               }
  //             } else {
  //               if (indexValue.toString().startsWith('+')) {
  //                 colorStatus = AppTheme.ognOrangeGold;
  //               } else {
  //                 colorStatus = AppTheme.ognMdGreen;
  //               }
  //             }

  //             return Container(
  //               alignment: Alignment.center,
  //               width: 70,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     row[3 + index * 2] != 'N/A' ? row[3 + index * 2] : '-',
  //                     style: const TextStyle(
  //                       color: AppTheme.ognMdGreen,
  //                       fontSize: 12,
  //                     ),
  //                   ),
  //                   row[4 + index * 2] != 'N/A'
  //                       ? Column(
  //                           children: [
  //                             const SizedBox(height: 5),
  //                             Container(
  //                               padding: const EdgeInsets.symmetric(
  //                                   vertical: 2, horizontal: 12),
  //                               decoration: BoxDecoration(
  //                                 color: colorStatus,
  //                                 borderRadius: const BorderRadius.all(
  //                                   Radius.circular(35),
  //                                 ),
  //                               ),
  //                               child: Text(
  //                                 // test,
  //                                 row[4 + index * 2],
  //                                 style: const TextStyle(
  //                                   color: Colors.white,
  //                                   fontSize: 12,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                       : Container(),
  //                 ],
  //               ),
  //             );
  //           }),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildTimeSlot(String title, String timeIn, String timeOut,
  //     {bool highlight = false}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: const TextStyle(
  //             color: Colors.white70, fontWeight: FontWeight.w600),
  //       ),
  //       const SizedBox(height: 5),
  //       Text(
  //         "เข้า: $timeIn",
  //         style: TextStyle(
  //             color: highlight ? Colors.tealAccent : Colors.white,
  //             fontSize: 12),
  //       ),
  //       Text(
  //         "ออก: $timeOut",
  //         style: TextStyle(
  //             color: highlight ? Colors.tealAccent : Colors.white,
  //             fontSize: 12),
  //       ),
  //     ],
  //   );
  // }

  String numberToStringCurrency(int? amount) {
    String formattedAmount =
        NumberFormat('#,###.##', 'en_US').format(amount ?? 0);
    return "$formattedAmount บาท";
  }

  // String _getThaiMonth(String month) {
  //   final formatter = DateFormat('MMMM', 'th');
  //   return formatter.format(DateTime(2024, int.parse(month)));
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
