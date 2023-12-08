import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:organics_salary/pages/home/leave/leave_screen.dart';
import 'package:organics_salary/pages/home/emp_list/emp_list_screen.dart';
import 'package:organics_salary/pages/home/profile/profile_screen.dart';
import 'package:organics_salary/pages/home/salary/salary_screen.dart';
// import 'package:organics_salary/pages/home/coin/index.dart';
import 'package:organics_salary/theme.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    SalaryScreen(),
    LeaveScreen(),
    EmpListScreen(),
  ];

  late bool screenMode;

  bool get shouldShowAppBar =>
      _selectedIndex == 0 || _selectedIndex == _widgetOptions.length - 1;

  final _controller = SidebarXController(selectedIndex: 0);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return screenMode
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      // elevation: 20,
      // title: const Text('GoogleNavBar'),
      // ),
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: shouldShowAppBar
          ? _selectedIndex == 0
              ? AppBar(
                  title: Text(
                    'ข้อมูลส่วนตัว',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed('/setting');
                      },
                    )
                  ],
                  centerTitle: true,
                  backgroundColor: AppTheme.ognGreen,
                  foregroundColor: Colors.white,
                )
              : AppBar(
                  title: Text(
                    'รายการอื่น',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: AppTheme.ognGreen,
                  foregroundColor: Colors.white,
                )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
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
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 26,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: AppTheme.ognGreen!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.user,
                  text: 'โปรไฟล์',
                ),
                GButton(
                  icon: Icons.receipt_long_rounded,
                  iconSize: 23,
                  text: 'สลิปเงินเดือน',
                ),
                GButton(
                  icon: LineIcons.businessTime,
                  text: 'แจ้งลา',
                ),
                GButton(
                  icon: Icons.format_list_bulleted_rounded,
                  text: 'รายการอื่น',
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

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: _key,
      // appBar: shouldShowAppBar
      //     ? _selectedIndex == 0
      //         ? AppBar(
      //             title: Text(
      //               'ข้อมูลส่วนตัว',
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             actions: <Widget>[
      //               IconButton(
      //                 icon: Icon(
      //                   Icons.settings,
      //                   color: Colors.white,
      //                 ),
      //                 onPressed: () {
      //                   Get.toNamed('/setting');
      //                 },
      //               )
      //             ],
      //             centerTitle: true,
      //             backgroundColor: AppTheme.ognGreen,
      //             foregroundColor: Colors.white,
      //           )
      //         : AppBar(
      //             title: Text(
      //               'Organics Coin',
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //             centerTitle: true,
      //             backgroundColor: AppTheme.ognGreen,
      //             foregroundColor: Colors.white,
      //           )
      //     : null,
      // drawer: exampleSidebarX(),
      body: Row(
        children: [
          _drawer(),
          const VerticalDivider(
            thickness: 2,
            width: 1,
            color: AppTheme.ognSoftGreen,
          ),
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer() {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.ognGreen,
          // borderRadius: BorderRadius.circular(20),
        ),
        // hoverColor: scaffoldBackgroundColor,
        hoverTextStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.ognGreen),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppTheme.ognSoftGreen.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [AppTheme.ognGreen, AppTheme.ognGreen],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 20,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: AppTheme.ognGreen,
        ),
      ),
      // footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
                'https://synergysoft.co.th/images/2022/06/30/user.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: LineIcons.user,
          label: 'โปรไฟล์',
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        SidebarXItem(
          icon: Icons.receipt_long,
          label: 'สลิปเงินเดือน',
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        SidebarXItem(
          icon: LineIcons.businessTime,
          label: 'แจ้งลา',
          onTap: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
        SidebarXItem(
          icon: Icons.format_list_bulleted_rounded,
          label: 'รายการอื่น',
          onTap: () {
            setState(() {
              _selectedIndex = 3;
            });
          },
        ),
        // const SidebarXItem(
        //   iconWidget: FlutterLogo(size: 20),
        //   label: 'Flutter',
        // ),
      ],
      footerItems: [
        SidebarXItem(
          icon: Icons.settings,
          label: 'ตั้งค่า',
          onTap: () {
            Get.toNamed('setting');
          },
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width >= 600;
  }
}

// const primaryColor = Color(0xFF685BFF);
// const canvasColor = Color(0xFF2E2E48);
// const scaffoldBackgroundColor = Color(0xFF464667);
// const accentCanvasColor = Color(0xFF3E3E61);
// const white = Colors.white;
// final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
// final divider = Divider(color: white.withOpacity(0.3), height: 1);

const primaryColor = Color(0xFF136e68);
const canvasColor = Color(0xFF136e68);
const scaffoldBackgroundColor = Colors.white;
const accentCanvasColor = Color(0xFF136e68);
const white = Colors.white;
final actionColor = const Color(0xFF2b9d91).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
