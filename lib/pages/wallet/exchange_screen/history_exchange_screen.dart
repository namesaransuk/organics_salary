import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/wallet_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryExchangeScreen extends StatefulWidget {
  const HistoryExchangeScreen({super.key});

  @override
  State<HistoryExchangeScreen> createState() => _HistoryExchangeScreenState();
}

class _HistoryExchangeScreenState extends State<HistoryExchangeScreen> {
  final WalletController walletController = Get.put(WalletController());
  final DateRangePickerController _controller = DateRangePickerController();

  late bool screenMode;

  @override
  void initState() {
    final DateTime today = DateTime.now();
    walletController.c_startDate.value = DateFormat('MMMM yyyy')
        .format(today.add(const Duration(days: 0)))
        .replaceFirst(
          '${today.year}',
          '${today.year}',
        )
        .toString();
    walletController.c_endDate.value = DateFormat('MMMM yyyy')
        .format(today.add(const Duration(days: 0)))
        .replaceFirst(
          '${today.year}',
          '${today.year}',
        )
        .toString();

    print(walletController.c_startDate.value);
    print(walletController.c_endDate.value);

    _controller.selectedRange =
        PickerDateRange(today, today.add(const Duration(days: 0)));

    final DateTime firstDayOfMonth = DateTime(today.year, today.month, 1);
    final DateTime lastDayOfMonth = DateTime(today.year, today.month + 1, 0);

    walletController.searchStartDate.value = firstDayOfMonth.toString();
    walletController.searchEndDate.value = lastDayOfMonth.toString();

    walletController.loadHistoryExchange();

    super.initState();
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    DateTime startDate = args.value.startDate;
    DateTime endDate = args.value.endDate ?? args.value.startDate;

    print(startDate);
    print(endDate);

    walletController.c_startDate.value = DateFormat('MMMM yyyy', 'th')
        .format(startDate)
        .replaceFirst(
          '${startDate.year}',
          '${startDate.year}',
        )
        .toString();

    walletController.c_endDate.value = DateFormat('MMMM yyyy', 'th')
        .format(endDate)
        .replaceFirst(
          '${endDate.year}',
          '${endDate.year}',
        )
        .toString();

    if (endDate.isAtSameMomentAs(startDate)) {
      endDate = DateTime(startDate.year, startDate.month + 1, 0);
    }

    walletController.searchStartDate.value = startDate.toString();
    walletController.searchEndDate.value = endDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: AppTheme.ognOrangeGold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'ตั้งแต่ ${walletController.c_startDate.value} - ${walletController.c_endDate.value}',
                          style: const TextStyle(
                            color: AppTheme.ognGreen,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return dateSelected();
                        },
                      );
                    },
                    child: const Icon(
                      Icons.tune_rounded,
                      color: AppTheme.ognOrangeGold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => walletController.historyExchange.isNotEmpty
                ? Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
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
                                Expanded(
                                  flex: 2,
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
                                    'เพิ่ม',
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
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  walletController.historyExchange.map((item) {
                                DateTime parsedDate =
                                    DateTime.parse(item['created_at']);

                                String formattedDate =
                                    "${parsedDate.day.toString().padLeft(2, '0')}/"
                                    "${parsedDate.month.toString().padLeft(2, '0')}/"
                                    "${parsedDate.year}";

                                String formattedTime =
                                    "${parsedDate.hour.toString().padLeft(2, '0')}:"
                                    "${parsedDate.minute.toString().padLeft(2, '0')}";

                                final originType =
                                    item['setupswap']?['origin_type']?['name'];
                                final destinationType = item['setupswap']
                                    ?['hr_currencies']?['name'];

                                // แปลง item_id เป็นชื่อ
                                // final originType = originItemId == 1 ? 'Coin' : (originItemId == 2 ? 'Heart' : '');
                                // final destinationType = destinationItemId == 1 ? 'Coin' : (destinationItemId == 2 ? 'Heart' : '');
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              item['setupswap']
                                                      ?['description'] ??
                                                  '-',
                                              // item['description'] ?? '-',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.ognGreen,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${NumberFormat('#,###.00').format(double.tryParse(item['destination_swap_1']?['amount']) ?? 0)} $originType",
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
                                              "+${NumberFormat('#,###.00').format(double.tryParse(item['destination_swap_2']?['amount']) ?? 0)} $destinationType",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.ognGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
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
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }

  Widget dateSelected() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: const Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 28,
                          color: AppTheme.ognOrangeGold,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'เลือกช่วงเวลา',
                          style: TextStyle(
                              color: AppTheme.ognGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'เดือนเริ่มต้น',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    walletController.c_startDate.value,
                                    style: const TextStyle(
                                      color: AppTheme.ognMdGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Center(
                              child: Text(
                                'ถึง',
                                style: TextStyle(
                                  color: AppTheme.ognMdGreen,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'เดือนสิ้นสุด',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 10),
                                  ),
                                  Text(
                                    walletController.c_endDate.value,
                                    style: const TextStyle(
                                      color: AppTheme.ognMdGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SfDateRangePicker(
                        controller: _controller,
                        backgroundColor: Colors.transparent,
                        startRangeSelectionColor: AppTheme.ognXsmGreen,
                        endRangeSelectionColor: AppTheme.ognXsmGreen,
                        rangeSelectionColor: AppTheme.ogn2XsmGreen,
                        selectionRadius: 12,
                        monthFormat: 'MMMM',
                        view: DateRangePickerView.year,
                        selectionMode: DateRangePickerSelectionMode.range,
                        rangeTextStyle:
                            const TextStyle(color: AppTheme.ognMdGreen),
                        headerStyle: const DateRangePickerHeaderStyle(
                            backgroundColor: Colors.transparent,
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.ognGreen)),
                        onSelectionChanged: (args) {
                          selectionChanged(args);
                          setState(() {}); // ใช้ setState เพื่อ rebuild dialog
                        },
                        allowViewNavigation: false,
                        showNavigationArrow: true,
                        yearCellStyle: const DateRangePickerYearCellStyle(
                          todayTextStyle: TextStyle(color: AppTheme.ognMdGreen),
                          todayCellDecoration:
                              BoxDecoration(color: Colors.white),
                          textStyle: TextStyle(color: AppTheme.ognMdGreen),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: const ButtonStyle(),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text('ยกเลิก'),
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
                            // walletController.loadData();
                            walletController.loadHistoryExchange();
                            Get.back();
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: Text(
                                  'ยืนยัน',
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
