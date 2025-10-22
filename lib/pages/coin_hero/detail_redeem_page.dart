import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/theme.dart';

class DetailRedeemPage extends StatefulWidget {
  const DetailRedeemPage({super.key});

  @override
  State<DetailRedeemPage> createState() => _DetailRedeemPageState();
}

class _DetailRedeemPageState extends State<DetailRedeemPage> {
  final CoinController coinController = Get.put(CoinController());
  final coin = Get.arguments;

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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: coin['reward_image'] != null &&
                              coin['reward_image'] is List &&
                              coin['reward_image'].isNotEmpty
                          ? Image.network(
                              coin['reward_image'][0]['file_path'].toString(),
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/img/logo-error-thumbnail.jpeg',
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/img/logo-error-thumbnail.jpeg',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    redeemDetail(FontAwesomeIcons.solidNoteSticky,
                        'หัวข้อรางวัล', coin['description'].toString()),
                    redeemDetail(
                        FontAwesomeIcons.gift,
                        'รางวัล',
                        coin['description'] != null
                            ? coin['description'].toString()
                            : '-'),
                    redeemDetail(FontAwesomeIcons.gift, 'จำนวนรางวัล',
                        '${coin['destination_rate']} ${coin['reward']['unit']['units_name']['singletexts']['name']}'),
                    redeemDetail(
                        FontAwesomeIcons.solidCircleStop,
                        'จำนวน Coin ที่ใช้แลก',
                        '${NumberFormat('#,###').format(coin['origin_rate'] ?? 0)} ${coin['origin_type']['name']}',
                        textWeight: true),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.ognGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppTheme.ognGreen.withOpacity(0.2),
                            width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          redeemCalculate(
                            'Organics Coin ของคุณทั้งหมดที่มี',
                            '${coinController.empCoin.value.isNotEmpty && double.tryParse(coinController.empCoin.value) != null ? (double.parse(coinController.empCoin.value) == 0 ? '0' : NumberFormat('#,##0.00').format(double.parse(coinController.empCoin.value))) : '0'} Coin',
                          ),
                          redeemCalculate('Organics Coin ที่ใช้แลกครั้งนี้',
                              '${NumberFormat('#,###').format(coin['origin_rate'] ?? 0)} ${coin['origin_type']['name']}',
                              textWeight: true, color: AppTheme.ognOrangeGold),
                          redeemCalculate(
                            'Organics Coin คงเหลือ',
                            '${((double.tryParse(coinController.empCoin.value) ?? 0) - (coin['origin_rate'] ?? 0)) == 0 ? '0' : NumberFormat('#,###.00').format((double.tryParse(coinController.empCoin.value) ?? 0) - (coin['origin_rate'] ?? 0))} Coin',
                            // '${NumberFormat('#,###.00').format((double.tryParse(coinController.empCoin.value) ?? 0) - (coin['origin_rate'] ?? 0))} Coin',
                            color: (double.tryParse(
                                            coinController.empCoin.value) ??
                                        0) >=
                                    (coin['origin_rate'] ?? 0)
                                ? AppTheme.ognMdGreen
                                : Colors.red,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            (double.tryParse(coinController.empCoin.value) ??
                                        0) >=
                                    coin['origin_rate']
                                ? Get.toNamed('confirm-redeem', arguments: coin)
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              (double.tryParse(coinController.empCoin.value) ??
                                          0) >=
                                      coin['origin_rate']
                                  ? AppTheme.ognOrangeGold
                                  : Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          (double.tryParse(coinController.empCoin.value) ??
                                      0) >=
                                  coin['origin_rate']
                              ? "แลกเปลี่ยน"
                              : "จำนวน Coin ไม่เพียงพอ",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
