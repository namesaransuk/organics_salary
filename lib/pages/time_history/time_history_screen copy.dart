// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:organics_salary/controllers/time_history_controller.dart';
// import 'package:organics_salary/theme.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class TimeHistoryPage extends StatefulWidget {
//   const TimeHistoryPage({super.key});

//   @override
//   State<TimeHistoryPage> createState() => _TimeHistoryPageState();
// }

// class _TimeHistoryPageState extends State<TimeHistoryPage> {
//   late bool screenMode;

//   final TimeHistoryController timeHistoryController =
//       Get.put(TimeHistoryController());
//   final DateRangePickerController _controller = DateRangePickerController();

//   @override
//   void initState() {
//     final DateTime currentDate = DateTime.now();
//     timeHistoryController.c_startDate.value = DateFormat('MMMM yyyy')
//         .format(currentDate)
//         .replaceFirst(
//           '${currentDate.year}',
//           '${currentDate.year + 543}',
//         )
//         .toString();
//     timeHistoryController.c_endDate.value = DateFormat('MMMM yyyy')
//         .format(currentDate.add(const Duration(days: 0)))
//         .replaceFirst(
//           '${currentDate.year}',
//           '${currentDate.year + 543}',
//         )
//         .toString();

//     _controller.selectedRange = PickerDateRange(
//         currentDate.subtract(const Duration(days: 0)), currentDate);

//     int currentMonth = currentDate.month;
//     int currentYear = currentDate.year;

//     timeHistoryController.monthSelected.value = currentMonth.toString();
//     timeHistoryController.yearSelected.value = currentYear.toString();

//     timeHistoryController.loadData();

//     super.initState();
//   }

//   void selectionChanged(DateRangePickerSelectionChangedArgs args) {
//     DateTime selectedDate = args.value; // ในกรณีนี้ args.value จะเป็น DateTime

//     // แปลงวันที่ที่เลือกเป็นรูปแบบที่ต้องการ
//     timeHistoryController.c_startDate.value = DateFormat('MMMM yyyy')
//         .format(selectedDate)
//         .replaceFirst(
//           '${selectedDate.year}',
//           '${selectedDate.year + 543}',
//         )
//         .toString();

//     timeHistoryController.c_endDate.value = DateFormat('MMMM yyyy')
//         .format(selectedDate)
//         .replaceFirst(
//           '${selectedDate.year}',
//           '${selectedDate.year + 543}',
//         )
//         .toString();

//     int currentMonth = selectedDate.month;
//     int currentYear = selectedDate.year;

//     timeHistoryController.monthSelected.value = currentMonth.toString();
//     timeHistoryController.yearSelected.value = currentYear.toString();
//   }

