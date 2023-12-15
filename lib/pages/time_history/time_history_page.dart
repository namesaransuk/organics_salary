import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/time_history_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class TimeHistoryPage extends StatefulWidget {
  const TimeHistoryPage({super.key});

  @override
  State<TimeHistoryPage> createState() => _TimeHistoryPageState();
}

class _TimeHistoryPageState extends State<TimeHistoryPage> {
  // const TimeHistoryPage({super.key});
  final TimeHistoryController timeHistoryController =
      Get.put(TimeHistoryController());

  late List<InnerList> _lists;

  @override
  void initState() {
    super.initState();

    _lists = List.generate(10, (outerIndex) {
      return InnerList(
        name: outerIndex.toString(),
        children: List.generate(6, (innerIndex) => '$outerIndex.$innerIndex'),
      );
    });
  }

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
        title: Text(
          'ประวัติการลงเวลา',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ognGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Obx(
                  () => DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(50),
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: DropdownButton<String>(
                        value: timeHistoryController.monthName.value,
                        borderRadius: BorderRadius.circular(20),
                        items: [
                          DropdownMenuItem<String>(
                            enabled: false,
                            value: 'กรุณาเลือกเดือน',
                            child: Text(
                              'กรุณาเลือกเดือน',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                          for (final month in listMonth)
                            DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            int selectedIndex = listMonth.indexOf(value) + 1;
                            timeHistoryController.loadData(selectedIndex);
                            timeHistoryController.getMonthName(value);
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        dropdownColor: Colors.white,
                        underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildListTime(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTime() {
    return Obx(() {
      if (timeHistoryController.timeHistoryList.isNotEmpty) {
        final groupedData =
            groupBy(timeHistoryController.timeHistoryList, (obj) => obj.date);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: groupedData.length,
          itemBuilder: (context, index) {
            final date = groupedData.keys.toList()[index];
            final timeHistoryList = groupedData[date]!;

            bool hasRedCard = timeHistoryList.any((item) {
              List<String> timeParts = item.time!.split(':');
              int hour = int.parse(timeParts[0]);
              int minute = int.parse(timeParts[1]);

              return (hour == 8 && minute >= 1) ||
                  (hour > 8 && hour < 12) ||
                  (hour == 13 && minute <= 1) ||
                  (hour > 13 && hour < 18);
            });

            return ExpansionTile(
              title: Text(
                '$date',
                style: TextStyle(),
              ),
              collapsedBackgroundColor:
                  hasRedCard ? Colors.red : Colors.grey.shade100,
              collapsedTextColor: hasRedCard ? Colors.white : Colors.black,
              collapsedIconColor: hasRedCard ? Colors.white : Colors.black,
              iconColor: Colors.black,
              childrenPadding: EdgeInsets.symmetric(vertical: 10),
              // subtitle: Text('Trailing expansion arrow icon'),
              children: timeHistoryList.map((item) {
                Color cardColor = Colors.grey.shade200;
                Color textColor = Colors.black;

                List<String> timeParts = item.time!.split(':');
                int hour = int.parse(timeParts[0]);
                int minute = int.parse(timeParts[1]);

                if ((hour == 8 && minute >= 1) ||
                    (hour > 8 && hour < 12) ||
                    (hour == 13 && minute <= 1) ||
                    (hour > 13 && hour < 18)) {
                  cardColor = Colors.red;
                  textColor = Colors.white;
                }

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  color: cardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.date}',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        Text(
                          'เวลา : ${item.time}',
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
