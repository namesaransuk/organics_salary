import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:organics_salary/pages/salary/screen/slip_view_screen.dart';
import 'package:organics_salary/theme.dart';
// import 'package:stepper_a/stepper_a.dart';

final SalaryController salaryController = Get.put(SalaryController());
String reason = '';
int selectedIndex = 2;

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SalaryPageState();
  }
}

class _SalaryPageState extends State<SalaryPage> with TickerProviderStateMixin {
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
          'เงินเดือน',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SlipView(),
        // child: DefaultTabController(
        //   length: 2,
        //   child: Column(
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
        //         constraints: const BoxConstraints.expand(height: 55),
        //         child: TabBar(
        //             splashFactory: NoSplash.splashFactory,
        //             dividerColor: const Color.fromARGB(255, 250, 250, 250),
        //             labelColor: Colors.white,
        //             unselectedLabelColor: Colors.grey.shade400,
        //             indicatorSize: TabBarIndicatorSize.label,
        //             indicator: BoxDecoration(
        //               borderRadius: BorderRadius.circular(15),
        //               color: AppTheme.ognSmGreen,
        //             ),
        //             tabs: [
        //               Tab(
        //                 child: Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(15),
        //                   ),
        //                   child: const Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       FaIcon(
        //                         FontAwesomeIcons.coins,
        //                         size: 18,
        //                       ),
        //                       SizedBox(
        //                         width: 7,
        //                       ),
        //                       Text(
        //                         "เงินเดือน",
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, fontSize: 13),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Tab(
        //                 child: Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(15),
        //                   ),
        //                   child: const Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Icon(
        //                         Icons.receipt_rounded,
        //                         size: 18,
        //                       ),
        //                       SizedBox(
        //                         width: 7,
        //                       ),
        //                       Text(
        //                         "ขอสลิป",
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold, fontSize: 13),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ]),
        //       ),
        //       const Expanded(
        //         child: TabBarView(
        //           physics: BouncingScrollPhysics(),
        //           children: [
        //             SlipView(),
        //             SlipRequest(),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
