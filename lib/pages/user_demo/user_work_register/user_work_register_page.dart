import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class UserWorkRegister extends StatefulWidget {
  const UserWorkRegister({super.key});

  @override
  State<UserWorkRegister> createState() => _UserWorkRegisterState();
}

class _UserWorkRegisterState extends State<UserWorkRegister> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    print(_customTileExpanded);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/user_demo/organics.png',
                  width: 120,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'บริษัท ออกานิกส์คอสเม่ จำกัด (สำนักงานใหญ่)',
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.ognMdGreen,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  '87/5 หมู่ 2 ต.บ่อพลับ อ.เมือง จ.นครปฐม 73000',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.ognMdGreen,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: [
                      const Text(
                        'รับสมัครงาน',
                        style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.ognMdGreen,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ตำแหน่งที่รับสมัคร',
                              style: TextStyle(
                                  fontSize: 16, color: AppTheme.ognOrangeGold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '1. พนักงานฝ่ายผลิต',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '2. พนักงานฝ่ายควบคุมคุณภาพ',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '3. ผู้ช่วยฝ่ายขาย',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '4. Research and Development (R&D) ฝ่ายผลิตภัณฑ์เสริมอาหาร',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      ExpansionTile(
                        title: const Text(
                          'เอกสารที่ใช้',
                          style: TextStyle(color: AppTheme.ognOrangeGold),
                        ),
                        // subtitle: const Text('Custom expansion arrow icon'),
                        trailing: const Icon(
                          // _customTileExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                          Icons.arrow_drop_down,
                        ),
                        // collapsedIconColor: AppTheme.ognOrangeGold,
                        iconColor: AppTheme.ognOrangeGold,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        childrenPadding:
                            const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        children: <Widget>[
                          Text(
                            '1. สำเนาบัตรประชาชน 1 ใบ',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '2. สำเนาทะเบียบบ้าน 1 ใบ',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '3. สำเนาวุฒิการศึกษา 1 ใบ',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '4. รูปถ่าย 1 นิ้ว จำนวน 2 รูป (ถ่ายไม่เกิน 6 เดือน)',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '5. หน้าบัญชีธนาคารกสิกรไทย 1 ใบ',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '6. สำเนาหลักฐานการฉีดวัคซีนโควิด 19 จำนวน 1 ฉบับ',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            _customTileExpanded = expanded;
                          });
                        },
                      ),
                      ExpansionTile(
                        title: const Text(
                          'สวัสดิการ',
                          style: TextStyle(color: AppTheme.ognOrangeGold),
                        ),
                        // subtitle: const Text('Custom expansion arrow icon'),
                        trailing: const Icon(
                          // _customTileExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                          Icons.arrow_drop_down,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        childrenPadding:
                            const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        children: <Widget>[
                          Text(
                            '1. ประกันสังคม',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '2. เบี้ยขยัน + ค่าน้ำมันรถ',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '3. โบนัสประจำปี',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '4. ปรับฐานเงินเดือนรายปี',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '5. วันหยุดประจำปี',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '6. ลาพักร้อนประจำปี',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '7. ตรวจสุขภาพประจำปี',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '8. ชุดยูนิฟอร์ม',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            _customTileExpanded = expanded;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'ติดต่อสมัครงานได้ที่',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.ognMdGreen,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'เวลาทำการ วันจันทร์ – เสาร์ เวลา 9.00 – 16.00 น.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.ognMdGreen,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ognOrangeGold),
                  onPressed: () {
                    _makePhoneCall('0898362222');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '089-8362222',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ognOrangeGold),
                  onPressed: () {
                    _makePhoneCall('0954753359');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '095-4753359',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ognOrangeGold),
                  onPressed: () {
                    _makeSendEmail('document@organicscosme.com');
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'document@organicscosme.com',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch $launchUri');
    }
  }

  Future<void> _makeSendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'สมัครงาน Organics'},
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch $launchUri');
    }
  }
}
