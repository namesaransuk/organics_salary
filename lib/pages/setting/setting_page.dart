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

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                /// -- IMAGE
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      '${box.read('image')}',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${box.read('f_name')} ${box.read('l_name')}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text('รหัสพนักงาน : ${box.read('employee_code')}'),
                Text('แผนก : ${box.read('position_name_th')}'),
                const SizedBox(height: 20),

                /// -- BUTTON
                SizedBox(
                  // width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        // backgroundColor: tPrimaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(
                      'เปลี่ยนรหัสผ่าน',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _bildDivider(),
                const SizedBox(height: 10),

                /// -- MENU
                ProfileMenuWidget(
                    title: "การแจ้งเตือน",
                    icon: Icons.notifications_active_rounded,
                    onPress: () {}),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "เว็ปไซต์บริษัท",
                    icon: Icons.home_work_rounded,
                    onPress: () {
                      _open('https://www.organicscosme.com');
                    }),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "เฟสบุ๊คบริษัท",
                    icon: Icons.facebook_rounded,
                    onPress: () {
                      _open('https://www.facebook.com/organicscosme/');
                    }),
                const SizedBox(height: 10),
                _bildDivider(),
                const SizedBox(height: 10),
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
                            backgroundColor: Colors.white,
                            title: Text('แจ้งเตือน'),
                            content: Text('ต้องการออกจากระบบใช่หรือไม่?'),
                            actionsAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }

  Widget _bildDivider() {
    return Divider(
      color: Colors.grey,
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

    return ListTile(
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
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
