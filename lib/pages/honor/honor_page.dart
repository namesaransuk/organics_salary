import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/honor_controller.dart';
import 'package:organics_salary/pages/honor/screen/honor_spacial_screen.dart';
import 'package:organics_salary/pages/honor/screen/honor_standard_screen.dart';
import 'package:organics_salary/theme.dart';

class HonorPage extends StatefulWidget {
  const HonorPage({super.key}); // ใช้ named constructor ที่มีชื่อ key

  @override
  State<HonorPage> createState() => _HonorPageState();
}

class _HonorPageState extends State<HonorPage> {
  final HonorController honorController = Get.put(HonorController());

  @override
  void initState() {
    super.initState();
    honorController.loadData();
  }

  @override
  void dispose() {
    Get.delete<HonorController>();
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
          'เกียรติประวัติ',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.filePen,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed('honor-request');
            },
          ),
        ],
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
                                FontAwesomeIcons.award,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "ตามมาตรฐาน",
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
                                FontAwesomeIcons.crown,
                                size: 18,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "พิเศษ",
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
                    HonorStandardScreen(),
                    HonorSpacialScreen(),
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
