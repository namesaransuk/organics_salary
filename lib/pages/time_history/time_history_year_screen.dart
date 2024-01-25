import 'package:flutter/material.dart';
import 'package:organics_salary/controllers/time_history_controller.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:organics_salary/pages/time_history/innerlist.dart';

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
    return ListView(
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: EdgeInsets.fromLTRB(5, 0, 65, 0),
                    child: Obx(
                      () => DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: <BoxShadow>[
                          //   BoxShadow(
                          //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: DropdownButton<String>(
                            // value: timeHistoryController
                            //     .yearName.value,
                            value: timeHistoryController.ddYearName.value,
                            borderRadius: BorderRadius.circular(20),
                            items: [
                              DropdownMenuItem<String>(
                                enabled: false,
                                value: 'ปี',
                                child: Text(
                                  'ปี',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                              for (final year in listYear)
                                DropdownMenuItem<String>(
                                  value: year,
                                  child: Text(
                                    year,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                            ],
                            onChanged: (String? value) {
                              if (value != null) {
                                sendYear = value;
                                          
                                timeHistoryController.getYear(sendYear);
                                // if (sendYear != 'ปี') {
                                //   timeHistoryController.loadData(
                                //       textMonth, sendMonth, sendYear);
                                // } else {
                                //   print('0000000000000');
                                // }
                                // Get.back();
                              }
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ),
                            iconEnabledColor: Colors.white,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                            dropdownColor: Colors.white,
                            underline: Container(),
                            isExpanded: true,
                          ),
                        ),
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children:
                      List.generate((listMonth.length / 3).ceil(), (rowIndex) {
                    return InkWell(
                      onTap: () {
                        int actualIndex = rowIndex * 3 + 1;
                        timeHistoryController.loadData(
                            listMonth[rowIndex * 3], actualIndex, sendYear);
                      },
                      child: Card(
                        child: AspectRatio(
                          aspectRatio: 1.0, // กำหนดสัดส่วน 1:1
                          child: Center(
                            child: Text(
                              listMonth[rowIndex * 3],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: Column(
                  children:
                      List.generate((listMonth.length / 3).ceil(), (rowIndex) {
                    if (rowIndex * 3 + 1 < listMonth.length) {
                      return InkWell(
                        onTap: () {
                          int actualIndex = rowIndex * 3 + 2;
                          timeHistoryController.loadData(
                              listMonth[rowIndex * 3 + 1], actualIndex, sendYear);
                        },
                        child: Card(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Center(
                              child: Text(
                                listMonth[rowIndex * 3 + 1],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(); // หรือ Widget ที่ไม่แสดงอะไรเลย
                    }
                  }),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  children:
                      List.generate((listMonth.length / 3).ceil(), (rowIndex) {
                    if (rowIndex * 3 + 2 < listMonth.length) {
                      return InkWell(
                        onTap: () {
                          int actualIndex = rowIndex * 3 + 3;
                          timeHistoryController.loadData(
                              listMonth[rowIndex * 3 + 2], actualIndex, sendYear);
                        },
                        child: Card(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Center(
                              child: Text(
                                listMonth[rowIndex * 3 + 2],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(); // หรือ Widget ที่ไม่แสดงอะไรเลย
                    }
                  }),
                ),
              ),
            ],
          ),
        )
      ],
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
}
