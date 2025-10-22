import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/assessment_controller.dart';
import 'package:organics_salary/theme.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final AssessmentController assessmentController =
      Get.put(AssessmentController());
  var baseUrl = dotenv.env['ASSET_URL'];
  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return assessmentController.assessmentList.isEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXChky4z8ATuOCSiurP6atAYJUEhDmdXWQ7g&s',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'แบบประเมินของบริษัท',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.ognGreen,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'ประเมินล่าสุดเมื่อวันที่ 15/01/2025',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.ognOrangeGold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.ognOrangeGold,
                              ),
                              onPressed: () {
                                Get.toNamed('section-assessment');
                              },
                              child: const SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.play,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'เริ่มทำแบบประเมิน',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
