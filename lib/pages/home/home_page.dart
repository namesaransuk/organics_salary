import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/pages/home/menu/menu_screen.dart';
import 'package:organics_salary/pages/home/notification/notification_screen.dart';
import 'package:organics_salary/pages/home/dashboard/dashboard_screen.dart';
import 'package:organics_salary/pages/home/setting/setting_screen.dart';
import 'package:organics_salary/theme.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter/gestures.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final box = GetStorage();
  int _selectedIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != _selectedIndex && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
    // FirebaseMessaging.instance.getToken().then((value) => print(value));
  }

  void changePage(int newPage) {
    setState(() {
      _selectedIndex = newPage;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const MenuScreen(),
    // const ScanPage(),
    const NotificationScreen(),
    const SettingScreen(),
  ];

  late bool screenMode;

  // bool get shouldShowAppBar =>
  //     _selectedIndex == 1 || _selectedIndex == _widgetOptions.length - 1;
  bool get shouldShowAppBar => _selectedIndex == 1 || _selectedIndex == 3;

  final _controller = SidebarXController(selectedIndex: 0);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return screenMode ? buildDrawerScaffold(context) : buildBottomBarScaffold();
  }

  Widget buildBottomBarScaffold() {
    // String osVersion = Platform.version;
    // print('OSSSSSSSSSS : $osVersion');
    print(MediaQuery.of(context).viewPadding.bottom > 0 ? 'have' : 'dont have');
    return UpgradeAlert(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: BottomBar(
            clip: Clip.antiAlias,
            // fit: StackFit.expand,
            borderRadius: BorderRadius.circular(500),
            duration: Duration(seconds: 1),
            curve: Curves.decelerate,
            showIcon: true,
            width: MediaQuery.of(context).size.width * 0.88,
            barColor: Colors.white,
            start: 0,
            end: Platform.isAndroid ? -0.15 : 0.2,
            offset: 0,
            barAlignment: Alignment.bottomCenter,
            iconHeight: 35,
            iconWidth: 35,
            reverse: false,
            barDecoration: BoxDecoration(
              // color: colors[currentPage],
              borderRadius: BorderRadius.circular(500),
              boxShadow: [
                BoxShadow(
                  // color: Colors.grey.shade300,
                  // spreadRadius: 2,
                  // blurRadius: 7,
                  // offset: Offset(0, 3),
                  color: Colors.black.withOpacity(0.1), // เงาสีดำโปร่งใส
                  offset: const Offset(0, 4), // เงาอยู่ด้านล่าง
                  blurRadius: 10, // ความเบลอของเงา
                  spreadRadius: 2, // การกระจายของเงา
                ),
              ],
            ),
            hideOnScroll: true,
            scrollOpposite: false,
            onBottomBarHidden: () {},
            onBottomBarShown: () {},
            body: (context, controller) => TabBarView(
              controller: tabController,
              dragStartBehavior: DragStartBehavior.down,
              physics: const NeverScrollableScrollPhysics(),
              children: _widgetOptions,
            ),
            child: TabBar(
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              controller: tabController,
              padding: EdgeInsets.symmetric(vertical: 10),
              dividerColor: Colors.transparent,
              indicatorWeight: 0.0,
              // indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
                insets: EdgeInsets.zero,
              ),
              tabs: [
                Tab(
                  child: Column(
                    children: [
                      Icon(
                        Icons.home_rounded,
                        size: 32,
                        color: _selectedIndex == 0
                            ? AppTheme.ognOrangeGold
                            : AppTheme.ognSmGreen,
                      ),
                      Text(
                        'หน้าหลัก',
                        style: TextStyle(
                          fontSize: 10,
                          color: _selectedIndex == 0
                              ? AppTheme.ognOrangeGold
                              : AppTheme.ognSmGreen,
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Icon(
                        Icons.widgets_rounded,
                        size: 32,
                        color: _selectedIndex == 1
                            ? AppTheme.ognOrangeGold
                            : AppTheme.ognSmGreen,
                      ),
                      Text(
                        'เมนู',
                        style: TextStyle(
                          fontSize: 10,
                          color: _selectedIndex == 1
                              ? AppTheme.ognOrangeGold
                              : AppTheme.ognSmGreen,
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 32,
                        color: _selectedIndex == 2
                            ? AppTheme.ognOrangeGold
                            : AppTheme.ognSmGreen,
                      ),
                      Text(
                        'แจ้งเตือน',
                        style: TextStyle(
                          fontSize: 10,
                          color: _selectedIndex == 2
                              ? AppTheme.ognOrangeGold
                              : AppTheme.ognSmGreen,
                        ),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: [
                      Icon(
                        Icons.settings_rounded,
                        size: 32,
                        color: _selectedIndex == 3
                            ? AppTheme.ognOrangeGold
                            : AppTheme.ognSmGreen,
                      ),
                      Text(
                        'ตั้งค่า',
                        style: TextStyle(
                          fontSize: 10,
                          color: _selectedIndex == 3
                              ? AppTheme.ognOrangeGold
                              : AppTheme.ognSmGreen,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  // Widget buildBottomBarScaffold() {
  //   print(MediaQuery.of(context).viewPadding.bottom > 0 ? 'have' : 'dont have');
  //   return UpgradeAlert(
  //     child: Scaffold(
  //       resizeToAvoidBottomInset: false,
  //       extendBody: true,
  //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //       body: FrostedBottomBar(
  //         bottomBarColor: Colors.white,
  //         opacity: 1,
  //         fit: StackFit.expand,
  //         borderRadius: BorderRadius.circular(80),
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.decelerate,
  //         width: MediaQuery.of(context).size.width * 0.88,
  //         start: 0,
  //         end: Platform.isAndroid
  //             ? 0
  //             : MediaQuery.of(context).viewPadding.bottom > 0
  //                 ? -0.5
  //                 : 0,
  //         bottom: 0,
  //         reverse: false,
  //         hideOnScroll: true,
  //         scrollOpposite: false,
  //         onBottomBarHidden: () {},
  //         onBottomBarShown: () {},
  //         // body: _widgetOptions.elementAt(_selectedIndex),
  //         body: (context, controller) => TabBarView(
  //           controller: tabController,
  //           dragStartBehavior: DragStartBehavior.down,
  //           physics: const NeverScrollableScrollPhysics(),
  //           children: _widgetOptions,
  //         ),
  //         child: Stack(
  //           children: [
  //             Container(
  //               margin: EdgeInsets.all(2),
  //               child: TabBar(
  //                 controller: tabController,
  //                 padding: EdgeInsets.symmetric(vertical: 8),
  //                 dividerColor: Colors.transparent,
  //                 indicatorWeight: 0.0,
  //                 // indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
  //                 indicator: const UnderlineTabIndicator(
  //                   borderSide: BorderSide(
  //                     color: Colors.transparent,
  //                     width: 0,
  //                   ),
  //                   insets: EdgeInsets.zero,
  //                 ),
  //                 tabs: [
  //                   SizedBox(
  //                     // height: 55,
  //                     width: 40,
  //                     child: Column(
  //                       children: [
  //                         Icon(
  //                           Icons.home_rounded,
  //                           size: 32,
  //                           color: _selectedIndex == 0 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                         ),
  //                         Text(
  //                           'หน้าหลัก',
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             color: _selectedIndex == 0 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     // height: 55,
  //                     width: 40,
  //                     child: Column(
  //                       children: [
  //                         Icon(
  //                           Icons.widgets_rounded,
  //                           size: 32,
  //                           color: _selectedIndex == 1 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                         ),
  //                         Text(
  //                           'เมนู',
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             color: _selectedIndex == 1 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   // InkWell(
  //                   //   onTap: () {},
  //                   //   splashColor: Colors.white,
  //                   //   child: const SizedBox(
  //                   //     height: 55,
  //                   //     width: 40,
  //                   //     child: Center(
  //                   //       child: Icon(
  //                   //         Icons.qr_code_scanner_rounded,
  //                   //         color: Colors.white,
  //                   //       ),
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                   SizedBox(
  //                     // height: 55,
  //                     width: 40,
  //                     child: Column(
  //                       children: [
  //                         Icon(
  //                           Icons.notifications,
  //                           size: 32,
  //                           color: _selectedIndex == 2 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                         ),
  //                         Text(
  //                           'แจ้งเตือน',
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             color: _selectedIndex == 2 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     // height: 55,
  //                     width: 40,
  //                     child: Column(
  //                       children: [
  //                         Icon(
  //                           Icons.settings_rounded,
  //                           size: 32,
  //                           color: _selectedIndex == 3 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                         ),
  //                         Text(
  //                           'ตั้งค่า',
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             color: _selectedIndex == 3 ? AppTheme.ognOrangeGold : AppTheme.ognSmGreen,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             // Positioned(
  //             //   top: -20,
  //             //   child: FloatingActionButton(
  //             //     elevation: 0,
  //             //     backgroundColor: AppTheme.ognMdGreen,
  //             //     onPressed: () {
  //             //       Get.toNamed('scan');
  //             //     },
  //             //     shape: RoundedRectangleBorder(
  //             //       borderRadius: BorderRadius.circular(17), // รูปร่างของปุ่ม
  //             //       side:
  //             //           const BorderSide(color: Colors.white, width: 2), // เส้นขอบสีขาว
  //             //     ),
  //             //     child: const Icon(Icons.qr_code_scanner_rounded),
  //             //   ),
  //             // )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildDrawerScaffold(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        key: _key,
        extendBody: true,
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: SafeArea(
          child: Row(
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
        ),
      ),
    );
  }

  Widget _drawer() {
    final baseUrl = dotenv.env['ASSET_URL'];

    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        // margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/drawer.png'),
            fit: BoxFit.cover,
          ),
          // color: AppTheme.ognMdGreen,
          // borderRadius: BorderRadius.circular(20),
        ),
        // hoverColor: scaffoldBackgroundColor,
        hoverTextStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        // itemDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(color: AppTheme.ognMdGreen),
        // ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppTheme.ognSoftGreen.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [AppTheme.ognMdGreen, AppTheme.ognSmGreen],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 5,
            )
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 25,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 25,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          // color: AppTheme.ognMdGreen,
          image: DecorationImage(
            image: AssetImage('assets/img/drawer.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      // footerDivider: divider,
      headerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: SizedBox(
            child: ClipOval(
              child: box.read('profileImage') != null ||
                      box.read('profileImage') != ''
                  ? Image.network(
                      '$baseUrl/${box.read('profileImage')}',
                      width: MediaQuery.of(context).size.width *
                          (MediaQuery.of(context).size.width >= 1024
                              ? 0.045
                              : 0.065),
                      height: MediaQuery.of(context).size.width *
                          (MediaQuery.of(context).size.width >= 1024
                              ? 0.045
                              : 0.065),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/img/user.png',
                          width: MediaQuery.of(context).size.width *
                              (MediaQuery.of(context).size.width >= 1024
                                  ? 0.045
                                  : 0.065),
                          height: MediaQuery.of(context).size.width *
                              (MediaQuery.of(context).size.width >= 1024
                                  ? 0.045
                                  : 0.065),
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/img/user.png',
                      width: MediaQuery.of(context).size.width *
                          (MediaQuery.of(context).size.width >= 1024
                              ? 0.045
                              : 0.065),
                      height: MediaQuery.of(context).size.width *
                          (MediaQuery.of(context).size.width >= 1024
                              ? 0.045
                              : 0.065),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home_rounded,
          label: 'หน้าแรก',
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        SidebarXItem(
          icon: Icons.widgets_rounded,
          label: 'เมนู',
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        SidebarXItem(
          icon: Icons.notifications_rounded,
          label: 'แจ้งเตือน',
          onTap: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
        SidebarXItem(
          icon: Icons.settings_rounded,
          label: 'ตั้งค่า',
          onTap: () {
            setState(() {
              _selectedIndex = 3;
            });
          },
        ),
      ],
      // footerItems: [
      //   SidebarXItem(
      //     icon: Icons.qr_code_rounded,
      //     label: 'แสกน Qr Code',
      //     onTap: () {
      //       setState(() {
      //         Get.toNamed('scan');
      //       });
      //     },
      //   ),
      // ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
