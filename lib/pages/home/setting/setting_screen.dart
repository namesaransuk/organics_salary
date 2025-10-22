import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/logout_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = Get.put(LogoutController());
    final box = GetStorage();
    final baseUrl = dotenv.env['ASSET_URL'];

    return Container(
      // height: double.infinity,
      color: AppTheme.bgSoftGreen,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  // margin: const EdgeInsets.symmetric(vertical: 8.0),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(16),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey.withOpacity(0.3),
                  //       spreadRadius: 2,
                  //       blurRadius: 5,
                  //       offset: const Offset(0, 3),
                  //     ),
                  //   ],
                  // ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: box.read('profileImage') != null &&
                                box.read('profileImage') != ''
                            ? Image.network(
                                '$baseUrl/${box.read('profileImage')}',
                                width: MediaQuery.of(context).size.width *
                                    (screenMode ? 0.08 : 0.18),
                                height: MediaQuery.of(context).size.width *
                                    (screenMode ? 0.08 : 0.18),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/img/user.png',
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width *
                                        (screenMode ? 0.08 : 0.18),
                                    height: MediaQuery.of(context).size.width *
                                        (screenMode ? 0.08 : 0.18),
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/img/user.png',
                                width: MediaQuery.of(context).size.width *
                                    (screenMode ? 0.08 : 0.18),
                                height: MediaQuery.of(context).size.width *
                                    (screenMode ? 0.08 : 0.18),
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(
                          width: 12), // ระยะห่างระหว่างรูปภาพและข้อความ
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${box.read('fnames')} ${box.read('lnames')}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.ognGreen,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'รหัสพนักงาน : ${box.read('employeeCode')}',
                              style: const TextStyle(
                                color: AppTheme.ognGreen,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'ตำแหน่ง : ${box.read('department')}',
                              style: const TextStyle(
                                color: AppTheme.ognGreen,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      // buildListTile(
                      //   title: 'การตั้งค่าการแจ้งเตือน',
                      //   icon: Icons.notifications_none_rounded,
                      //   onPress: () => Get.toNamed('/notification'),
                      // ),
                      buildListTile(
                        title: 'เปลี่ยนรหัสผ่าน',
                        icon: FontAwesomeIcons.unlock,
                        onPress: () => Get.toNamed('/changepass'),
                      ),
                      buildListTile(
                        title: 'เปลี่ยนรหัส PIN',
                        icon: FontAwesomeIcons.xmarksLines,
                        onPress: () => Get.toNamed('/pinauth-tochange'),
                      ),
                      buildListTile(
                        title: 'ลบบัญชีผู้ใช้',
                        icon: FontAwesomeIcons.trash,
                        textColor: AppTheme.ognOrangeGold,
                        iconColor: AppTheme.ognOrangeGold,
                      ),
                      buildListTile(
                        title: 'นโยบายคุ้มครองส่วนบุคคล',
                        icon: FontAwesomeIcons.buildingShield,
                        onPress: () => _open(
                            'https://organicscosme.com/dataprivacypolicy.html'),
                        lastDivider: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      buildListTile(
                        title: 'เว็บไซต์บริษัท',
                        icon: FontAwesomeIcons.earthAmericas,
                        onPress: () => _open('https://www.organicscosme.com'),
                      ),
                      buildListTile(
                        title: 'เฟสบุคบริษัท',
                        icon: FontAwesomeIcons.facebook,
                        onPress: () =>
                            _open('https://www.facebook.com/organicscosme/'),
                        lastDivider: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(AppTheme.ognOrangeGold),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'ออกจากระบบ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          clipBehavior: Clip.antiAlias,
                          actionsAlignment: MainAxisAlignment.center,
                          backgroundColor: Colors.white,
                          titlePadding: EdgeInsets.zero,
                          title: Container(
                            color: AppTheme.ognSmGreen,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: const Center(
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
                          content: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ต้องการออกจากระบบใช่หรือไม่?'),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("ยกเลิก"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // box.erase();
                                // Get.offAllNamed('/login');
                                logoutController.logout();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.ognSmGreen,
                              ),
                              child: const Text(
                                "ตกลง",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }

  Widget buildListTile(
      {required String title,
      required IconData icon,
      Color? iconColor,
      Color? textColor,
      VoidCallback? onPress,
      bool lastDivider = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            key: null,
            onTap: onPress,
            leading: Icon(
              icon,
              color: iconColor ?? AppTheme.ognGreen,
              size: 20,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: textColor ?? AppTheme.ognGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
          ),
        ),
        lastDivider
            ? Container()
            : Divider(
                color: Colors.grey[200],
                thickness: 1,
                height: 0,
              ),
      ],
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
