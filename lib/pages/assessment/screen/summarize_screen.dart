import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/assessment_controller.dart';
import 'package:organics_salary/pages/assessment/screen/custom_card.dart';
import 'package:organics_salary/theme.dart';

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});

  @override
  State<SummarizeScreen> createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  final AssessmentController assessmentController =
      Get.put(AssessmentController());
  var baseUrl = dotenv.env['ASSET_URL'];
  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return assessmentController.summarizeList.isEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomCard(
                      backgroundColor: AppTheme.ognMdGreen,
                      title: "ผลคะแนนเฉลี่ยครั้งล่าสุด",
                      subtitle: "93.92% / 100%",
                      icon: FontAwesomeIcons.squarePollVertical,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.city,
                                size: 18,
                                color: AppTheme.ognGreen,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'แบบประเมินพนักงาน ของบริษัท',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.ognGreen,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidStar,
                                size: 16,
                                color: AppTheme.ognOrangeGold,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'คะแนนที่ได้ :',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.ognGreen,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.calendarDays,
                                size: 16,
                                color: AppTheme.ognOrangeGold,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'วันที่ประเมินครั้งล่าสุด :',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.ognGreen,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Get.toNamed('history-assessment');
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: AppTheme.ognMdGreen, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FontAwesomeIcons.clockRotateLeft,
                                  size: 16,
                                  color: AppTheme.ognMdGreen,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "ดูประวัติ",
                                  style: TextStyle(
                                      color: AppTheme.ognMdGreen, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/menu/assessment.png',
                  width: MediaQuery.of(context).size.width *
                      (screenMode ? 0.10 : 0.25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'ไม่มีแบบประเมินในขณะนี้',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
              ],
            );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
