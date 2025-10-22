import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/leave_history_controller.dart';
import 'package:organics_salary/pages/leave/screen/leave_history_screen.dart';
import 'package:organics_salary/pages/leave/screen/leave_report_screen.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

final LeaveHistoryController leaveHistoryController =
    Get.put(LeaveHistoryController());

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() {
    return _LeavePageState();
  }
}

class _LeavePageState extends State<LeavePage> with TickerProviderStateMixin {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 1), () {
    //   if (Get.arguments != null) {
    //     final arguments = Get.arguments;
    //     final itemWhere = leaveHistoryController.leaveHistoryList.firstWhere(
    //       (item) => '${item['id']}' == arguments,
    //       orElse: () => null,
    //     );

    //     Get.toNamed(
    //       'leave-section',
    //       arguments: {
    //         'item': itemWhere,
    //       },
    //     );
    //   }
    // });

    super.initState();
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
          'การลา',
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
                              Icon(
                                Icons.recent_actors_outlined,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "ประวัติการลา",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
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
                              Icon(
                                Icons.work_history_outlined,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "การลา",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
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
                    LeaveHistory(),
                    LeaveReport(),
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
