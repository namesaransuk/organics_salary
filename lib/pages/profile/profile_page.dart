import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool screenMode;
  final box = GetStorage();
  final baseUrl = dotenv.env['ASSET_URL'];

  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(box.read('birthday'));
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
                child: ClipOval(
                  child: box.read('profileImage') != null ||
                          box.read('profileImage') != ''
                      ? Image.network(
                          '$baseUrl/${box.read('profileImage')}',
                          width: MediaQuery.of(context).size.width *
                              (screenMode ? 0.15 : 0.35),
                          height: MediaQuery.of(context).size.width *
                              (screenMode ? 0.15 : 0.35),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/img/user.png',
                              width: MediaQuery.of(context).size.width *
                                  (screenMode ? 0.15 : 0.35),
                              height: MediaQuery.of(context).size.width *
                                  (screenMode ? 0.15 : 0.35),
                            );
                          },
                        )
                      : Image.asset(
                          'assets/img/user.png',
                          width: MediaQuery.of(context).size.width *
                              (screenMode ? 0.15 : 0.35),
                          height: MediaQuery.of(context).size.width *
                              (screenMode ? 0.15 : 0.35),
                        ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              listEmployee(Icons.account_circle_rounded, 'คำนำหน้าชื่อ',
                  box.read('prefix')),
              listEmployee(Icons.person, 'ชื่อ - นามสกุล',
                  '${box.read('fnames')} ${box.read('lnames')}'),
              listEmployee(Icons.contacts_rounded, 'รหัสพนักงาน',
                  box.read('employeeCode')),
              // listEmployee(Icons.person_pin_rounded, 'ตำแหน่ง', box.read('position_name_th')),
              listEmployee(Icons.wc_rounded, 'เพศ', box.read('gender')),
              listEmployee(Icons.calendar_month_sharp, 'วัน/เดือน/ปีเกิด',
                  formattedDate),
              listEmployee(Icons.badge_rounded, 'เลขประจำตัวประชาชน',
                  box.read('idCard')),
              listEmployee(Icons.phone, 'เบอร์ติดต่อ', box.read('phoneNumber')),
              const Spacer(),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     elevation: 0,
              //     backgroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(25.0),
              //       side: BorderSide(color: AppTheme.ognOrangeGold),
              //     ),
              //   ),
              //   onPressed: () {
              //     // Get.offAllNamed('/');
              //   },
              //   child: const SizedBox(
              //     width: double.infinity,
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(vertical: 15),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(
              //             Icons.edit_note_rounded,
              //             color: AppTheme.ognOrangeGold,
              //             size: 22,
              //           ),
              //           SizedBox(
              //             width: 5,
              //           ),
              //           Text(
              //             'แก้ไขข้อมูล',
              //             style: TextStyle(
              //               color: AppTheme.ognOrangeGold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listEmployee(IconData icon, String prefix, String detail) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppTheme.ognOrangeGold,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    prefix,
                    style: const TextStyle(color: AppTheme.ognMdGreen),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                detail != '' && detail != 'null' ? detail : '-',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
    print('SCREEN : ${MediaQuery.of(context).size.width}');
  }
}
