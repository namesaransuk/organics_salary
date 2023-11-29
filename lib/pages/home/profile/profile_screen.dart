import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          buildProfile(),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          buildNumbers(),
          const SizedBox(height: 24),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildProfile() {
    final color = Theme.of(context).colorScheme.primary;

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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          'บริษัท ออกานิกส์ คอสเม่ จำกัด',
          style: TextStyle(color: Colors.grey),
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
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'ลาป่วย / วัน',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '10',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'ลากิจ / วัน',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '20',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'ลาพักร้อน / วัน',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'มาสาย / ครั้ง',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '30',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'ลาอื่นๆ / วัน',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '40',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'การมาทำงาน / ครั้ง',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '50%',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
