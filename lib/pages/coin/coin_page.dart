import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/coin_controller.dart';
import 'package:organics_salary/pages/coin/coin_history_screen.dart';
import 'package:organics_salary/pages/coin/coin_redeem_reward_screen_page.dart';
import 'package:organics_salary/theme.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    CoinRedeemRewardScreen(),
    CoinHistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: Text(
          'Organics Coin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ognGreen,
        foregroundColor: Colors.white,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.redeem),
            label: 'แลกของรางวัล',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ประวัติ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.ognGreen,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment Counter',
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