//   @override
//   void dispose() {
//     // leaveHistoryController.dispose();
//     // salaryController.clearHistory();
//     // Get.delete<LeaveHistoryController>();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData.fallback(),
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           color: AppTheme.ognOrangeGold,
//           onPressed: () => Navigator.pop(context, false),
//         ),
//         title: const Text(
//           'สถิติการเข้าออกงาน',
//           style: TextStyle(
//             color: AppTheme.ognGreen,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.calendar_month_rounded,
//                         color: AppTheme.ognOrangeGold,
//                         size: 30,
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'เดือน${timeHistoryController.c_startDate.value}',
//                         // 'ตั้งแต่ ${timeHistoryController.c_startDate.value} - ${timeHistoryController.c_endDate.value}',
//                         style: const TextStyle(color: AppTheme.ognGreen),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: InkWell(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return dateSelected();
//                         },
//                       );
//                     },
//                     child: const Icon(
//                       Icons.tune_rounded,
//                       color: AppTheme.ognOrangeGold,
//                       size: 30,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Obx(
//             () => timeHistoryController.timeHistoryList.isNotEmpty
//                 ? Expanded(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 12),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   height: 70,
//                                   alignment: Alignment.center,
//                                   color: AppTheme.ognOrangeGold,
//                                   child: const Text(
//                                     'วันที่',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 2),
//                                 SizedBox(
//                                   width: 140,
//                                   height: 70,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           width: double.infinity,
//                                           color: AppTheme.ognOrangeGold,
//                                           child: const Center(
//                                             child: Text(
//                                               'ก่อนเที่ยง',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 2),
//                                       Expanded(
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 color: AppTheme.ognOrangeGold,
//                                                 child: const Text(
//                                                   'เข้า',
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(width: 2),
//                                             Expanded(
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 color: AppTheme.ognOrangeGold,
//                                                 child: const Text(
//                                                   'ออก',
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(width: 2),
//                                 SizedBox(
//                                   width: 140,
//                                   height: 70,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           width: double.infinity,
//                                           color: AppTheme.ognOrangeGold,
//                                           child: const Center(
//                                             child: Text(
//                                               'หลังเที่ยง',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 2),
//                                       Expanded(
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 color: AppTheme.ognOrangeGold,
//                                                 child: const Text(
//                                                   'เข้า',
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(width: 2),
//                                             Expanded(
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 color: AppTheme.ognOrangeGold,
//                                                 child: const Text(
//                                                   'ออก',
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(width: 2),
//                                 SizedBox(
//                                   width: 140,
//                                   height: 70,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           width: double.infinity,
//                                           color: AppTheme.ognOrangeGold,
//                                           child: const Center(
//                                             child: Text(
//                                               'ล่วงเวลา',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 2),
//                                       Expanded(
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 color: AppTheme.ognOrangeGold,
//                                                 child: const Text(
//                                                   'เข้า',
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(width: 2),
//                                             Expanded(
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 color: AppTheme.ognOrangeGold,
//                                                 child: const Text(
//                                                   'ออก',
//                                                   style: TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: SingleChildScrollView(
//                               scrollDirection:
//                                   Axis.vertical, // ทำให้ scroll ได้ในแนวนอน
//                               child: Column(
//                                 children: timeHistoryController.timeHistoryList
//                                     .map((row) => _buildCardRow(row))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'assets/img/menu/statistics.png',
//                           width: MediaQuery.of(context).size.width *
//                               (screenMode ? 0.10 : 0.25),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           'ไม่มีข้อมูลของวันที่เลือก',
//                           style: TextStyle(
//                             color: Colors.grey[400],
//                             // fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCardRow(List<dynamic> row) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//       child: Container(
//         height: 75,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.grey.shade400,
//             width: 0.5,
//           ),
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade300.withOpacity(0.5),
//               spreadRadius: 0.5,
//               blurRadius: 0.5,
//               offset: const Offset(1, 0.5),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               width: 100,
//               child: Text(
//                 row[2],
//                 style: const TextStyle(
//                   color: AppTheme.ognMdGreen,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 2),
//             ...List.generate(6, (index) {
//               if (row.length < 15) {
//                 row.addAll(List.filled(15 - row.length, 'N/A'));
//               }

//               Color colorStatus = Colors.grey;
//               var indexValue = row[4 + index * 2];
//               // String test = '+08:01';
//               if (indexValue != row[10]) {
//                 if (indexValue.toString().startsWith('+')) {
//                   colorStatus = AppTheme.ognMdGreen;
//                 } else {
//                   colorStatus = AppTheme.ognOrangeGold;
//                 }
//               } else {
//                 if (indexValue.toString().startsWith('-')) {
//                   colorStatus = AppTheme.ognMdGreen;
//                 } else {
//                   colorStatus = AppTheme.ognOrangeGold;
//                 }
//               }

