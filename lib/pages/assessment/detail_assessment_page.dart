import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organics_salary/theme.dart';

class DetailAssessmentPage extends StatefulWidget {
  const DetailAssessmentPage({super.key});

  @override
  State<DetailAssessmentPage> createState() => _DetailAssessmentPageState();
}

class _DetailAssessmentPageState extends State<DetailAssessmentPage> {
  late bool screenMode;

  // final LeaveApproveController leaveApproveController =
  //     Get.put(LeaveApproveController());

  @override
  Widget build(BuildContext context) {
    // final item = Get.arguments;

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
          'ประวัติการประเมิน',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                rowDetail(FontAwesomeIcons.calendarDays, 'วันที่ทำแบบประเมิน',
                    '20/02/2025'),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.list,
                      color: AppTheme.ognOrangeGold,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'รายการประเมิน',
                        style:
                            TextStyle(color: AppTheme.ognMdGreen, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        color: AppTheme.ognOrangeGold,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'รายการ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'คะแนน',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      '1. Ownership - มีความรับผิดชอบและทุ่มเทในงาน',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'ดีมาก (5)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'รวมคะแนน (40)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '40',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.list,
                      color: AppTheme.ognOrangeGold,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'คำแนะนำเพิ่มเติม',
                        style:
                            TextStyle(color: AppTheme.ognMdGreen, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'ไม่มีคำแนะนำ',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowDetail(IconData icon, String title, String detail) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppTheme.ognOrangeGold,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title :',
                // textAlign: TextAlign.justify,
                style: TextStyle(color: AppTheme.ognMdGreen, fontSize: 12),
              ),
            ),
            Expanded(
              child: Text(
                detail,
                textAlign: TextAlign.right,
                style:
                    const TextStyle(color: AppTheme.ognMdGreen, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
