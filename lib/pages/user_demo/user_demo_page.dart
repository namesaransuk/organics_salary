import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/pages/user_demo/user_contact/user_contact_page.dart';
import 'package:organics_salary/pages/user_demo/user_home/user_home_page.dart';
import 'package:organics_salary/pages/user_demo/user_work_register/user_work_register_page.dart';
import 'package:organics_salary/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDemoPage extends StatefulWidget {
  const UserDemoPage({super.key});

  @override
  State<UserDemoPage> createState() => _UserDemoPageState();
}

class _UserDemoPageState extends State<UserDemoPage> {
  final box = GetStorage();
  final _advancedDrawerController = AdvancedDrawerController();

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    UserHomePage(),
    UserWorkRegister(),
    UserContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppTheme.ognSmGreen,
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     AppTheme.ognSoftGreen,
          //     Color.fromARGB(255, 198, 240, 236),
          //   ],
          // ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 24.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/img/user_demo/organics_legendary.png',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      box.read('f_name'),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      box.read('l_name'),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Divider(
                    color: Colors.white,
                    height: 30,
                  ),
                ),
                ListTile(
                  onTap: () {
                    _onItemTapped(0);
                  },
                  leading: const Icon(Icons.home_work_rounded),
                  title: const Text('หน้าแรก'),
                ),
                ListTile(
                  onTap: () {
                    _onItemTapped(1);
                  },
                  leading: const Icon(Icons.work_rounded),
                  title: const Text('สมัครทำงาน'),
                ),
                ListTile(
                  onTap: () {
                    _onItemTapped(2);
                  },
                  leading: const Icon(Icons.diversity_1_rounded),
                  title: const Text('ติดต่อ'),
                ),
                ListTile(
                  onTap: () {
                    // _onItemTapped(2);
                    GetStorage().erase();
                    Get.offAndToNamed('login');
                  },
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('ออกจากระบบ'),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: InkWell(
                    onTap: () => _open(
                        'https://organicscosme.com/dataprivacypolicy.html'),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: const Text('Terms of Service | Privacy Policy'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Organics Legendary',
            style: TextStyle(fontSize: 16),
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: _widgetOptions[_selectedIndex],
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  _open(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
