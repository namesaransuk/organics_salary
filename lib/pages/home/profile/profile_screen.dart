import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/theme.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
    
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      // shrinkWrap: true,
      children: const [
        GetMainUI(),
      ],
    );
    // return Stack(
    //   children: [
    //     ListView(
    //       // shrinkWrap: true,
    //       children: const [
    //         GetMainUI(),
    //       ],
    //     ),
    //     SizedBox(
    //       height: MediaQuery.of(context).padding.bottom,
    //     )
    //   ],
    // );
  }
}

class GetMainUI extends StatefulWidget {
  const GetMainUI({super.key});

  @override
  State<GetMainUI> createState() => _GetMainUIState();
}

class _GetMainUIState extends State<GetMainUI> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: AppTheme.ognSoftGreen,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${box.read('f_name')} ${box.read('l_name')}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    Text(box.read('company_name_th'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54)),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(
                    '${box.read('image')}',
                    width: 200,
                  ),
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              color: AppTheme.ognSoftGreen,
              height: 200,
            ),
            Container(
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 245, 245, 245),
                  color: AppTheme.bgSoftGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    // topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 45, 45, 45).withOpacity(0.2),
                      // spreadRadius: 0.1,
                      blurRadius: 5,
                      offset: Offset(0, -5),
                    ),
                  ]),
              child: Padding(
                // padding: const EdgeInsets.all(12.0),
                padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard('ลาป่วย / วัน', '0'),
                    itemDashboard('ลากิจ / วัน', '0'),
                    itemDashboard('ลาพักร้อน / วัน', '0'),
                    itemDashboard('มาสาย / ครั้ง', '0'),
                    itemDashboard('ลาอื่นๆ / วัน', '0'),
                    itemDashboard('การมาทำงาน', '100%'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  itemDashboard(String title, String num) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            // color: AppTheme.bgSoftGreen,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              num,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );

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
