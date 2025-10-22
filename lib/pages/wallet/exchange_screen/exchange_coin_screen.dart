import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/wallet_controller.dart';
import 'package:organics_salary/theme.dart';

class ExchangeCoinScreen extends StatefulWidget {
  const ExchangeCoinScreen({super.key});

  @override
  State<ExchangeCoinScreen> createState() => _ExchangeCoinScreenState();
}

class _ExchangeCoinScreenState extends State<ExchangeCoinScreen> {
  late bool screenMode;
  final WalletController walletController = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    walletController.loadCurrenciesExchange();
  }

  @override
  void dispose() {
    Get.delete<WalletController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "โปรโมชั่น",
            style: TextStyle(
              color: AppTheme.ognGreen,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: walletController.currenciesList.isNotEmpty
                    ? AppTheme.ognGreen.withOpacity(0.1)
                    : AppTheme.ognOrangeGold.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: walletController.currenciesList.isNotEmpty
                        ? AppTheme.ognGreen.withOpacity(0.2)
                        : AppTheme.ognOrangeGold,
                    width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  walletController.currenciesList.isNotEmpty
                      ? Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  "แลกเปลี่ยน ",
                                  style: TextStyle(
                                    color: AppTheme.ognGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " Heart ➔ Coin",
                                  style: TextStyle(
                                    color: AppTheme.ognOrangeGold,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Obx(() {
                              final selectedItem = walletController
                                  .currenciesList
                                  .where((convert) =>
                                      convert['exchange_type'] == 1)
                                  .toList();
                              return Column(
                                children:
                                    selectedItem.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  var item = entry.value;

                                  return exchangeList(
                                    (index + 1).toString(),
                                    item['origin_rate'].toString(),
                                    item['destination_rate'].toString(),
                                    () => Get.toNamed('detail-exchange',
                                        arguments: item),
                                  );
                                }).toList(),
                              );
                            }),
                          ],
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Text(
                              "ไม่มีโปรโมชั่นแลกเปลี่ยนในขณะนี้",
                              style: TextStyle(
                                color: AppTheme.ognOrangeGold,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.toNamed('calculate-exchange');
              },
              icon: const Icon(
                Icons.swap_horiz,
                color: Colors.white,
              ),
              label: const Text(
                "อัตราการแลกเปลี่ยนอื่นๆ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ognGreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget exchangeList(
      String list, String heart, String coin, VoidCallback onpress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "ระดับที่ $list : ใช้ $heart heart แลก ",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.ognGreen,
                ),
              ),
              Text(
                "$coin coin",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.ognGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onpress,
            child: const Text(
              "แลกทันที",
              style: TextStyle(
                color: AppTheme.ognGreen,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.ognGreen,
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
}
