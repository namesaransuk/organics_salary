import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:intl/intl.dart';

class CoinHistoryScreen extends StatefulWidget {
  const CoinHistoryScreen({super.key});

  @override
  State<CoinHistoryScreen> createState() => _CoinHistoryScreenState();
}

class _CoinHistoryScreenState extends State<CoinHistoryScreen> {
  late bool screenMode;
  final CoinController coinController = Get.put(CoinController());

  @override
  void initState() {
    super.initState();
    coinController.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    var baseUrl = dotenv.env['ASSET_URL'];
    return Obx(
      () => coinController.coinHistory.isNotEmpty
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    children: List.generate(coinController.coinHistory.length,
                        (index) {
                      var item = coinController.coinHistory[index];

                      DateTime dateTime = DateTime.parse(item['created_at']);
                      final thaiYear = dateTime.year + 543;
                      final thaiMonths = [
                        'มกราคม',
                        'กุมภาพันธ์',
                        'มีนาคม',
                        'เมษายน',
                        'พฤษภาคม',
                        'มิถุนายน',
                        'กรกฎาคม',
                        'สิงหาคม',
                        'กันยายน',
                        'ตุลาคม',
                        'พฤศจิกายน',
                        'ธันวาคม'
                      ];
                      final thaiMonth = thaiMonths[dateTime.month - 1];

                      String formattedDate =
                          '${dateTime.day} $thaiMonth $thaiYear';

                      Color colorStatus = Colors.grey;
                      if (item['reward_status']?['status'] == 1) {
                        colorStatus = Colors.grey;
                      } else if (item['reward_status']?['status'] == 2) {
                        colorStatus = Colors.amber;
                      } else if (item['reward_status']?['status'] == 3) {
                        colorStatus = Colors.orange;
                      } else if (item['reward_status']?['status'] == 4) {
                        colorStatus = AppTheme.stepperGreen;
                      } else if (item['reward_status']?['status'] == 5) {
                        colorStatus = Colors.red;
                      } else if (item['reward_status']?['status'] == 6) {
                        colorStatus = Colors.red;
                      }

                      return Container(
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: item['reward_image'] != null &&
                                      item['reward_image'].isNotEmpty &&
                                      item['reward_image'][0]['file_path'] !=
                                          null
                                  ? Image.network(
                                      '$baseUrl/${item['reward_image'][0]['file_path']}',
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                            'assets/img/logo.jpg',
                                            fit: BoxFit.cover);
                                      },
                                    )
                                  : Image.asset('assets/img/logo.jpg'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${item['hr_setup_swaps']?['description']}',
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  color: AppTheme.ognGreen,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  ClipOval(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 14,
                                                      height: 14,
                                                      color: AppTheme
                                                          .stepperYellow,
                                                      child: const FaIcon(
                                                        FontAwesomeIcons
                                                            .diamond,
                                                        color: Colors.white,
                                                        size: 6,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${NumberFormat('#,###').format((item['hr_setup_swaps']['origin_rate'] ?? 0))} ${item['hr_setup_swaps']['origin_type']['name']}',
                                                    style: const TextStyle(
                                                      color: AppTheme
                                                          .ognOrangeGold,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: colorStatus,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.fiber_manual_record,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                item['reward_status']
                                                                ?['status_follower_data']
                                                            ?['curent_status']
                                                        is List
                                                    ? (item['reward_status']['status_follower_data']['curent_status']
                                                            .isNotEmpty
                                                        ? item['reward_status']['status_follower_data']
                                                                    ['curent_status'][0][
                                                                'emp_status_app']
                                                            .toString()
                                                        : 'รายการใหม่')
                                                    : item['reward_status']?['status_follower_data']
                                                                    ?['curent_status']
                                                                ?['emp_status_app']
                                                            ?.toString() ??
                                                        'รายการใหม่',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'วันที่ส่งคำขอ : $formattedDate',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
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
                    // 'เปิดให้บริการเร็วๆนี้...',
                    'ไม่มีประวัติการแลกในขณะนี้',
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
