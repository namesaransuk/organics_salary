import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/controllers/wallet_controller.dart';
import 'package:organics_salary/pages/wallet/custom_card.dart';
import 'package:organics_salary/theme.dart';

class OrganicsWalletPage extends StatefulWidget {
  const OrganicsWalletPage({super.key});

  @override
  State<OrganicsWalletPage> createState() => _OrganicsWalletPageState();
}

class _OrganicsWalletPageState extends State<OrganicsWalletPage> {
  final WalletController walletController = Get.put(WalletController());
  late bool screenMode;

  @override
  void initState() {
    super.initState();
    walletController.loadCurrencies();
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
          'Organics Wallet',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return CustomCard(
                  backgroundColor: AppTheme.ognMdGreen,
                  title: "Organics Coin",
                  subtitle:
                      "${walletController.empCoin.value.isNotEmpty && double.tryParse(walletController.empCoin.value) != null ? (double.parse(walletController.empCoin.value) == 0 ? '0' : NumberFormat('#,##0.00').format(double.parse(walletController.empCoin.value))) : '0'} Coin",
                  icon: FontAwesomeIcons.coins,
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                return CustomCard(
                  backgroundColor: AppTheme.ognOrangeGold,
                  title: "Organics Heart",
                  subtitle:
                      "${walletController.empHeart.value.isNotEmpty && double.tryParse(walletController.empHeart.value) != null ? (double.parse(walletController.empHeart.value) == 0 ? '0' : NumberFormat('#,##0.00').format(double.parse(walletController.empHeart.value))) : '0'} Heart",
                  icon: Icons.favorite,
                );
              }),
              const SizedBox(height: 28),
              const Text(
                'เมนูเพิ่มเติม',
                style: TextStyle(
                  color: AppTheme.ognGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CardList(
                Icons.history,
                'ประวัติการเพิ่ม - ลด',
                () => Get.toNamed('history-coin-hero'),
              ),
              CardList(
                Icons.swap_horiz_outlined,
                'แลกเปลี่ยนเหรียญ',
                () => Get.toNamed('exchange-coin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardList(IconData icon, String text, VoidCallback? onPress) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppTheme.ognOrangeGold,
                size: 34,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: AppTheme.ognGreen,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppTheme.ognOrangeGold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
