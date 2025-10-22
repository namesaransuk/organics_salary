import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/pages/equipment/screen/maintenance_equipment_screen.dart';
import 'package:organics_salary/pages/equipment/screen/withdraw_equipment_screen.dart';
import 'package:organics_salary/theme.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
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
          'อุปกรณ์',
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
              FontAwesomeIcons.circlePlus,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed('equipment-add');
            },
          ),
        ],
      ),
      body: DefaultTabController(
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
                              FontAwesomeIcons.penRuler,
                              size: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "การเบิกอุปกรณ์",
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
                              FontAwesomeIcons.handHoldingHand,
                              size: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "อุปกรณ์ที่ดูแล",
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
                  WithdrawEquipmentScreen(),
                  MaintenanceEquipmentScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
