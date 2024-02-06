import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
  _GrapeData(this.percent, this.month, this.data, this.color, this.textColor);

  final String percent;
  final String month;
  final double data;
  final Color color;
  final Color textColor;
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
      _GrapeData('50%', 'Jan', 50, AppTheme.ognSoftGreen, Colors.white),
      _GrapeData('50%', 'Feb', 50, Colors.grey.shade200, Colors.black),
      // _GrapeData('Feb', 35),
      // _GrapeData('Mar', 34),
      // _GrapeData('Apr', 32),
      // _GrapeData('May', 40)
    ];
    // List<_GrapeData> data2 = <_GrapeData>[
    //   _GrapeData('ธันวาคม', 1, Colors.grey.shade200),
    //   _GrapeData('พฤษจิกายน', 1, Colors.grey.shade200),
    //   _GrapeData('ตุลาคม', 1, Colors.grey.shade200),
    //   _GrapeData('กันยายน', 1, Colors.grey.shade200),
    //   _GrapeData('สิงหาคม', 1, Colors.grey.shade200),
    //   _GrapeData('กรกฎาคม', 1, Colors.grey.shade200),
    //   _GrapeData('มิถุนายน', 1, Colors.grey.shade200),
    //   _GrapeData('พฤษภาคม', 1, Colors.grey.shade200),
    //   _GrapeData('เมษายน', 1, Colors.grey.shade200),
    //   _GrapeData('มีนาคม', 1, Colors.grey.shade200),
    //   _GrapeData('กุมภาพันธ์', 1, Colors.grey.shade200),
    //   _GrapeData('มกราคม', 1, Colors.grey.shade200),
    // ];
    List<_GrapeData> data2 = <_GrapeData>[
      _GrapeData('', 'ธ.ค.', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'พ.ย.', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'ต.ค', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'ก.ย.', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'ส.ค', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'ก.ค.', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'มิ.ย.', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'พ.ค.', 1, Colors.grey.shade200, Colors.black),
      _GrapeData('', 'เม.ย.', 1, Colors.redAccent.shade200, Colors.white),
      _GrapeData(
          '', 'มี.ค', 1, Color.fromARGB(255, 47, 170, 109), Colors.white),
      _GrapeData(
          '', 'ก.พ.', 1, Color.fromARGB(255, 47, 170, 109), Colors.white),
      _GrapeData(
          '', 'ม.ค.', 1, Color.fromARGB(255, 47, 170, 109), Colors.white),
    ];

    TextStyle getDataLabelTextStyle(_GrapeData data, int index) {
      return TextStyle(
        fontSize: 8,
        color: data.textColor,
      );
    }

    final box = GetStorage();

    return Container(
      color: AppTheme.ognGreen,
      // color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
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
                                color: Colors.white,
                              ),
                    ),
                    Text(
                      box.read('company_name_th'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white54,
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
              ],
            ),
          ),
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
                      color: Colors.white,
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
                            const Card(
                              color: AppTheme.ognSoftGreen,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'ประวัติการมาทำงานและกาารลา',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: SfCircularChart(
                                      // title: ChartTitle(
                                      //     text: 'Half monthly data analysis'),
                                      // legend: Legend(
                                      //   isVisible: true,
                                      //   position: charts.LegendPosition.left,
                                      // ),
                                      // tooltipBehavior:
                                      //     TooltipBehavior(enable: true),
                                      series: <DoughnutSeries<_GrapeData,
                                          String>>[
                                        DoughnutSeries<_GrapeData, String>(
                                          dataSource: data1,
                                          strokeWidth: 0.5,
                                          strokeColor: Colors.white,
                                          xValueMapper: (_GrapeData data, _) =>
                                              data.month,
                                          yValueMapper: (_GrapeData data, _) =>
                                              data.data,
                                          pointColorMapper:
                                              (_GrapeData data, _) =>
                                                  data.color,
                                          name: '% การมาทำงาน',
                                          dataLabelMapper:
                                              (_GrapeData data, _) =>
                                                  data.percent,
                                          dataLabelSettings: DataLabelSettings(
                                            textStyle: TextStyle(fontSize: 8),
                                            isVisible: true,
                                            labelPosition:
                                                ChartDataLabelPosition.inside,
                                            // useSeriesColor: true,
                                            // connectorLineSettings:
                                            //     ConnectorLineSettings(
                                            //   type: ConnectorType.line,
                                            //   length: '15%',
                                            // ),
                                          ),
                                          startAngle: 180,
                                          endAngle: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    child: SfCircularChart(
                                      // title: ChartTitle(
                                      //     text: 'Half monthly data analysis'),
                                      // legend: Legend(
                                      //   isVisible: true,
                                      //   position: charts.LegendPosition.right,
                                      // ),
                                      // tooltipBehavior:
                                      //     TooltipBehavior(enable: true),
                                      series: <DoughnutSeries<_GrapeData,
                                          String>>[
                                        DoughnutSeries<_GrapeData, String>(
                                          dataSource: data2,
                                          strokeWidth: 0.5,
                                          strokeColor: Colors.white,
                                          xValueMapper: (_GrapeData data, _) =>
                                              data.month,
                                          yValueMapper: (_GrapeData data, _) =>
                                              data.data,
                                          pointColorMapper:
                                              (_GrapeData data, _) =>
                                                  data.color,
                                          name: '% ตรงเวลา',
                                          dataLabelMapper:
                                              (_GrapeData data, _) =>
                                                  data.month,
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                            textStyle: TextStyle(
                                              fontSize: 8,
                                            ),
                                            isVisible: true,
                                            labelPosition:
                                                ChartDataLabelPosition.inside,
                                            // useSeriesColor: true,
                                            // connectorLineSettings:
                                            //     ConnectorLineSettings(
                                            //   type: ConnectorType.line,
                                            //   length: '15%',
                                            // ),
                                          ),
                                          startAngle: 0,
                                          endAngle: 180,
                                          explode: true,
                                          explodeIndex: 8,
                                          explodeOffset: '5%',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            itemDashboard('ลาป่วย', 'วัน', '0'),
                            itemDashboard('ลากิจ', 'วัน', '0'),
                            itemDashboard('ลาพักร้อน', 'วัน', '0'),
                            itemDashboard('มาสาย', 'ครั้ง', '0'),
                            itemDashboard('ลาอื่นๆ', 'วัน', '0'),
                            itemDashboard('การมาทำงาน', '%', '100'),
                          ],
                        ),
                      ),
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
