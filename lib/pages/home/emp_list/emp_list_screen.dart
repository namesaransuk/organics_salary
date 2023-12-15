import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class EmpListScreen extends StatelessWidget {
  const EmpListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              buildListTile(
                'Organics Coin',
                'coin : 1000',
                LineIcons.coins,
                '/coin',
              ),
              buildListTile(
                'ประวัติการลงเวลา',
                '',
                Icons.alarm,
                '/time-history',
                isLastTile: true,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildListTile(
      String title, String subtitle, IconData iconData, String nextPage,
      {bool isThreeLine = false, bool isLastTile = false}) {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: CircleAvatar(child: Icon(iconData)),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                // fontWeight: FontWeight.w900,
              ),
            ),
            // subtitle: Text(
            //   subtitle,
            //   style: const TextStyle(
            //       // fontSize: 28.0,
            //       // fontWeight: FontWeight.w900,
            //       ),
            // ),
            isThreeLine: isThreeLine,
            onTap: () {
              Get.toNamed(nextPage);
            },
          ),
          if (!isLastTile)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // child: Divider(
              //   // indent: MediaQuery.of(context).size.width * 0.05,
              //   // endIndent: MediaQuery.of(context).size.width * 0.05,
              //   height: 15,
              // ),
            ),
        ],
      ),
    );
  }
}