//               return Container(
//                 alignment: Alignment.center,
//                 width: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       row[3 + index * 2] != 'N/A' ? row[3 + index * 2] : '-',
//                       style: const TextStyle(
//                         color: AppTheme.ognMdGreen,
//                         fontSize: 12,
//                       ),
//                     ),
//                     row[4 + index * 2] != 'N/A'
//                         ? Column(
//                             children: [
//                               const SizedBox(height: 5),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 2, horizontal: 12),
//                                 decoration: BoxDecoration(
//                                   color: colorStatus,
//                                   borderRadius: const BorderRadius.all(
//                                     Radius.circular(35),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   // test,
//                                   row[4 + index * 2],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Container(),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget dateSelected() {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Card(
//             surfaceTintColor: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     child: const Row(
//                       children: [
//                         Icon(
//                           Icons.tune_rounded,
//                           size: 28,
//                           color: AppTheme.ognOrangeGold,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           'เลือกช่วงเวลา',
//                           style: TextStyle(
//                               color: AppTheme.ognGreen,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Obx(
//                     () => Container(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 15),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     color: Colors.grey.shade300, width: 0.5),
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(16.0),
//                                 ),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'เลือกเดือน',
//                                     // 'เดือนเริ่มต้น',
//                                     style: TextStyle(
//                                         color: Colors.grey[400], fontSize: 10),
//                                   ),
//                                   Text(
//                                     timeHistoryController.c_startDate.value,
//                                     style: const TextStyle(
//                                       color: AppTheme.ognMdGreen,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // const Padding(
//                           //   padding: EdgeInsets.symmetric(horizontal: 7),
//                           //   child: Center(
//                           //     child: Text(
//                           //       'ถึง',
//                           //       style: TextStyle(
//                           //         color: AppTheme.ognMdGreen,
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//                           // Expanded(
//                           //   child: Container(
//                           //     padding: const EdgeInsets.symmetric(
//                           //         vertical: 10, horizontal: 15),
//                           //     decoration: BoxDecoration(
//                           //       color: Colors.white,
//                           //       border: Border.all(
//                           //           color: Colors.grey.shade300, width: 0.5),
//                           //       borderRadius: const BorderRadius.all(
//                           //         Radius.circular(16.0),
//                           //       ),
//                           //     ),
//                           //     child: Column(
//                           //       crossAxisAlignment: CrossAxisAlignment.start,
//                           //       children: [
//                           //         Text(
//                           //           'เดือนสิ้นสุด',
//                           //           style: TextStyle(
//                           //               color: Colors.grey[400], fontSize: 10),
//                           //         ),
//                           //         Text(
//                           //           timeHistoryController.c_endDate.value,
//                           //           style: const TextStyle(
//                           //             color: AppTheme.ognMdGreen,
//                           //             fontWeight: FontWeight.bold,
//                           //             fontSize: 13,
//                           //           ),
//                           //         ),
//                           //       ],
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border:
//                           Border.all(color: Colors.grey.shade300, width: 0.5),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(20.0),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       child: SfDateRangePicker(
//                         controller: _controller,
//                         backgroundColor: Colors.transparent,
//                         startRangeSelectionColor: AppTheme.ognXsmGreen,
//                         endRangeSelectionColor: AppTheme.ognXsmGreen,
//                         rangeSelectionColor: AppTheme.ogn2XsmGreen,
//                         selectionRadius: 12,
//                         monthFormat: 'MMMM',
//                         view: DateRangePickerView.year,
//                         selectionMode: DateRangePickerSelectionMode.single,
//                         rangeTextStyle:
//                             const TextStyle(color: AppTheme.ognMdGreen),
//                         headerStyle: const DateRangePickerHeaderStyle(
//                             backgroundColor: Colors.transparent,
//                             textAlign: TextAlign.center,
//                             textStyle: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: AppTheme.ognGreen)),
//                         onSelectionChanged: (args) {
//                           selectionChanged(args);
//                           setState(() {}); // ใช้ setState เพื่อ rebuild dialog
//                         },
//                         allowViewNavigation: false,
//                         showNavigationArrow: true,
//                         yearCellStyle: const DateRangePickerYearCellStyle(
//                           todayTextStyle: TextStyle(color: AppTheme.ognMdGreen),
//                           todayCellDecoration:
//                               BoxDecoration(color: Colors.white),
//                           textStyle: TextStyle(color: AppTheme.ognMdGreen),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           style: const ButtonStyle(),
//                           onPressed: () {
//                             Get.back();
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(vertical: 5),
//                             child: Text('ยกเลิก'),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppTheme.ognOrangeGold,
//                           ),
//                           onPressed: () {
//                             timeHistoryController.loadData();
//                             Get.back();
//                           },
//                           child: const SizedBox(
//                             width: double.infinity,
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(vertical: 12),
//                               child: Center(
//                                 child: Text(
//                                   'ยืนยัน',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String numberToStringCurrency(int? amount) {
//     String formattedAmount =
//         NumberFormat('#,###.##', 'en_US').format(amount ?? 0);
//     return "$formattedAmount บาท";
//   }

//   // String _getThaiMonth(String month) {
//   //   final formatter = DateFormat('MMMM', 'th');
//   //   return formatter.format(DateTime(2024, int.parse(month)));
//   // }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     screenMode = MediaQuery.of(context).size.width > 768;
//   }
// }
