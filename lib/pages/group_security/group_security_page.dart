import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/group_security_controller.dart';
import 'package:organics_salary/theme.dart';

class GroupSecurityPage extends StatelessWidget {
  GroupSecurityPage({super.key});

  final GroupSecurityController groupSecurityController =
      Get.put(GroupSecurityController());
  @override
  Widget build(BuildContext context) {
    groupSecurityController.loadData();
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
          'ประกันกลุ่ม',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Obx(
        () => groupSecurityController.groupSecurityList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: groupSecurityController.groupSecurityList
                      .map(
                        (item) => Expanded(
                          child: ListView(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                'ข้อมูลประกันกลุ่ม',
                                style: TextStyle(
                                  color: AppTheme.ognGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    item.groupInsuranceImg.toString(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/group_security/family.png',
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ไม่มีประกันกลุ่มของคุณในขณะนี้',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
      )),
    );
  }
}
