import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organics_salary/pages/wallet/exchange_screen/exchange_coin_screen.dart';
import 'package:organics_salary/pages/wallet/exchange_screen/history_exchange_screen.dart';
import 'package:organics_salary/theme.dart';

class ExchangeCoinPage extends StatefulWidget {
  const ExchangeCoinPage({super.key});

  @override
  State<ExchangeCoinPage> createState() => _ExchangeCoinPageState();
}

class _ExchangeCoinPageState extends State<ExchangeCoinPage> {
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
          'แลกเปลี่ยนเหรียญ',
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
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
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
                                    FaIcon(
                                      FontAwesomeIcons.coins,
                                      // color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "แลกเหรียญ",
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
                                    FaIcon(
                                      Icons.history,
                                      // color: AppTheme.ognOrangeGold,
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
                          ExchangeCoinScreen(),
                          HistoryExchangeScreen(),
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
