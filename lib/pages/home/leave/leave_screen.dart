import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SegmentedTabControl(
              radius: const Radius.circular(0),
              backgroundColor: Colors.grey.shade500,
              indicatorColor: Color.fromARGB(255, 19, 110, 104),
              tabTextColor: Colors.white,
              selectedTabTextColor: Colors.white,
              squeezeIntensity: 2,
              height: 55,
              tabPadding: const EdgeInsets.symmetric(horizontal: 8),
              textStyle: Theme.of(context).textTheme.bodyLarge,
              tabs: [
                SegmentTab(label: 'แจ้งลา'),
                SegmentTab(label: 'ประวัติการลา'),
              ],
            ),
          ),
          // Sample pages
          Container(
            padding: EdgeInsets.only(top: 55),
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Text('Test1'),
                ),
                Center(
                  child: Text('Test2'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
