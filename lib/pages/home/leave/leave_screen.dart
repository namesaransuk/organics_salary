import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:organics_salary/theme.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SegmentedTabControl(
              radius: const Radius.circular(0),
              backgroundColor: Colors.grey.shade500,
              indicatorColor: Color.fromARGB(255, 19, 110, 104),
              tabTextColor: Colors.white,
              selectedTabTextColor: Colors.white,
              squeezeIntensity: 2,
              height: 55,
              tabPadding: const EdgeInsets.symmetric(horizontal: 8),
              textStyle: Theme.of(context).textTheme.bodyLarge,
              tabs: [
                SegmentTab(label: 'แจ้งลา'),
                SegmentTab(label: 'ประวัติการลา'),
              ],
            ),
          ),
          // Sample pages
          Container(
            padding: EdgeInsets.only(top: 55),
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                LeaveReport(),
                LeaveHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------

class LeaveReport extends StatefulWidget {
  const LeaveReport({super.key});

  @override
  State<LeaveReport> createState() => _LeaveReportState();
}

class _LeaveReportState extends State<LeaveReport> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('data'),
              )
            ],
          ),
        )
      ],
    );
  }
}

// --------------------------------------------------------------

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '28 พ.ย. 2566',
                    style: TextStyle(color: AppTheme.ognGreen),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ลาป่วย',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('ไม่มีใบรับรองแพทย์'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'สาเหตุการลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('เป็นไข้ ปวดหัว ตัวร้อน นอนไม่หลับ'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'จำนวนวันที่ลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ตั้งแต่ 28 พ.ย. 2566 เวลา 08.00 น.'),
                                  Text('จนถึง 28 พ.ย. 2566 เวลา 18.00 น.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '20 ก.ย. 2566',
                    style: TextStyle(color: AppTheme.ognGreen),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ลาป่วย',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text('มีใบรับรองแพทย์'),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('ดูไฟล์'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'สาเหตุการลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('ติดเชื้อ Covid 19'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'จำนวนวันที่ลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ตั้งแต่ 20 ก.ย. 2566 เวลา 08.00 น.'),
                                  Text('จนถึง 25 ก.ย. 2566 เวลา 18.00 น.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10 ก.ค. 2566',
                    style: TextStyle(color: AppTheme.ognGreen),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ลาพักร้อน',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('-'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'สาเหตุการลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('ลาพักร้อนประจำปี'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'จำนวนวันที่ลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ตั้งแต่ 19 ก.ค. 2566 เวลา 08.00 น.'),
                                  Text('จนถึง 21 ก.ค. 2566 เวลา 18.00 น.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
