import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/pages/home/profile/active_project_card.dart';
import 'package:organics_salary/theme.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          // shrinkWrap: true,
          children: const [
            GetMainUI(),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }
}

class _GrapeData {
  _GrapeData(this.year, this.sales, this.color);

  final String year;
  final double sales;
  final Color color;
}

class GetMainUI extends StatefulWidget {
  const GetMainUI({super.key});

  @override
  State<GetMainUI> createState() => _GetMainUIState();
}

class _GetMainUIState extends State<GetMainUI> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<_GrapeData> data1 = <_GrapeData>[
      _GrapeData('Jan', 35, Colors.green),
      // _GrapeData('Feb', 35),
      // _GrapeData('Mar', 34),
      // _GrapeData('Apr', 32),
      // _GrapeData('May', 40)
    ];
    List<_GrapeData> data2 = <_GrapeData>[
      _GrapeData('มกราคม', 1, Colors.grey.shade50),
      _GrapeData('กุมภาพันธ์', 1, Colors.grey.shade100),
      _GrapeData('มีนาคม', 1, Colors.grey.shade200),
      _GrapeData('เมษายน', 1, Colors.grey.shade300),
      _GrapeData('พฤษภาคม', 1, Colors.grey.shade400),
      _GrapeData('มิถุนายน', 1, Colors.grey.shade500),
      _GrapeData('กรกฎาคม', 1, Colors.grey.shade600),
      _GrapeData('สิงหาคม', 1, Colors.grey.shade700),
      _GrapeData('กันยายน', 1, Colors.grey.shade800),
      _GrapeData('ตุลาคม', 1, Colors.grey.shade900),
      _GrapeData('พฤษจิกายน', 1, Colors.black87),
      _GrapeData('ธันวาคม', 1, Colors.black),
    ];

    final box = GetStorage();

    // Map<String, double> dataMap = {
    //   // "% การมาทำงาน": 12,
    //   "ม.ค.": 1,
    //   "ก.พ.": 1,
    //   "มี.ค.": 1,
    //   "เม.ย.": 1,
    //   "พ.ค.": 1,
    //   "มิ.ย.": 1,
    //   "ก.ค.": 1,
    //   "ส.ค.": 1,
    //   "ก.ย.": 1,
    //   "ต.ค.": 1,
    //   "พ.ย.": 1,
    //   "ธ.ค.": 1,
    // };

    // final gradientList = <List<Color>>[
    //   // [
    //   //   Color.fromRGBO(223, 250, 92, 1),
    //   //   Color.fromRGBO(129, 250, 112, 1),
    //   // ],
    //   [
    //     Color.fromRGBO(129, 182, 205, 1),
    //     Color.fromRGBO(91, 253, 199, 1),
    //   ],
    //   [
    //     Color.fromRGBO(175, 63, 62, 1.0),
    //     Color.fromRGBO(254, 154, 92, 1),
    //   ]
    // ];

    return Container(
      // color: AppTheme.bgSoftGreen,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${box.read('f_name')} ${box.read('l_name')}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                              // color: Colors.white,
                              ),
                    ),
                    Text(
                      box.read('company_name_th'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          // color: Colors.white54,
                          ),
                    ),
                  ],
                ),
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: box.read('image').startsWith('http') ||
                            box.read('image').startsWith('https')
                        ? Image.network(
                            '${box.read('image')}',
                            width: MediaQuery.of(context).size.width * 0.18,
                          )
                        : Image.asset(
                            '${box.read('image')}',
                            width: MediaQuery.of(context).size.width * 0.18,
                          ),
                  ),
                ),
                // CircleAvatar(
                //   radius: 30,
                //   child: Image.network(
                //     '${box.read('image')}',
                //     width: 200,
                //   ),
                // ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Column(
            children: [
              // Container(
              //   // color: AppTheme.ognSoftGreen,
              //   color: Colors.white,
              //   height: 200,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  children: [
                    Container(
                      // color: AppTheme.bgSoftGreen,
                      color: Colors.grey[100],
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 20),
                            //   child: PieChart(
                            //     dataMap: dataMap,
                            //     animationDuration: Duration(milliseconds: 800),
                            //     chartLegendSpacing: 32,
                            //     chartRadius:
                            //         MediaQuery.of(context).size.width / 3,
                            //     // colorList: colorList,
                            //     initialAngleInDegree: 90,
                            //     chartType: ChartType.ring,
                            //     ringStrokeWidth: 40,
                            //     centerWidget: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         const Text("โบนัส"),
                            //         const Text("30000"),
                            //       ],
                            //     ),
                            //     legendOptions: LegendOptions(
                            //       showLegendsInRow: false,
                            //       // legendPosition: LegendPosition.bottom,
                            //       showLegends: false,
                            //       legendShape: BoxShape.circle,
                            //       legendTextStyle: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     chartValuesOptions: ChartValuesOptions(
                            //       showChartValueBackground: false,
                            //       showChartValues: false,
                            //       showChartValuesInPercentage: false,
                            //       showChartValuesOutside: true,
                            //       decimalPlaces: 0,
                            //     ),
                            //     gradientList: gradientList,
                            //     emptyColorGradient: [
                            //       // Color(0xff6c5ce7),
                            //       // Colors.blue,
                            //       AppTheme.ognGreen,
                            //       AppTheme.ognSoftGreen,
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: SfCircularChart(
                                      // Chart title
                                      // title: ChartTitle(
                                      //     text: 'Half yearly sales analysis'),
                                      // Enable legend
                                      // legend: Legend(
                                      //   isVisible: true,
                                      //   position: charts.LegendPosition.left,
                                      // ),
                                      // Enable tooltip
                                      tooltipBehavior:
                                          TooltipBehavior(enable: true),
                                      series: <DoughnutSeries<_GrapeData,
                                          String>>[
                                        DoughnutSeries<_GrapeData, String>(
                                          dataSource: data1,
                                          xValueMapper: (_GrapeData sales, _) =>
                                              sales.year,
                                          yValueMapper: (_GrapeData sales, _) =>
                                              sales.sales,
                                          pointColorMapper:
                                              (_GrapeData sales, _) =>
                                                  sales.color,
                                          name: 'Sales',
                                          // Enable data label
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: false),
                                          // starting angle of pie
                                          startAngle: 180,
                                          // ending angle of pie
                                          endAngle: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: SfCircularChart(
                                      // Chart title
                                      // title: ChartTitle(
                                      //     text: 'Half yearly sales analysis'),
                                      // Enable legend
                                      // legend: Legend(
                                      //   isVisible: true,
                                      //   position: charts.LegendPosition.right,
                                      // ),
                                      // Enable tooltip
                                      tooltipBehavior:
                                          TooltipBehavior(enable: true),
                                      series: <DoughnutSeries<_GrapeData,
                                          String>>[
                                        DoughnutSeries<_GrapeData, String>(
                                          dataSource: data2,
                                          xValueMapper: (_GrapeData sales, _) =>
                                              sales.year,
                                          yValueMapper: (_GrapeData sales, _) =>
                                              sales.sales,
                                          pointColorMapper:
                                              (_GrapeData sales, _) =>
                                                  sales.color,
                                          name: 'Sales',
                                          // Enable data label
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: false),
                                          // starting angle of pie
                                          startAngle: 0,
                                          // ending angle of pie
                                          endAngle: 180,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // itemDashboard('ลาป่วย', 'วัน', '0'),
                            // itemDashboard('ลากิจ', 'วัน', '0'),
                            // itemDashboard('ลาพักร้อน', 'วัน', '0'),
                            // itemDashboard('มาสาย', 'ครั้ง', '0'),
                            // itemDashboard('ลาอื่นๆ', 'วัน', '0'),
                            // itemDashboard('การมาทำงาน', '%', '100'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // subheading('Active Projects'),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        ActiveProjectsCard(
                          cardColor: AppTheme.ognSoftGreen,
                          loadingPercent: 0.25,
                          title: 'ลาป่วย',
                          subtitle: '9 hours progress',
                        ),
                        SizedBox(width: 20.0),
                        ActiveProjectsCard(
                          cardColor: AppTheme.ognSoftGreen,
                          loadingPercent: 0.6,
                          title: 'ลากิจ',
                          subtitle: '20 hours progress',
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ActiveProjectsCard(
                          cardColor: AppTheme.ognSoftGreen,
                          loadingPercent: 0.45,
                          title: 'ลาพักร้อน',
                          subtitle: '5 hours progress',
                        ),
                        SizedBox(width: 20.0),
                        ActiveProjectsCard(
                          cardColor: AppTheme.ognSoftGreen,
                          loadingPercent: 0.9,
                          title: 'มาสาย',
                          subtitle: '23 hours progress',
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ActiveProjectsCard(
                          cardColor: AppTheme.ognSoftGreen,
                          loadingPercent: 0.45,
                          title: 'ลาอื่นๆ',
                          subtitle: '5 hours progress',
                        ),
                        SizedBox(width: 20.0),
                        ActiveProjectsCard(
                          cardColor: AppTheme.ognSoftGreen,
                          loadingPercent: 0.9,
                          title: 'การมาทำงาน',
                          subtitle: '23 hours progress',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Container(
              //   decoration: BoxDecoration(
              //       // color: AppTheme.bgSoftGreen,
              //       color: Colors.grey[400],
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(40),
              //         topRight: Radius.circular(40),
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Color.fromARGB(255, 45, 45, 45).withOpacity(0.2),
              //           // spreadRadius: 0.1,
              //           blurRadius: 5,
              //           offset: Offset(0, -5),
              //         ),
              //       ]),
              //   child: Padding(
              //     // padding: const EdgeInsets.all(12.0),
              //     padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
              //     child: GridView.count(
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 40,
              //       mainAxisSpacing: 30,
              //       children: [
              //         itemDashboard('ลาป่วย / วัน', '0'),
              //         itemDashboard('ลากิจ / วัน', '0'),
              //         itemDashboard('ลาพักร้อน / วัน', '0'),
              //         itemDashboard('มาสาย / ครั้ง', '0'),
              //         itemDashboard('ลาอื่นๆ / วัน', '0'),
              //         itemDashboard('การมาทำงาน', '100%'),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, String type, String num) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            // color: AppTheme.ognSoftGreen,
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.025),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: Theme.of(context).primaryColor.withOpacity(.1),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            num,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(type),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'ใช้ไป',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          num,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(type),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'คงเหลือ',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          num,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(type),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfile() {
    return Center(
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          shadowColor: Colors.grey,
          elevation: 2,
          child: Transform.translate(
            offset: Offset(0, -1),
            child: Ink.image(
              image: NetworkImage(
                  'https://synergysoft.co.th/images/2022/06/30/user.png'),
              fit: BoxFit.cover,
              width: 128,
              height: 128,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName() {
    return Column(
      children: [
        Text(
          'Dr.Jel Organics',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          'บริษัท ออกานิกส์ คอสเม่ จำกัด',
          style: TextStyle(color: const Color.fromARGB(255, 225, 225, 225)),
        )
      ],
    );
  }

  Widget buildNumbers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildSubDetail(context, 'รหัสพนักงาน', 'IT 1234'),
        buildDivider(),
        buildSubDetail(context, 'ตำแหน่ง', 'IT Officer'),
        buildDivider(),
        buildSubDetail(context, 'OGN Coin', '0'),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      height: 40,
      child: VerticalDivider(),
    );
  }

  Widget buildSubDetail(BuildContext context, String value, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // fontSize: 16,
            ),
          ),
          SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAbout() {
    return Card(
      color: AppTheme.ognGreen,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'สถิติการมาทำงาน',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        buildCard('ลาป่วย / วัน', '10'),
                        buildCard('ลากิจ / วัน', '20'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        buildCard('ลาพักร้อน / วัน', '1'),
                        buildCard('มาสาย / ครั้ง', '30'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        buildCard('ลาอื่นๆ / วัน', '40'),
                        buildCard('การมาทำงาน / %', '50%'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String header, String quantity) {
    return Expanded(
      child: Column(
        children: [
          Text(
            header,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            quantity,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
