// import 'package:carousel_slider/carousel_slider.dart' as cs;
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:organics_salary/controllers/news_controller.dart';
// import 'package:organics_salary/controllers/profile_controller.dart';
// import 'package:organics_salary/theme.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';

// class DashboardMobileScreen extends StatefulWidget {
//   const DashboardMobileScreen({super.key});

//   @override
//   State<DashboardMobileScreen> createState() => _DashboardMobileScreenState();
// }

// class _DashboardMobileScreenState extends State<DashboardMobileScreen> {
//   DateTime now = DateTime.now();
//   final box = GetStorage();

//   late bool screenMode;
//   // late bool screenMode = MediaQuery.of(context).size.width >= 400;

//   final ProfileController profileController = Get.put(ProfileController());
//   final NewsController newsController = Get.put(NewsController());
//   late List<_GrapeData> data1 = [];
//   late List<_GrapeData> data2 = [];

//   int workPercent = 0;

//   Color getColorForAttendance(int attendanceValue) {
//     switch (attendanceValue) {
//       case 0:
//         return Colors.grey.shade200;
//       case 1:
//         return AppTheme.ognSmGreen;
//       case 2:
//         return AppTheme.ognOrangeGold;
//       default:
//         return Colors.grey.shade200;
//     }
//   }

//   Color getTextColorForAttendance(int attendanceValue) {
//     switch (attendanceValue) {
//       case 0:
//         return Colors.grey.shade500;
//       case 1:
//         return Colors.white;
//       case 2:
//         return Colors.white;
//       default:
//         return Colors.grey.shade500;
//     }
//   }

//   Future<void> loadNews() async {
//     await newsController.loadData();
//   }

//   Future<void> loadData() async {
//     DateTime nowYear = DateTime.now();
//     DateTime nowBangkok = nowYear.toLocal();
//     DateFormat yearFormat = DateFormat('yyyy');
//     String currentYear = yearFormat.format(nowBangkok);

//     await profileController.loadStatus(currentYear);
//     await profileController.loadQuota();

//     int count = 0;
//     List<String> months = [
//       'ม.ค.',
//       'ก.พ.',
//       'มี.ค.',
//       'เม.ย.',
//       'พ.ค.',
//       'มิ.ย.',
//       'ก.ค.',
//       'ส.ค.',
//       'ก.ย.',
//       'ต.ค.',
//       'พ.ย.',
//       'ธ.ค.'
//     ];
//     var monthlyData = <_GrapeData>[];
//     for (var empAttendanceModel in profileController.empAttendanceList) {
//       data2.clear();
//       for (var i = 0; i < months.length; i++) {
//         // print(' : ${empAttendanceModel}');
//         var value = empAttendanceModel['m_${i + 1}'] ?? 0;
//         var color = getColorForAttendance(value);
//         var textColor = getTextColorForAttendance(value);
//         monthlyData.add(_GrapeData('', months[i], 1, color, textColor));

//         if (value == 1) {
//           count++;
//         }
//       }

//       data2.addAll(monthlyData);
//     }

//     var calculateWork = count * 100 / 12;
//     int percentWork = calculateWork.toInt();
//     workPercent = percentWork;

//     data1 = [
//       _GrapeData(percentWork > 5 ? '$percentWork%' : '', 'ผ่านมาแล้ว',
//           percentWork, AppTheme.ognSmGreen, Colors.white),
//       _GrapeData(
//           100 - percentWork > 5 ? '${100 - percentWork}%' : '',
//           'วันที่เหลือ',
//           100 - percentWork,
//           Colors.grey.shade200,
//           Colors.grey.shade500),
//     ];
//   }

//   final cs.CarouselSliderController _controller = cs.CarouselSliderController();
//   final baseUrl = dotenv.env['ASSET_URL'];

//   @override
//   Widget build(BuildContext context) {
//     int currentMonth = (12 - now.month) % 12 + 1;

