import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/pages/home/dashboard/screen_platform/dashboard_mobile_screen.dart';
import 'package:organics_salary/theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppTheme.ognSoftGreen,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppTheme.ognSoftGreen,
          AppTheme.ognSoftGreen,
          AppTheme.bgSoftGreen,
          AppTheme.bgSoftGreen,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Stack(
        children: [
          ListView(
            // shrinkWrap: true,
            children: const [
              GetMainUI(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

class GetMainUI extends StatefulWidget {
  const GetMainUI({super.key});

  @override
  State<GetMainUI> createState() => _GetMainUIState();
}

class _GetMainUIState extends State<GetMainUI> {
  final box = GetStorage();

  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return const DashboardMobileScreen();
    // return screenMode ? const DashboardMobileScreen() : const DashboardMobileScreen();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
    print('SCREEN : ${MediaQuery.of(context).size.width}');
  }
}
