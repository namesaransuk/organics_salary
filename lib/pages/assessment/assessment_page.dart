import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/assessment_controller.dart';
import 'package:organics_salary/pages/assessment/screen/assessment_screen.dart';
import 'package:organics_salary/pages/assessment/screen/summarize_screen.dart';
import 'package:organics_salary/theme.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key}); // ใช้ named constructor ที่มีชื่อ key

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  final AssessmentController assessmentController = Get.put(AssessmentController());

  @override
  void initState() {
    super.initState();
    // assessmentController.loadData();
  }

  @override
  void dispose() {
    Get.delete<AssessmentController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          'แบบประเมิน',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                constraints: const BoxConstraints.expand(height: 55),
                child: TabBar(
                    splashFactory: NoSplash.splashFactory,
                    dividerColor: const Color.fromARGB(255, 250, 250, 250),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade400,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.ognSmGreen,
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.tableList,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "แบบประเมิน",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.squarePollVertical,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "สรุปผล",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
              const Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    AssessmentScreen(),
                    SummarizeScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
