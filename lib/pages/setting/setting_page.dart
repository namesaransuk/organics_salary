import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:organics_salary/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            // SmallUserCard(
            //   cardColor: AppTheme.ognGreen,
            //   userName: "Babacar Ndong",
            //   userProfilePic: AssetImage("assets/img/organics_legendary.png",),
            //   onTap: (){},
            // ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.notifications_active,
                  iconStyle: IconStyle(
                    backgroundColor: AppTheme.ognGreen,
                  ),
                  title: 'การแจ้งเตือน',
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  // subtitle: "Make Ziar'App yours",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: AppTheme.ognGreen,
                  ),
                  title: 'โหมดมืด',
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    // overlayColor:MaterialStatePropertyAll(Colors.black),
                    // activeColor: Colors.black,
                    // focusColor: Colors.black,
                    thumbColor: MaterialStatePropertyAll(Colors.black),
                    trackOutlineColor: MaterialStatePropertyAll(Colors.black),
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.home_work,
                  iconStyle: IconStyle(
                    backgroundColor: AppTheme.ognGreen,
                  ),
                  title: 'เว็บไซต์บริษัท',
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  // subtitle: "Learn more about Ziar'App",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.facebook,
                  iconStyle: IconStyle(
                    backgroundColor: AppTheme.ognGreen,
                  ),
                  title: 'เฟสบุ๊คบริษัท',
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  // subtitle: "Learn more about Ziar'App",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: AppTheme.ognGreen,
                  ),
                  title: 'ติดต่อ',
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  // subtitle: "Learn more about Ziar'App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              // settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.exit_to_app_rounded,
                  iconStyle: IconStyle(
                      iconsColor: Colors.red, backgroundColor: Colors.white),
                  title: "ออกจากระบบ",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                // SettingsItem(
                //   onTap: () {},
                //   icons: Icons.delete,
                //   title: "Delete account",
                //   titleStyle: TextStyle(
                //     color: Colors.red,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
