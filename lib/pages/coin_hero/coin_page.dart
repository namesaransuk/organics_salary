import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/pages/coin_hero/screen/coin_history_screen.dart';
import 'package:organics_salary/pages/coin_hero/screen/coin_redeem_reward_screen_page.dart';
import 'package:organics_salary/theme.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  final CoinController coinController = Get.put(CoinController());

  @override
  void initState() {
    super.initState();
    coinController.loadCurrencies();
  }

  @override
  void dispose() {
    Get.delete<CoinController>();
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
          'แลกของรางวัล',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  child: CircleAvatar(
                                    backgroundColor: AppTheme.stepperYellow,
                                    child: FaIcon(
                                      FontAwesomeIcons.diamond,
                                      color: Colors.white,
                                      size: 8,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Obx(() {
                                  return Text(
                                    'My Coin : ${coinController.empCoin.value.isNotEmpty && double.tryParse(coinController.empCoin.value) != null ? (double.parse(coinController.empCoin.value) == 0 ? '0' : NumberFormat('#,##0.00').format(double.parse(coinController.empCoin.value))) : '0'}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: AppTheme.ognGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 20,
                                  child: FaIcon(
                                    Icons.favorite_rounded,
                                    color: AppTheme.ognOrangeGold,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Obx(
                                  () => Text(
                                    'My Heart : ${coinController.empHeart.value.isNotEmpty && double.tryParse(coinController.empHeart.value) != null ? (double.parse(coinController.empHeart.value) == 0 ? '0' : NumberFormat('#,##0.00').format(double.parse(coinController.empHeart.value))) : '0'}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: AppTheme.ognGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      constraints: const BoxConstraints.expand(height: 55),
                      child: TabBar(
                          splashFactory: NoSplash.splashFactory,
                          dividerColor:
                              const Color.fromARGB(255, 250, 250, 250),
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
                                      Icons.redeem_rounded,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "แลกรางวัล",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
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
                                      Icons.my_library_books_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "ประวัติการแลก",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
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
                          CoinRedeemRewardScreen(),
                          CoinHistoryScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
