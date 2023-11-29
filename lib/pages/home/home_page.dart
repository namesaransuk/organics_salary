import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:organics_salary/pages/home/leave/leave_screen.dart';
import 'package:organics_salary/pages/home/profile/profile_screen.dart';
import 'package:organics_salary/pages/home/salary/salary_screen.dart';
import 'package:organics_salary/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    SalaryScreen(),
    LeaveScreen(),
    // CoinScreen(),
    Text(
      'หน้าแรก',
      style: optionStyle,
    ),
  ];

  bool get shouldShowAppBar =>
      _selectedIndex == 0 || _selectedIndex == _widgetOptions.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      // elevation: 20,
      // title: const Text('GoogleNavBar'),
      // ),
      appBar: shouldShowAppBar
          ? AppBar(
              title: _selectedIndex == 0
                  ? Text(
                      'ข้อมูลส่วนตัว',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      'Organics Coin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              centerTitle: true,
              backgroundColor: AppTheme.ognGreen,
              foregroundColor: Colors.white,
            )
          : null,
      body: Center(
        child: ListView(
          children: [
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: AppTheme.ognGreen!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.user,
                  text: 'โปรไฟล์',
                ),
                GButton(
                  icon: LineIcons.moneyCheck,
                  text: 'สลิปเงินเดือน',
                ),
                GButton(
                  icon: LineIcons.businessTime,
                  text: 'แจ้งลา',
                ),
                GButton(
                  icon: LineIcons.coins,
                  text: 'คอยน์',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
