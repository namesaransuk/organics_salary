import 'package:flutter/material.dart';
import 'package:organics_salary/pages/time_history/time_history_month_screen.dart';
import 'package:organics_salary/pages/time_history/time_history_year_screen.dart';
import 'package:organics_salary/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

String reason = '';
int selectedIndex = 2;

class TimeHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimeHistoryPageState();
  }
}

class _TimeHistoryPageState extends State<TimeHistoryPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TimeHistoryMonthScreen(),
    TimeHistoryYearScreen(),
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
          'ประวัติการลงเวลา',
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
            icon: Icon(Icons.calendar_view_day_outlined),
            label: 'ประวัติรายเดือน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_month_outlined),
            label: 'ประวัติรายปี',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.ognGreen,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment Counter',
      //   child: const Icon(Icons.qr_code_scanner_rounded),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
      selectedIndex = index;
    });
  }
}
