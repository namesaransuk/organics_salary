import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/theme.dart';

class ConfirmRedeemPage extends StatefulWidget {
  const ConfirmRedeemPage({super.key});

  @override
  State<ConfirmRedeemPage> createState() => _ConfirmRedeemPageState();
}

class _ConfirmRedeemPageState extends State<ConfirmRedeemPage> {
  final CoinController coinController = Get.put(CoinController());
  final coin = Get.arguments;
  late bool screenMode;

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
          'ยืนยันแลกของรางวัล',
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/giftbox.png',
                            width: MediaQuery.of(context).size.width *
                                (screenMode ? 0.10 : 0.25),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'คุณต้องการยืนยันการแลกรางวัล',
                            style: TextStyle(
                              color: AppTheme.ognGreen,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            coin['description'].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppTheme.ognOrangeGold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            'ใช่หรือไม่?',
                            style: TextStyle(
                              color: AppTheme.ognGreen,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'ไม่ใช่',
                              style: TextStyle(color: AppTheme.ognOrangeGold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.ognOrangeGold,
                            ),
                            onPressed: () {
                              coinController.sendData(coin);
                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: Text(
                                    'ใช่',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }

  Widget redeemDetail(IconData icon, String prefix, String detail,
      {bool textWeight = false}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppTheme.ognOrangeGold,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '$prefix :',
                    style: const TextStyle(
                      color: AppTheme.ognGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                detail,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppTheme.ognGreen,
                  fontWeight: textWeight ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget redeemCalculate(
    String prefix,
    String detail, {
    bool textWeight = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prefix,
                style: TextStyle(
                  color: color ?? AppTheme.ognGreen,
                  fontWeight: textWeight ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Text(
                detail,
                style: TextStyle(
                  color: color ?? AppTheme.ognGreen,
                  fontWeight: textWeight ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
