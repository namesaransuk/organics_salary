import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/logout_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = Get.put(LogoutController());
    final box = GetStorage();
    print(box.read('access_token'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.ognGreen,
        foregroundColor: Colors.white,
        title: Text(
          'การตั้งค่า',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/bggreen.jpg'),
                    fit: BoxFit.cover,
                  ),
                  // color: AppTheme.ognSoftGreen,
                  // borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    ClipOval(
                      child: Container(
                        color: Colors.white,
                        child: box.read('image').startsWith('http') ||
                                box.read('image').startsWith('https')
                            ? Image.network(
                                '${box.read('image')}',
                                width: MediaQuery.of(context).size.width * 0.3,
                              )
                            : Image.asset(
                                '${box.read('image')}',
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${box.read('f_name')} ${box.read('l_name')}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Text(
                      'รหัสพนักงาน : ${box.read('employee_code')}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'แผนก : ${box.read('position_name_th')}',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    /// -- BUTTON
                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/changepass');
                        },
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.password_rounded,
                                size: 18.0, color: AppTheme.ognGreen),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'เปลี่ยนรหัสผ่าน',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/pinauth');
                        },
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.pin,
                                size: 18.0, color: AppTheme.ognGreen),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'เปลี่ยนรหัส PIN',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                /// -- MENU
                ProfileMenuWidget(
                    title: "การแจ้งเตือน",
                    icon: Icons.notifications_active_rounded,
                    onPress: () {}),
                const SizedBox(height: 2),
                ProfileMenuWidget(
                    title: "เว็ปไซต์บริษัท",
                    icon: Icons.home_work_rounded,
                    onPress: () {
                      _open('https://www.organicscosme.com');
                    }),
                const SizedBox(height: 2),
                ProfileMenuWidget(
                    title: "เฟสบุ๊คบริษัท",
                    icon: Icons.facebook_rounded,
                    onPress: () {
                      _open('https://www.facebook.com/organicscosme/');
                    }),
                const SizedBox(height: 5),
                _bildDivider(),
                const SizedBox(height: 5),
                ProfileMenuWidget(
                    title: "ออกจากระบบ",
                    icon: Icons.exit_to_app,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            clipBehavior: Clip.antiAlias,
                            actionsAlignment: MainAxisAlignment.center,
                            backgroundColor: Colors.white,
                            titlePadding: EdgeInsets.zero,
                            title: Container(
                              color: AppTheme.ognGreen,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Center(
                                child: Text(
                                  'แจ้งเตือน',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            content: Text('ต้องการออกจากระบบใช่หรือไม่?'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("ยกเลิก"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // box.erase();
                                  // Get.offAllNamed('/login');
                                  logoutController.logout();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.ognGreen,
                                ),
                                child: Text(
                                  "ตกลง",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _bildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.2),
      indent: MediaQuery.of(context).size.width * 0.05,
      endIndent: MediaQuery.of(context).size.width * 0.05,
    );
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

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var iconColor = endIcon ? AppTheme.ognSoftGreen : Colors.red;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.white),
      ),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white),
        ),
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: iconColor.withOpacity(0.1),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title,
            style:
                Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
        trailing: endIcon
            ? const Icon(Icons.arrow_forward_ios_rounded,
                size: 18.0, color: Colors.grey)
            : null,
      ),
    );
  }
}
