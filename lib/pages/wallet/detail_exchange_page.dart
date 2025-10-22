import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/wallet_controller.dart';
import 'package:organics_salary/theme.dart';

class DetailExchangePage extends StatefulWidget {
  const DetailExchangePage({super.key});

  @override
  State<DetailExchangePage> createState() => _DetailExchangePageState();
}

class _DetailExchangePageState extends State<DetailExchangePage> {
  final WalletController walletController = Get.put(WalletController());
  final item = Get.arguments;

  @override
  void initState() {
    super.initState();
    walletController.loadCurrencies();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<WalletController>();
  }

  @override
  Widget build(BuildContext context) {
    final heartDetail = item?['origin_rate'] ?? '0';
    final coinDetail = item?['destination_rate'] ?? '0';
    walletController.exchangeAmount.value = heartDetail.toString();
    final isGesture = isGestureNavigation(context);

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
          'รายละเอียดโปรโมชั่น',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            exchangeDetail(FontAwesomeIcons.solidNoteSticky, 'ชื่อโปรโมชั่น',
                '${item['description']}'),
            exchangeDetail(FontAwesomeIcons.solidCircleStop,
                'จำนวน Organics Coin ที่ได้รับ', '$coinDetail coin'),
            exchangeDetail(FontAwesomeIcons.solidCircleStop,
                'จำนวน Organics Heart ที่ใช้แลก', '$heartDetail heart',
                textWeight: true),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.ognGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppTheme.ognGreen.withOpacity(0.2), width: 2),
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    exchangeCalculate('Organics Heart ของคุณทั้งหมดที่มี',
                        '${walletController.empHeart.value.isNotEmpty && double.tryParse(walletController.empHeart.value) != null ? NumberFormat('#,###').format(double.tryParse(walletController.empHeart.value)) : '0'} heart'),
                    exchangeCalculate('Organics Heart ที่ใช้แลกครั้งนี้',
                        '-$heartDetail heart',
                        color: const Color.fromARGB(255, 245, 112, 88),
                        textWeight: true),
                    exchangeCalculate('Organics Heart คงเหลือ',
                        '${NumberFormat('#,###.00').format((double.tryParse(walletController.empHeart.value) ?? 0) - (heartDetail ?? 0))} heart'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(
                        height: 1,
                        thickness: 0.5,
                        color: AppTheme.ognGreen,
                      ),
                    ),
                    exchangeCalculate(
                      'Organics Coin ของคุณทั้งหมดที่มี',
                      '${walletController.empCoin.value.isNotEmpty && double.tryParse(walletController.empCoin.value) != null ? (double.parse(walletController.empCoin.value) == 0 ? '0' : NumberFormat('#,###.00').format(double.parse(walletController.empCoin.value))) : '0'} coin',
                    ),
                    exchangeCalculate(
                      'Organics Coin ที่ใช้แลกครั้งนี้',
                      '+$coinDetail coin',
                      textWeight: true,
                    ),
                    exchangeCalculate('Organics Coin คงเหลือ',
                        '${NumberFormat('#,###.00').format((double.tryParse(walletController.empCoin.value) ?? 0) + (coinDetail ?? 0))} coin'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
              () {
                double exchangeAmount =
                    double.tryParse(walletController.exchangeAmount.value) ?? 0;
                double empHeart =
                    double.tryParse(walletController.empHeart.value) ?? 0;

                print("Exchange Amount: $exchangeAmount");
                print("Emp Heart: $empHeart");

                return exchangeAmount <= empHeart
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('confirm-exchange', arguments: item);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.ognOrangeGold,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "แลกเปลี่ยน",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Get.toNamed('confirm-exchange', arguments: 1);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "จำนวน Heart ไม่เพียงพอ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
              },
            ),
            SizedBox(
              height: isGesture ? 12 : 35,
            ),
          ],
        ),
      ),
    );
  }

  Widget exchangeDetail(IconData icon, String prefix, String detail,
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
            Text(
              detail,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppTheme.ognGreen,
                fontWeight: textWeight ? FontWeight.bold : FontWeight.normal,
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

  Widget exchangeCalculate(
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

  bool isGestureNavigation(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).viewPadding.bottom;
    return paddingBottom == 0;
  }
}
