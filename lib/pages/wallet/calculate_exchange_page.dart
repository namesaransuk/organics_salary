import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/wallet_controller.dart';
import 'package:organics_salary/theme.dart';

class CalculateExchangePage extends StatefulWidget {
  const CalculateExchangePage({super.key});

  @override
  State<CalculateExchangePage> createState() => _CalculateExchangePageState();
}

class _CalculateExchangePageState extends State<CalculateExchangePage> {
  final WalletController walletController = Get.put(WalletController());

  @override
  void initState() {
    super.initState();
    walletController.loadCurrencies();
    walletController.loadConvertCurrencies();
    walletController.loadCurrenciesExchange();
  }

  @override
  void dispose() {
    Get.delete<WalletController>();
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
          'แลกเหรียญ',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "กรุณาเลือกเหรียญ",
                      style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => DropdownButtonFormField(
                        validator: (value) {
                          if (value == 'เลือกหน่วย' ||
                              value == null ||
                              value.isEmpty) {
                            return 'เลือกหน่วย';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: Colors.white,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 25),
                          labelText: 'กรอกรายละเอียด',
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          hintStyle: const TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        hint: Text(
                          'เลือกหน่วย',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 14),
                          ),
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'เลือกหน่วย',
                            enabled: false,
                            child: Text(
                              'เลือกหน่วย',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 14),
                              ),
                            ),
                          ),
                          for (final convert
                              in walletController.currenciesOriginList)
                            DropdownMenuItem<String>(
                              value: '${convert['id']}',
                              child: Text(
                                '${convert['details']['name']}',
                                style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                      color: AppTheme.ognMdGreen, fontSize: 14),
                                ),
                              ),
                            ),
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            walletController.firstConvert.value = value;

                            final selectedItem = walletController
                                .currenciesOriginList
                                .firstWhere(
                              (convert) => '${convert['id']}' == value,
                              orElse: () => null,
                            );

                            if (selectedItem != null) {
                              walletController.originUnit.value =
                                  '${selectedItem['details']['name']}';
                            }
                          }
                        },
                        value: walletController.firstConvert.value,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey[400],
                          ),
                        ),
                        iconEnabledColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        dropdownColor: Colors.white,
                        // underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        walletController.exchangeAmount.value = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรอกจำนวน';
                        }
                        return null;
                      },
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: AppTheme.ognMdGreen, fontSize: 14),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 25),
                        labelText: 'กรอกจำนวน',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          FontAwesomeIcons.caretDown,
                          color: AppTheme.ognOrangeGold,
                          size: 36,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => DropdownButtonFormField(
                        validator: (value) {
                          if (value == 'เลือกหน่วย' ||
                              value == null ||
                              value.isEmpty) {
                            return 'เลือกหน่วย';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: Colors.white,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 25),
                          labelText: 'กรอกรายละเอียด',
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          hintStyle: const TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        hint: Text(
                          'เลือกหน่วย',
                          style: GoogleFonts.kanit(
                            textStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 14),
                          ),
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'เลือกหน่วย',
                            enabled: false,
                            child: Text(
                              'เลือกหน่วย',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 14),
                              ),
                            ),
                          ),
                          for (final convert
                              in walletController.currenciesDestinationList)
                            DropdownMenuItem<String>(
                              value: '${convert['id']}',
                              child: Text(
                                '${convert['details']['name']}',
                                style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                      color: AppTheme.ognMdGreen, fontSize: 14),
                                ),
                              ),
                            ),
                        ],
                        onChanged: (String? value) {
                          if (value != null) {
                            walletController.secondConvert.value = value;

                            final selectedItem = walletController
                                .currenciesDestinationList
                                .firstWhere(
                              (convert) => '${convert['id']}' == value,
                              orElse: () => null,
                            );

                            if (selectedItem != null) {
                              walletController.destinationUnit.value =
                                  '${selectedItem['details']['name']}';
                            }
                          }
                        },
                        value: walletController.secondConvert.value,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey[400],
                          ),
                        ),
                        iconEnabledColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        dropdownColor: Colors.white,
                        // underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      String formattedValue = "0";
                      final selectedItem = walletController.currenciesList
                          .firstWhere(
                              (convert) => convert['exchange_type'] == 2,
                              orElse: () => null);

                      if (walletController.exchangeAmount.value.isNotEmpty) {
                        double? amount = double.tryParse(
                            walletController.exchangeAmount.value);
                        if (amount != null) {
                          formattedValue =
                              (amount / selectedItem['origin_rate'])
                                  .toStringAsFixed(2)
                                  .replaceAll(RegExp(r"\.00$"), "");
                        }
                      }

                      return walletController.originUnit.value.isNotEmpty &&
                              walletController
                                  .destinationUnit.value.isNotEmpty &&
                              walletController.exchangeAmount.value.isNotEmpty
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.ognGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppTheme.ognGreen.withOpacity(0.2),
                                    width: 2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${selectedItem['origin_rate']} ${walletController.originUnit.value} = ${selectedItem['destination_rate']} ${walletController.destinationUnit.value}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    '= ${NumberFormat('#,###.00').format(double.parse(formattedValue))} ${walletController.destinationUnit.value}',
                                    style: const TextStyle(
                                      color: AppTheme.ognGreen,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    }),
                    const Spacer(),
                    Obx(() {
                      String formattedValue = "0";
                      final selectedItem = walletController.currenciesList
                          .firstWhere(
                              (convert) => convert['exchange_type'] == 2,
                              orElse: () => null);

                      if (walletController.exchangeAmount.value.isNotEmpty) {
                        double? amount = double.tryParse(
                            walletController.exchangeAmount.value);
                        if (amount != null) {
                          formattedValue =
                              (amount / selectedItem['origin_rate'])
                                  .toStringAsFixed(2)
                                  .replaceAll(RegExp(r"\.00$"), "");
                        }
                      }
                      return walletController.originUnit.value.isNotEmpty &&
                              walletController
                                  .destinationUnit.value.isNotEmpty &&
                              walletController.exchangeAmount.value.isNotEmpty
                          ? Container(
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
                                  exchangeCalculate(
                                      'Organics Heart ของคุณทั้งหมดที่มี',
                                      '${walletController.empHeart.value.isNotEmpty && double.tryParse(walletController.empHeart.value) != null ? (double.parse(walletController.empHeart.value) == 0 ? '0' : NumberFormat('#,##0.00').format(double.parse(walletController.empHeart.value))) : '0'} heart'),
                                  exchangeCalculate(
                                      'Organics Heart ที่ใช้แลกครั้งนี้',
                                      '-${walletController.exchangeAmount.value.isNotEmpty && int.tryParse(walletController.exchangeAmount.value) != null ? (int.parse(walletController.exchangeAmount.value) == 0 ? '0' : NumberFormat('#,###.00').format(int.parse(walletController.exchangeAmount.value))) : '0'} heart',
                                      color: const Color.fromARGB(
                                          255, 245, 112, 88),
                                      textWeight: true),
                                  exchangeCalculate(
                                    'Organics Heart คงเหลือ',
                                    '${(((double.tryParse(walletController.empHeart.value)?.toInt() ?? 0) - (double.tryParse(walletController.exchangeAmount.value) ?? 0)) == 0) ? '0' : NumberFormat('#,###.00').format(((double.tryParse(walletController.empHeart.value)?.toInt() ?? 0) - (double.tryParse(walletController.exchangeAmount.value) ?? 0)))} heart',
                                  ),
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
                                    'Organics Coin ที่ได้รับเพิ่ม',
                                    '${double.tryParse(formattedValue) == null || double.parse(formattedValue) == 0 ? '0' : '+${NumberFormat('#,##0.00').format(double.parse(formattedValue))}'} coin',
                                    textWeight: true,
                                  ),
                                  exchangeCalculate(
                                    'Organics Coin คงเหลือ',
                                    '${((double.tryParse(walletController.empCoin.value) ?? 0) + ((double.tryParse(walletController.exchangeAmount.value) ?? 0) / (selectedItem['origin_rate'] ?? 1))) == 0 ? '0' : NumberFormat('#,###.00').format((double.tryParse(walletController.empCoin.value) ?? 0) + ((double.tryParse(walletController.exchangeAmount.value) ?? 0) / (selectedItem['origin_rate'] ?? 1)))} coin',
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              height: 150,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.ognGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppTheme.ognGreen.withOpacity(0.2),
                                    width: 2),
                              ),
                              child: const Center(
                                child: Text(
                                  'เลือกหน่วยและจำนวนเพื่อคำนวน',
                                  style: TextStyle(
                                      color: AppTheme.ognGreen,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () {
                        double exchangeAmount = double.tryParse(
                                walletController.exchangeAmount.value) ??
                            0;
                        double empHeart =
                            double.tryParse(walletController.empHeart.value) ??
                                0;

                        print("Exchange Amount: $exchangeAmount");
                        print("Emp Heart: $empHeart");

                        return exchangeAmount <= empHeart
                            ? Container()
                            : Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.red, width: 1),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.warning_rounded,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Organics Heart ของคุณคงเหลือไม่เพียงพอ',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () {
                        double exchangeAmount = double.tryParse(
                                walletController.exchangeAmount.value) ??
                            0;
                        double empHeart =
                            double.tryParse(walletController.empHeart.value) ??
                                0;

                        print("Exchange Amount: $exchangeAmount");
                        print("Emp Heart: $empHeart");

                        final selectedItem = walletController.currenciesList
                            .firstWhere(
                                (convert) => convert['exchange_type'] == 2,
                                orElse: () => null);
                        print(selectedItem);

                        var item = {
                          'id': selectedItem?['id'],
                          'origin_rate': exchangeAmount,
                          'origin_item_id': selectedItem?['origin_item_id'],
                          'destination_rate': exchangeAmount /
                              (selectedItem?['origin_rate'] ?? 0),
                          'destination_item_id':
                              selectedItem?['destination_item_id'],
                        };

                        return exchangeAmount <= empHeart
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (walletController
                                        .exchangeAmount.isNotEmpty) {
                                      Get.toNamed('confirm-exchange',
                                          arguments: item);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: walletController
                                            .exchangeAmount.isNotEmpty
                                        ? AppTheme.ognOrangeGold
                                        : Colors.grey,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
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
                                    // Get.toNamed('confirm-exchange', arguments: 2);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
}
