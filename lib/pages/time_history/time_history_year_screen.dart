import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/time_history_controller.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:organics_salary/pages/time_history/innerlist.dart';
import 'package:organics_salary/theme.dart';
import 'dart:core';

class TimeHistoryYearScreen extends StatefulWidget {
  const TimeHistoryYearScreen({super.key});

  @override
  State<TimeHistoryYearScreen> createState() => _TimeHistoryYearScreenState();
}

class _TimeHistoryYearScreenState extends State<TimeHistoryYearScreen> {
  // const TimeHistoryMonthScreen({super.key});
  final TimeHistoryController timeHistoryController =
      Get.put(TimeHistoryController());

  // late List<InnerList> _lists;

  // @override
  // void initState() {
  //   super.initState();

  //   _lists = List.generate(10, (outerIndex) {
  //     return InnerList(
  //       name: outerIndex.toString(),
  //       children: List.generate(6, (innerIndex) => '$outerIndex.$innerIndex'),
  //     );
  //   });
  // }

  int sendMonth = 0;
  String textMonth = 'เดือน';
  String sendYear = 'ปี';

  List listYear = [
    '2023',
    '2024',
    '2025',
    '2026',
  ];

  List listMonth = [
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
    'ธันวาคม',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => timeHistoryController.ddYearName.value != 'ปี'
          ? ListView(
              children: [
                Card(
                  // color: AppTheme.ognSoftGreen,
                  shape: RoundedRectangleBorder(
                    // side: BorderSide(
                    //   color: Colors.greenAccent,
                    // ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'กรุณาเลือกปี',
                                // timeHistoryController.yearName.value == 'ปี'
                                //     ? 'กรุณาเลือกปี'
                                //     : '${timeHistoryController.yearName.value}',
                                style: TextStyle(
                                    // color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 95, 0),
                            child: Obx(
                              () => DropdownButton<String>(
                                value: timeHistoryController.ddYearName.value,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20,
                                ),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 1,
                                  color: AppTheme.ognGreen,
                                ),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    sendYear = value;

                                    timeHistoryController.getYear(sendYear);
                                    if (sendYear != 'ปี') {
                                      timeHistoryController.loadStatus();
                                    } else {
                                      print('0000000000000');
                                    }
                                    // Get.back();
                                  }
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    alignment: Alignment.center,
                                    enabled: false,
                                    value: 'ปี',
                                    child: Text(
                                      'ปี',
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ),
                                  ),
                                  for (final year in listYear)
                                    DropdownMenuItem<String>(
                                      alignment: Alignment.center,
                                      value: year,
                                      child: Text(
                                        year,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                ],
                                dropdownColor: Colors.white,
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                        timeHistoryController.empAttendanceList.map((item) {
                      return Column(
                        children: List.generate(4, (rowIndex) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(3, (columnIndex) {
                              int index = rowIndex * 3 + columnIndex;
                              int monthValue = item['m_${index + 1}'] ?? 0;

                              Color borderCardColor;
                              Color cardColor;
                              Color textColor;
                              switch (monthValue) {
                                case 0:
                                  borderCardColor =
                                      Color.fromARGB(255, 214, 214, 214);
                                  cardColor =
                                      Color.fromARGB(255, 214, 214, 214);
                                  textColor = Colors.white;
                                  break;
                                case 1:
                                  borderCardColor =
                                      Color.fromARGB(255, 47, 170, 109);
                                  cardColor = Colors.white;
                                  textColor = Color.fromARGB(255, 47, 170, 109);
                                  break;
                                case 2:
                                  borderCardColor = Colors.redAccent.shade400;
                                  cardColor = Colors.white;
                                  textColor = Colors.redAccent.shade400;
                                  break;
                                default:
                                  borderCardColor =
                                      Color.fromARGB(255, 214, 214, 214);
                                  cardColor =
                                      Color.fromARGB(255, 214, 214, 214);
                                  textColor = Colors.white;
                              }
                              return Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (timeHistoryController
                                                .ddYearName.value !=
                                            'ปี' &&
                                        monthValue != 0) {
                                      timeHistoryController.loadData(
                                          listMonth[index],
                                          index + 1,
                                          sendYear);
                                      print(index);
                                    } else {
                                      alertEmptyData('แจ้งเตือน',
                                          'ไม่สามารถดูประวัติการลงเวลาของเดือนนี้ได้ หรือยังไม่มีข้อมูลในเดือนนี้');
                                    }
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: borderCardColor,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    color: cardColor,
                                    child: AspectRatio(
                                      aspectRatio: 1.0,
                                      child: Center(
                                        child: Text(
                                          '${listMonth[index]}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                      );
                    }).toList(),

                    // children: [
                    // for (int columnIndex = 0; columnIndex < 3; columnIndex++)
                    //   Expanded(
                    //     child: Column(
                    //       children: List.generate(
                    //         (listMonth.length / 3).ceil(),
                    //         (rowIndex) {
                    //           int actualIndex =
                    //               rowIndex * 3 + columnIndex + 1;
                    //           if (actualIndex <= listMonth.length) {
                    //             int value = timeHistoryController
                    //                         .empAttendanceList[rowIndex]
                    //                     [actualIndex] ??
                    //                 0;
                    //             Color cardColor;
                    //             switch (value) {
                    //               case 0:
                    //                 cardColor = Colors.grey;
                    //                 break;
                    //               case 1:
                    //                 cardColor = Colors.green;
                    //                 break;
                    //               case 2:
                    //                 cardColor = Colors.red;
                    //                 break;
                    //               default:
                    //                 cardColor = Colors.transparent;
                    //             }
                    //             return InkWell(
                    //               onTap: () {
                    //                 if (timeHistoryController
                    //                         .ddYearName.value !=
                    //                     'ปี') {
                    //                   // timeHistoryController.loadData(
                    //                   //     listMonth[actualIndex - 1],
                    //                   //     actualIndex,
                    //                   //     sendYear);
                    //                   print(actualIndex);
                    //                 }
                    //               },
                    //               child: Card(
                    //                 color: cardColor,
                    //                 child: AspectRatio(
                    //                   aspectRatio: 1.0,
                    //                   child: Center(
                    //                     child: Text(
                    //                       listMonth[actualIndex - 1],
                    //                       style: TextStyle(
                    //                         fontSize: 16,
                    //                         color: Colors.white,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           } else {
                    //             return Container();
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.fiber_manual_record_rounded,
                            color: Color.fromARGB(255, 47, 170, 109),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('เดือนที่ไม่ได้ขาด ลา มาสาย')
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.fiber_manual_record_rounded,
                            color: Colors.redAccent.shade400,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('เดือนที่มีการขาด ลา มาสาย')
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.fiber_manual_record_rounded,
                            color: Color.fromARGB(255, 214, 214, 214),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('ยังไม่มีข้อมูลการลงเวลาเข้างานในเดือนนั้น')
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'กรุณาเลือกปี',
                          // timeHistoryController.yearName.value == 'ปี'
                          //     ? 'กรุณาเลือกปี'
                          //     : '${timeHistoryController.yearName.value}',
                          style: TextStyle(
                              // color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 115, 0),
                      child: Obx(
                        () => DropdownButton<String>(
                          value: timeHistoryController.ddYearName.value,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20,
                          ),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: AppTheme.ognGreen,
                          ),
                          onChanged: (String? value) {
                            if (value != null) {
                              sendYear = value;

                              timeHistoryController.getYear(sendYear);
                              if (sendYear != 'ปี') {
                                timeHistoryController.loadStatus();
                              } else {
                                print('0000000000000');
                              }
                              // Get.back();
                            }
                          },
                          items: [
                            DropdownMenuItem<String>(
                              alignment: Alignment.center,
                              enabled: false,
                              value: 'ปี',
                              child: Text(
                                'ปี',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),
                            for (final year in listYear)
                              DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: year,
                                child: Text(
                                  year,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          dropdownColor: Colors.white,
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildListTime() {
    return Obx(() {
      if (timeHistoryController.timeHistoryList.isNotEmpty) {
        // final groupedData = groupBy(
        //     timeHistoryController.timeHistoryList, (obj) => obj.pasteDate);

        final groupedData = groupBy(
          timeHistoryController.timeHistoryList,
          (obj) => '${obj.days}-${obj.month}-${obj.year}',
        );
        return ListView.builder(
          shrinkWrap: true,
          itemCount: groupedData.length,
          itemBuilder: (context, index) {
            final dateKey = groupedData.keys.toList()[index];
            final dmy = dateKey.split('-');
            final days = int.parse(dmy[0]);
            final month = int.parse(dmy[1]);
            final year = int.parse(dmy[2]);
            final timeHistoryList = groupedData[dateKey]!;

            bool hasRedCard = timeHistoryList.any((item) {
              List<String> dateParts = item.pasteDate!.split(' ');
              List<String> timeParts = dateParts[1].split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              return (hour == 8 && minute >= 1 && minute <= 59) ||
                  (hour > 8 && hour < 12) ||
                  (hour == 13 && minute >= 1 && minute <= 59) ||
                  (hour > 13 && hour < 18);
            });

            return ExpansionTile(
              title: Text(
                '${days} ${listMonth[month - 1]} ${year}',
                style: TextStyle(),
              ),
              collapsedBackgroundColor:
                  hasRedCard ? Colors.red : Colors.grey.shade100,
              collapsedTextColor: hasRedCard ? Colors.white : Colors.black,
              collapsedIconColor: hasRedCard ? Colors.white : Colors.black,
              iconColor: Colors.black,
              childrenPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              tilePadding: EdgeInsets.symmetric(horizontal: 25),
              // subtitle: Text('Trailing expansion arrow icon'),
              children: timeHistoryList.map((item) {
                Color cardColor = Colors.grey.shade100;
                Color textColor = Colors.black;

                List<String> dateParts = item.pasteDate!.split(' ');
                List<String> timeParts = dateParts[1].split(':');
                int intHour = int.parse(timeParts[0]);
                int intMinute = int.parse(timeParts[1]);
                String hour = timeParts[0];
                String minute = timeParts[1];
                print('test: $intHour $intMinute');

                // เช็คว่าอยู่ในช่วงเวลาที่ต้องการหรือไม่
                if ((intHour == 8 && intMinute >= 1 && intMinute <= 59) ||
                    (intHour > 8 && intHour < 12) ||
                    (intHour == 13 && intMinute >= 1 && intMinute <= 59) ||
                    (intHour > 13 && intHour < 18)) {
                  cardColor = Colors.red;
                  textColor = Colors.white;
                }

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  color: cardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.days} ${listMonth[item.month! - 1]} ${item.year}',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        Text(
                          'เวลา : ${hour}:${minute}',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ไม่มีข้อมูล",
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      }
    });
  }

  void alertEmptyData(String title, String detail) {
    Get.dialog(
      AlertDialog(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: AppTheme.ognGreen,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Text(detail),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("ตกลง"),
          ),
        ],
      ),
    );
  }
}
