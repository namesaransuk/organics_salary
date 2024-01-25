import 'package:flutter/material.dart';
import 'package:organics_salary/controllers/time_history_controller.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:organics_salary/pages/time_history/innerlist.dart';

class TimeHistoryMonthPage extends StatefulWidget {
  const TimeHistoryMonthPage({super.key});

  @override
  State<TimeHistoryMonthPage> createState() => _TimeHistoryMonthPageState();
}

class _TimeHistoryMonthPageState extends State<TimeHistoryMonthPage> {
  // const TimeHistoryMonthPage({super.key});
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'เดือน${timeHistoryController.monthName.value} ${timeHistoryController.yearName.value}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
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
                  Obx(
                    () => Text(
                      timeHistoryController.monthName.value == 'เดือน' &&
                              timeHistoryController.yearName.value == 'ปี'
                          ? 'กรุณาเลือกเดือนและปี'
                          : '${timeHistoryController.monthName.value} ${timeHistoryController.yearName.value}',
                      style: TextStyle(
                          // color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    // child: Text('เลือกเดือน/ปี'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // boxShadow: <BoxShadow>[
                                              //   BoxShadow(
                                              //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                                              // ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 10),
                                              child: DropdownButton<String>(
                                                // value: timeHistoryController
                                                //     .monthName.value,
                                                value: timeHistoryController
                                                    .ddMonthName.value,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    enabled: false,
                                                    value: 'เดือน',
                                                    child: Text(
                                                      'เดือน',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                  for (final month in listMonth)
                                                    DropdownMenuItem<String>(
                                                      value: month,
                                                      child: Text(
                                                        month,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                ],
                                                onChanged: (String? value) {
                                                  if (value != null) {
                                                    int selectedIndex =
                                                        listMonth.indexOf(
                                                                value) +
                                                            1;
                                                    textMonth = value;
                                                    sendMonth = selectedIndex;

                                                    timeHistoryController
                                                        .getMonthName(
                                                            textMonth);

                                                    // Get.back();
                                                  }
                                                },
                                                icon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                iconEnabledColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                dropdownColor: Colors.white,
                                                underline: Container(),
                                                isExpanded: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Obx(
                                          () => DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // boxShadow: <BoxShadow>[
                                              //   BoxShadow(
                                              //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                                              // ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 10),
                                              child: DropdownButton<String>(
                                                // value: timeHistoryController
                                                //     .yearName.value,
                                                value: timeHistoryController
                                                    .ddYearName.value,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    enabled: false,
                                                    value: 'ปี',
                                                    child: Text(
                                                      'ปี',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                  for (final year in listYear)
                                                    DropdownMenuItem<String>(
                                                      value: year,
                                                      child: Text(
                                                        year,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                ],
                                                onChanged: (String? value) {
                                                  if (value != null) {
                                                    sendYear = value;

                                                    timeHistoryController
                                                        .getYear(sendYear);
                                                    // Get.back();
                                                  }
                                                },
                                                icon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                iconEnabledColor: Colors.white,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                dropdownColor: Colors.white,
                                                underline: Container(),
                                                isExpanded: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // !isButtonPressed
                                //     ? Container()
                                //     : sendMonth == 0 && sendYear == 'ปี'
                                Obx(() {
                                  return Column(
                                    children: [
                                      (timeHistoryController
                                                          .ddMonthName.value !=
                                                      'เดือน' &&
                                                  timeHistoryController
                                                          .ddYearName.value ==
                                                      'ปี') ||
                                              (timeHistoryController
                                                          .ddMonthName.value ==
                                                      'เดือน' &&
                                                  timeHistoryController
                                                          .ddYearName.value !=
                                                      'ปี')
                                          ? Center(
                                              child: Text(
                                                'กรุณาเลือกข้อมูลให้ครบ',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  );
                                }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      child: const Text('ปิด'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      child: const Text('ตกลง'),
                                      onPressed: () {
                                        // if (sendMonth != 0 &&
                                        //     sendYear != 'ปี') {
                                        //   timeHistoryController.loadData(
                                        //       textMonth, sendMonth, sendYear);
                                        //   Get.back();
                                        // } else {
                                        //   print('0000000000000');
                                        // }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('เลือกเดือน/ปี'),
                  )
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: _buildListTime(),
          ),
        ],
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
}