//     return RefreshIndicator(
//       color: Colors.white,
//       onRefresh: () async {
//         return Future<void>.delayed(const Duration(seconds: 3));
//       },
//       notificationPredicate: (ScrollNotification notification) {
//         return notification.depth == 1;
//       },
//       child: Container(
//         color: AppTheme.bgSoftGreen,
//         child: Column(
//           children: [
//             Container(
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     AppTheme.ognSoftGreen,
//                     Color.fromARGB(255, 198, 240, 236),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(0),
//                   bottomRight: Radius.circular(0),
//                 ),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     ClipOval(
//                       child: box.read('profileImage') != null ||
//                               box.read('profileImage') != ''
//                           ? Image.network(
//                               '$baseUrl/${box.read('profileImage')}',
//                               width: MediaQuery.of(context).size.width * 0.30,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   'assets/img/user.png',
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.30,
//                                 );
//                               },
//                             )
//                           : Image.asset(
//                               'assets/img/user.png',
//                               width: MediaQuery.of(context).size.width * 0.30,
//                             ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${box.read('fnames')} ${box.read('lnames')}',
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge
//                               ?.copyWith(
//                                   color: AppTheme.ognGreen,
//                                   fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 7,
//                         ),
//                         IntrinsicHeight(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'รหัสพนักงาน : ${box.read('employeeCode')}',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium
//                                     ?.copyWith(
//                                       color: AppTheme.ognGreen,
//                                       fontSize: 14,
//                                       letterSpacing: 0.0,
//                                     ),
//                               ),
//                               const VerticalDivider(
//                                 thickness: 1.5,
//                                 width: 20,
//                                 color: AppTheme.ognOrangeGold,
//                               ),
//                               Flexible(
//                                 child: Text(
//                                   '${box.read('department')}',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleMedium
//                                       ?.copyWith(
//                                         color: AppTheme.ognGreen,
//                                         fontSize: 14,
//                                         letterSpacing: 0.0,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 50,
//                   decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 198, 240, 236),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(60),
//                       bottomRight: Radius.circular(60),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.transparent,
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 0),
//                           child: Card(
//                             color: Colors.white,
//                             surfaceTintColor: Colors.white,
//                             clipBehavior: Clip.antiAlias,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   child: FutureBuilder(
//                                     future: loadData(),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         return const Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 222),
//                                           child: Center(
//                                             child: CircularProgressIndicator(),
//                                           ),
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         print(snapshot.error);
//                                         return Container(
//                                           width: double.infinity,
//                                           padding: const EdgeInsets.all(35),
//                                           child: Column(
//                                             children: [
//                                               Image.asset(
//                                                 'assets/img/pie-chart.png',
//                                                 width: 150,
//                                               ),
//                                               const SizedBox(
//                                                 height: 25,
//                                               ),
//                                               const Text(
//                                                 'ไม่มีสถิติการมาทำงานในขณะนี้',
//                                                 style: TextStyle(
//                                                   color: AppTheme.ognGreen,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       } else {
//                                         return data1.isNotEmpty &&
//                                                 data2.isNotEmpty
//                                             ? Column(
//                                                 children: [
//                                                   const Padding(
//                                                     padding:
//                                                         EdgeInsets.fromLTRB(
//                                                             0, 30, 0, 0),
//                                                     child: Text(
//                                                       'สถิติการมาทำงาน',
//                                                       style: TextStyle(
//                                                         color:
//                                                             AppTheme.ognGreen,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 16,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: MediaQuery.of(
//                                                                 context)
//                                                             .size
//                                                             .height *
//                                                         (MediaQuery.of(context)
//                                                                     .size
//                                                                     .width >
//                                                                 400
//                                                             ? 0.38
//                                                             : 0.35),
//                                                     child: Stack(
//                                                       children: [
//                                                         SfCircularChart(
//                                                           // title: ChartTitle(
//                                                           //     text: 'Half monthly data analysis'),
//                                                           // legend: Legend(
//                                                           //   isVisible: true,
//                                                           //   position: LegendPosition.bottom,
//                                                           //   overflowMode:
//                                                           //       LegendItemOverflowMode.wrap,
//                                                           // ),
//                                                           borderWidth: 0.5,
//                                                           borderColor:
//                                                               Colors.white,
//                                                           tooltipBehavior:
//                                                               TooltipBehavior(
//                                                                   enable: true),
//                                                           // centerY: '60%',
//                                                           margin: EdgeInsets.all(
//                                                               MediaQuery.of(context)
//                                                                           .size
//                                                                           .width >
//                                                                       400
//                                                                   ? 40.0
//                                                                   : 30.0),
//                                                           onDataLabelRender:
//                                                               (DataLabelRenderArgs
//                                                                   args) {
//                                                             if (data1
//                                                                 .isNotEmpty) {
//                                                               final index = args
//                                                                       .pointIndex %
//                                                                   data1.length;
//                                                               args.textStyle =
//                                                                   TextStyle(
//                                                                 fontSize: MediaQuery.of(context)
//                                                                             .size
//                                                                             .width >
//                                                                         400
//                                                                     ? 9
//                                                                     : 8,
//                                                                 color: data1[
//                                                                         index]
//                                                                     .textColor,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                               );
//                                                             }
//                                                           },
//                                                           annotations: <CircularChartAnnotation>[
//                                                             // CircularChartAnnotation(widget: Container(child: PhysicalModel(child: Container(), shape: BoxShape.circle, elevation: 10, shadowColor: Colors.black, color: const Color.fromRGBO(230, 230, 230, 1)))),
//                                                             CircularChartAnnotation(
//                                                               verticalAlignment:
//                                                                   ChartAlignment
//                                                                       .center,
//                                                               widget: Container(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         bottom:
//                                                                             25),
//                                                                 child: Text(
//                                                                   ' 30,000',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: AppTheme
//                                                                         .ognOrangeGold,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         MediaQuery.of(context).size.width >
//                                                                                 375
//                                                                             ? 28
//                                                                             : 24,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             CircularChartAnnotation(
//                                                               verticalAlignment:
//                                                                   ChartAlignment
//                                                                       .center,
//                                                               widget: Container(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         top:
//                                                                             35),
//                                                                 child: Text(
//                                                                   ' โบนัสปลายปี',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: AppTheme
//                                                                         .ognMdGreen,
//                                                                     // fontWeight: FontWeight.bold,
//                                                                     fontSize:
//                                                                         MediaQuery.of(context).size.width >
//                                                                                 375
//                                                                             ? 15
//                                                                             : 14,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                           series: <DoughnutSeries<
//                                                               _GrapeData,
//                                                               String>>[
//                                                             DoughnutSeries<
//                                                                 _GrapeData,
//                                                                 String>(
//                                                               dataSource: data1,
//                                                               strokeWidth: 0.5,
//                                                               strokeColor:
//                                                                   Colors.white,
//                                                               xValueMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.month,
//                                                               yValueMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.data,
//                                                               pointColorMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.color,
//                                                               name:
//                                                                   '% การมาทำงาน',
//                                                               dataLabelMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.percent,
//                                                               dataLabelSettings:
//                                                                   const DataLabelSettings(
//                                                                 textStyle: TextStyle(
//                                                                     // fontSize: 8,
//                                                                     // color: Colors.white,
//                                                                     ),
//                                                                 isVisible: true,
//                                                                 labelPosition:
//                                                                     ChartDataLabelPosition
//                                                                         .inside,
//                                                                 // useSeriesColor: true,
//                                                                 connectorLineSettings:
//                                                                     ConnectorLineSettings(
//                                                                   type:
//                                                                       ConnectorType
//                                                                           .line,
//                                                                   length: '15%',
//                                                                 ),
//                                                                 labelIntersectAction:
//                                                                     LabelIntersectAction
//                                                                         .shift,
//                                                               ),
//                                                               startAngle: 180,
//                                                               endAngle: 0,
//                                                               radius: '100%',
//                                                               innerRadius:
//                                                                   '65%',
//                                                             )
//                                                           ],
//                                                         ),
//                                                         SfCircularChart(
//                                                           // title: ChartTitle(
//                                                           //     text: 'Half monthly data analysis'),
//                                                           // legend: Legend(
//                                                           //   isVisible: true,
//                                                           //   position: charts.LegendPosition.right,
//                                                           // ),
//                                                           // tooltipBehavior:
//                                                           //     TooltipBehavior(enable: true),
//                                                           // centerY: '60%',
//                                                           // onDataLabelRender: (dataLabelArgs) {
//                                                           //   dataLabelArgs.color = data2[dataLabelArgs.pointIndex].color;
//                                                           // },
//                                                           selectionGesture:
//                                                               ActivationMode
//                                                                   .none,
//                                                           onDataLabelRender:
//                                                               (DataLabelRenderArgs
//                                                                   args) {
//                                                             if (data2
//                                                                 .isNotEmpty) {
//                                                               final index = args
//                                                                       .pointIndex %
//                                                                   data2.length;
//                                                               args.textStyle =
//                                                                   TextStyle(
//                                                                 fontSize: MediaQuery.of(context)
//                                                                             .size
//                                                                             .width >
//                                                                         400
//                                                                     ? 9
//                                                                     : 8,
//                                                                 color: data2
//                                                                     .reversed
//                                                                     .toList()[
//                                                                         index]
//                                                                     .textColor,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                               );
//                                                             }
//                                                           },
//                                                           margin: EdgeInsets.all(
//                                                               MediaQuery.of(context)
//                                                                           .size
//                                                                           .width >
//                                                                       400
//                                                                   ? 40.0
//                                                                   : 30.0),
//                                                           series: <DoughnutSeries<
//                                                               _GrapeData,
//                                                               String>>[
//                                                             DoughnutSeries<
//                                                                 _GrapeData,
//                                                                 String>(
//                                                               dataSource: data2
//                                                                   .reversed
//                                                                   .toList(),
//                                                               strokeWidth: 0.5,
//                                                               strokeColor:
//                                                                   Colors.white,
//                                                               xValueMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.month,
//                                                               yValueMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.data,
//                                                               pointColorMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.color,
//                                                               name: '% ตรงเวลา',
//                                                               dataLabelMapper:
//                                                                   (_GrapeData data,
//                                                                           _) =>
//                                                                       data.month,
//                                                               dataLabelSettings:
//                                                                   const DataLabelSettings(
//                                                                 textStyle: TextStyle(
//                                                                     // fontSize: 8,
//                                                                     // color: data2.reversed.toList()[0].textColor,
//                                                                     ),
//                                                                 isVisible: true,
//                                                               ),
//                                                               startAngle: 0,
//                                                               endAngle: 180,
//                                                               explode: true,
//                                                               explodeIndex:
//                                                                   currentMonth -
//                                                                       1,
//                                                               explodeOffset:
//                                                                   '5%',
//                                                               radius: '100%',
//                                                               innerRadius:
//                                                                   '65%',
//                                                               // sortFieldValueMapper:
//                                                               //     (_GrapeData data, _) => data.month,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                         horizontal: 15),
//                                                     child: Column(
//                                                       children: [
//                                                         const SizedBox(
//                                                           height: 10,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child:
//                                                                   leaveColumn(
//                                                                 '${profileController.leaveQuotaList[0].allQuota ?? 0} วัน',
//                                                                 'ลาป่วย',
//                                                                 '${profileController.leaveQuotaList[0].useLeaveDays}',
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child:
//                                                                   leaveColumn(
//                                                                 '${profileController.leaveQuotaList[1].allQuota ?? 0} วัน',
//                                                                 'ลากิจ',
//                                                                 '${profileController.leaveQuotaList[1].useLeaveDays}',
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child:
//                                                                   leaveColumn(
//                                                                 '${profileController.leaveQuotaList[2].allQuota ?? 0} วัน',
//                                                                 'ลาพักร้อน',
//                                                                 '${profileController.leaveQuotaList[2].useLeaveDays}',
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 10,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child:
//                                                                   leaveColumn(
//                                                                 '${profileController.leaveQuotaList[3].allQuota ?? 0} วัน',
//                                                                 'ลาคลอด',
//                                                                 '${profileController.leaveQuotaList[3].useLeaveDays}',
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child:
//                                                                   leaveColumn(
//                                                                 '${profileController.leaveQuotaList[4].allQuota ?? 0} วัน',
//                                                                 'ลาเกณฑ์ทหาร',
//                                                                 '${profileController.leaveQuotaList[4].useLeaveDays}',
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child:
//                                                                   leaveColumn(
//                                                                 '${profileController.leaveQuotaList[5].allQuota ?? 0} วัน',
//                                                                 'ลาบวช',
//                                                                 '${profileController.leaveQuotaList[5].useLeaveDays}',
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 20,
//                                                   ),
//                                                 ],
//                                               )
//                                             : Container(
//                                                 width: double.infinity,
//                                                 padding:
//                                                     const EdgeInsets.all(35),
//                                                 child: Column(
//                                                   children: [
//                                                     Image.asset(
//                                                       'assets/img/pie-chart.png',
//                                                       width: 150,
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 25,
//                                                     ),
//                                                     const Text(
//                                                       'ไม่มีสถิติการมาทำงานในขณะนี้',
//                                                       style: TextStyle(
//                                                         color:
//                                                             AppTheme.ognGreen,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 16,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // Row(
//                         //   children: [
//                         //     itemDashboard(
//                         //       'แจ้งลา',
//                         //       Icons.work_history_outlined,
//                         //       () => Get.toNamed('/leave'),
//                         //     ),
//                         //     itemDashboard(
//                         //       'OGN Coin',
//                         //       FontAwesomeIcons.coins,
//                         //       () => Get.toNamed('/coin'),
//                         //     ),
//                         //     itemDashboard(
//                         //       'เงินเดือน',
//                         //       Icons.receipt_long,
//                         //       () => Get.toNamed('/salary'),
//                         //     ),
//                         //   ],
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//             FutureBuilder(
//               future: loadNews(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   print(snapshot.error);
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Center(
//                       child: Text(
//                         'Error: ${snapshot.error}',
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Column(
//                     children: [
//                       const Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.campaign_rounded,
//                               size: 20,
//                               color: AppTheme.ognOrangeGold,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               'ข่าวสาร',
//                               style: TextStyle(color: AppTheme.ognGreen),
//                             ),
//                           ],
//                         ),
//                       ),
//                       newsController.newsList.isNotEmpty
//                           ? Obx(
//                               () => Column(
//                                 children: [
//                                   Container(
//                                     child: cs.CarouselSlider(
//                                       carouselController: _controller,
//                                       options: cs.CarouselOptions(
//                                           aspectRatio: 3,
//                                           viewportFraction: 0.8,
//                                           enlargeCenterPage: true,
//                                           scrollDirection: Axis.horizontal,
//                                           autoPlay: true,
//                                           autoPlayInterval:
//                                               const Duration(seconds: 8),
//                                           autoPlayAnimationDuration:
//                                               const Duration(milliseconds: 800),
//                                           onPageChanged: (index, reason) {
//                                             newsController.current.value =
//                                                 index;
//                                           }),
//                                       items:
//                                           newsController.newsList.map((item) {
//                                         return Container(
//                                           clipBehavior: Clip.antiAlias,
//                                           decoration: const BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(12))),
//                                           child: InkWell(
//                                             onTap: () {
//                                               newsController
//                                                   .loadSectionData(item.id);
//                                             },
//                                             child: Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 AspectRatio(
//                                                   aspectRatio: 1,
//                                                   child: item.newsImg1 !=
//                                                               null &&
//                                                           item.newsImg1 != '' &&
//                                                           item.newsImg1 !=
//                                                               'null'
//                                                       ? Image.network(
//                                                           '${item.newsImg1}',
//                                                           fit: BoxFit.cover,
//                                                         )
//                                                       : Image.asset(
//                                                           'assets/img/logo.jpg',
//                                                           fit: BoxFit.cover,
//                                                         ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             12.0),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           '${item.announcementTopic}',
//                                                           style: const TextStyle(
//                                                               fontSize: 14,
//                                                               color: AppTheme
//                                                                   .ognMdGreen,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                         Expanded(
//                                                           child: Text(
//                                                             '${item.announcementContent}',
//                                                             style: TextStyle(
//                                                                 fontSize: 14,
//                                                                 color: Colors
//                                                                     .grey[500]),
//                                                             softWrap: false,
//                                                             maxLines: 2,
//                                                             overflow: TextOverflow
//                                                                 .ellipsis, // new
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             const Row(
//                                                               children: [
//                                                                 // Icon(
//                                                                 //   Icons.remove_red_eye_rounded,
//                                                                 //   size: 16,
//                                                                 //   color: Colors.grey[400],
//                                                                 // ),
//                                                                 // SizedBox(
//                                                                 //   width: 3,
//                                                                 // ),
//                                                                 // Text(
//                                                                 //   '69',
//                                                                 //   style: TextStyle(
//                                                                 //     color: Colors.grey[400],
//                                                                 //   ),
//                                                                 // ),
//                                                               ],
//                                                             ),
//                                                             InkWell(
//                                                               onTap: () {},
//                                                               child: const Text(
//                                                                 'ดูเพิ่มเติม',
//                                                                 style: TextStyle(
//                                                                     decoration:
//                                                                         TextDecoration
//                                                                             .underline,
//                                                                     letterSpacing:
//                                                                         0.0,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         13,
//                                                                     color: AppTheme
//                                                                         .ognMdGreen),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: newsController.newsList
//                                         .asMap()
//                                         .entries
//                                         .map((entry) {
//                                       return GestureDetector(
//                                         onTap: () => _controller
//                                             .animateToPage(entry.key),
//                                         child: Container(
//                                           width: 12.0,
//                                           height: 12.0,
//                                           margin: const EdgeInsets.symmetric(
//                                               vertical: 8.0, horizontal: 4.0),
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: (Theme.of(context)
//                                                             .brightness ==
//                                                         Brightness.dark
//                                                     ? Colors.white
//                                                     : AppTheme.ognOrangeGold)
//                                                 .withOpacity(
//                                                     newsController.current ==
//                                                             entry.key
//                                                         ? 0.9
//                                                         : 0.4),
//                                           ),
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : Container(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 20),
//                               height: 150,
//                               child: const Card(
//                                 color: Colors.white,
//                                 surfaceTintColor: Colors.white,
//                                 child: Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         FontAwesomeIcons.newspaper,
//                                         size: 40,
//                                         color: AppTheme.ognOrangeGold,
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Text(
//                                         'ไม่มีข่าวสารในขณะนี้',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: AppTheme.ognGreen),
//                                       ),
//                                       Text(
//                                         'รอติดตามการอัพเดตเพิ่มเติมจากทาง HR เร็วๆนี้',
//                                         style:
//                                             TextStyle(color: AppTheme.ognGreen),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ],
//                   );
//                 }
//               },
//             ),
//             const SizedBox(height: 100),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget itemDashboard(String title, IconData icon, VoidCallback? onPress) {
//     return Expanded(
//       child: Card(
//         surfaceTintColor: Colors.white,
//         color: Colors.white,
//         clipBehavior: Clip.antiAlias,
//         child: InkWell(
//           onTap: onPress,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(
//                   icon,
//                   color: AppTheme.ognSmGreen,
//                   size: 45,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: AppTheme.ognMdGreen,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget leaveColumn(String quota, String title, String value) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 color: AppTheme.ognGreen,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//               ),
//             ),
//             Text(
//               ' ($quota)',
//               style: TextStyle(
//                 color: Colors.grey[400],
//                 fontWeight: FontWeight.bold,
//                 fontSize: 10,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             color: AppTheme.ognOrangeGold,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     screenMode = MediaQuery.of(context).size.width > 768;
//     print('SCREEN : ${MediaQuery.of(context).size.width}');
//   }
// }

// class _GrapeData {
//   _GrapeData(this.percent, this.month, this.data, this.color, this.textColor);

//   final String percent;
//   final String month;
//   final int data;
//   final Color color;
//   final Color textColor;
// }
