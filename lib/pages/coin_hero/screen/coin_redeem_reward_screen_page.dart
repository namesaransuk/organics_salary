import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/theme.dart';

class CoinRedeemRewardScreen extends StatefulWidget {
  const CoinRedeemRewardScreen({super.key});

  @override
  State<CoinRedeemRewardScreen> createState() => _CoinRedeemRewardScreenState();
}

class _CoinRedeemRewardScreenState extends State<CoinRedeemRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return const GetMainUI();
  }
}

class GetMainUI extends StatefulWidget {
  const GetMainUI({super.key});

  @override
  State<GetMainUI> createState() => _GetMainUIState();
}

class _GetMainUIState extends State<GetMainUI> with TickerProviderStateMixin {
  late bool screenMode;
  final box = GetStorage();
  final CoinController coinController = Get.put(CoinController());

  @override
  void initState() {
    super.initState();
    coinController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => coinController.coinList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'รายการรางวัล',
                    style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(screenMode ? 8 : 4),
                      itemCount: (coinController.coinList.length /
                              (screenMode ? 3 : 2))
                          .ceil(),
                      itemBuilder: (context, index) {
                        int startIndex = index * (screenMode ? 3 : 2);
                        // int endIndex = (startIndex + (screenMode ? 3 : 2)).clamp(0, coinController.coinList.length);

                        return Row(
                          children:
                              List.generate((screenMode ? 3 : 2), (subIndex) {
                            int itemIndex = startIndex + subIndex;

                            if (itemIndex >= coinController.coinList.length) {
                              // ถ้าไม่มีข้อมูลให้ช่องว่าง
                              return const Expanded(child: SizedBox());
                            }

                            var coin = coinController.coinList[itemIndex];

                            return Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed('detail-redeem', arguments: coin);
                                },
                                child: Card(
                                  margin: EdgeInsets.all(screenMode ? 8 : 4),
                                  clipBehavior: Clip.antiAlias,
                                  surfaceTintColor: Colors.white,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: coin['reward_image'] != null &&
                                                coin['reward_image'] is List &&
                                                coin['reward_image'].isNotEmpty
                                            ? Image.network(
                                                coin['reward_image'][0]
                                                        ['file_path']
                                                    .toString(),
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    'assets/img/logo.jpg',
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                'assets/img/logo.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              coin['description'].toString(),
                                              style: const TextStyle(
                                                color: AppTheme.ognMdGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 14,
                                                    height: 14,
                                                    color:
                                                        AppTheme.stepperYellow,
                                                    child: const FaIcon(
                                                      FontAwesomeIcons.diamond,
                                                      color: Colors.white,
                                                      size: 6,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${NumberFormat('#,###').format(coin['origin_rate'] ?? 0)} ${coin['origin_type']['name']}',
                                                  // '${NumberFormat('#,###').format(coin['cost_price'])} Coin',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        AppTheme.ognOrangeGold,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/menu/charity.png',
                    width: MediaQuery.of(context).size.width *
                        (screenMode ? 0.10 : 0.25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'เปิดให้บริการเร็วๆนี้...',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void alertEmptyData(String title, String detail) {
    Get.dialog(
      AlertDialog(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: AppTheme.ognSmGreen,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Text(
          detail,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.ognSmGreen,
            ),
            child: const Text(
              "ตกลง",
              style: TextStyle(
                color: Colors.white,
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
