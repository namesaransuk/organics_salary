import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/wallet_controller.dart';
import 'package:organics_salary/theme.dart';

class HeartQuantityScreen extends StatefulWidget {
  const HeartQuantityScreen({super.key});

  @override
  State<HeartQuantityScreen> createState() => _HeartQuantityScreenState();
}

class _HeartQuantityScreenState extends State<HeartQuantityScreen> {
  final WalletController walletController = Get.put(WalletController());

  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => walletController.historyHeartExchange.isNotEmpty
              ? Expanded(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'วัน เดือน ปี',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'เวลา',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'เพิ่ม',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'ลด',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'รายการ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: walletController.historyHeartExchange
                                .map((item) {
                              DateTime parsedDate =
                                  DateTime.parse(item['created_at']);

                              String formattedDate =
                                  "${parsedDate.day.toString().padLeft(2, '0')}/"
                                  "${parsedDate.month.toString().padLeft(2, '0')}/"
                                  "${parsedDate.year}";

                              String formattedTime =
                                  "${parsedDate.hour.toString().padLeft(2, '0')}:"
                                  "${parsedDate.minute.toString().padLeft(2, '0')}";
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            formattedDate,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.ognGreen,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            formattedTime,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.ognGreen,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            item['amount'].startsWith('-')
                                                ? '-'
                                                : '+${NumberFormat('#,##0.00').format(double.parse(item['amount']))}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.ognGreen,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            item['amount'].startsWith('-')
                                                ? NumberFormat('#,##0.00')
                                                    .format(double.parse(
                                                        item['amount']))
                                                : '-',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.ognOrangeGold,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            // item['origin_swap']['description'],
                                            item['action_name'] ?? '-',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.ognGreen,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 0,
                                    thickness: 0.5,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/menu/wallet.png',
                        width: MediaQuery.of(context).size.width *
                            (screenMode ? 0.10 : 0.25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'ไม่มีข้อมูลของเดือนที่เลือก',
                        style: TextStyle(
                          color: Colors.grey[400],
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
