import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/news_controller.dart';
import 'package:organics_salary/controllers/profile_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:tab_container/tab_container.dart';

class DashboardMobileScreen extends StatefulWidget {
  const DashboardMobileScreen({super.key});

  @override
  State<DashboardMobileScreen> createState() => _DashboardMobileScreenState();
}

class _DashboardMobileScreenState extends State<DashboardMobileScreen>
    with SingleTickerProviderStateMixin {
  final box = GetStorage();
  late bool screenMode;
  final ProfileController profileController = Get.put(ProfileController());
  final NewsController newsController = Get.put(NewsController());

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {}); // รีเฟรช UI เมื่อเปลี่ยนแท็บ
      }
    });
  }

  final cs.CarouselSliderController _controller = cs.CarouselSliderController();
  final baseUrl = dotenv.env['ASSET_URL'];

  @override
  Widget build(BuildContext context) {
    profileController.loadQuota();
    profileController.loadFlowLeave();
    return Container(
      color: AppTheme.bgSoftGreen,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.ognSoftGreen,
                  Color.fromARGB(255, 198, 240, 236),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ClipOval(child: Builder(
                    builder: (context) {
                      final imageUrl = '$baseUrl/${box.read('profileImage')}';
                      final imageSize = MediaQuery.of(context).size.width *
                          (screenMode ? 0.15 : 0.35);

                      return Image.network(
                        imageUrl,
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // แสดงรูปจาก asset + Gesture เมื่อเกิด error
                          return Image.asset(
                            'assets/img/user.png',
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover,
                          );
                        },
                        // ถ้าโหลดสำเร็จ → ใช้ loading widget ชั่วคราว แล้ว wrap ด้วย GestureDetector
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Scaffold(
                                      backgroundColor: Colors.black,
                                      floatingActionButtonLocation:
                                          FloatingActionButtonLocation
                                              .centerDocked,
                                      floatingActionButton: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  FloatingActionButton(
                                                    heroTag: 'fab1',
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black,
                                                    child: const Icon(
                                                        Icons.arrow_back),
                                                    shape:
                                                        const CircleBorder(), // วงกลม
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    'กลับ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  FloatingActionButton(
                                                    heroTag: 'fab2',
                                                    onPressed: () async {
                                                      profileController
                                                          .downloadAndSaveImage(
                                                              context,
                                                              '$baseUrl/${box.read('profileImage')}',
                                                              '${box.read('profileImage')}');
                                                    },
                                                    backgroundColor:
                                                        AppTheme.ognOrangeGold,
                                                    foregroundColor:
                                                        Colors.white,
                                                    child: const Icon(
                                                        Icons.save_alt),
                                                    shape:
                                                        const CircleBorder(), // วงกลม
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    'บันทึกรูปภาพ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      body: Center(
                                        child: PhotoView(
                                          imageProvider: NetworkImage(imageUrl),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: child,
                            );
                          } else {
                            return SizedBox(
                              width: imageSize,
                              height: imageSize,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          }
                        },
                      );
                    },
                  )),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${box.read('fnames')} ${box.read('lnames')}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.ognGreen,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'รหัสพนักงาน : ${box.read('employeeCode')}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppTheme.ognGreen,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            const VerticalDivider(
                              thickness: 1.5,
                              width: 20,
                              color: AppTheme.ognOrangeGold,
                            ),
                            Flexible(
                              child: Text(
                                '${box.read('department')}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppTheme.ognGreen,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 198, 240, 236),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.ognSmGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 400,
                      child: TabContainer(
                        controller: _tabController,
                        tabEdge: TabEdge.top,
                        tabExtent: 45.0,
                        // tabsStart: 0.1,
                        // tabsEnd: 0.9,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        tabBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        childPadding: const EdgeInsets.all(15.0),
                        selectedTextStyle: const TextStyle(
                          color: AppTheme.ognGreen,
                          fontSize: 13.0,
                        ),
                        unselectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                        // color: AppTheme.ognSoftGreen,
                        color: Colors.white,
                        tabs: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.briefcase,
                                size: 16,
                                color: _tabController.index == 0
                                    ? AppTheme.ognOrangeGold
                                    : Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'สถิติการมาทำงาน',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.businessTime,
                                size: 16,
                                color: _tabController.index == 1
                                    ? AppTheme.ognOrangeGold
                                    : Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'สถิติการลางาน',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                        children: [
                          profileController.empWorkList.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'สถิติการมาทำงาน ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.ognGreen),
                                        ),
                                        Text(
                                          getCurrentMonthYearThai(1),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.ognOrangeGold),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: SfCircularChart(
                                        margin: EdgeInsets.zero,
                                        legend: Legend(
                                            isVisible: true,
                                            position: LegendPosition.right),
                                        series: <CircularSeries>[
                                          DoughnutSeries<ChartData, String>(
                                            dataSource: [
                                              ChartData(
                                                  'วันที่เข้าทำงาน',
                                                  18,
                                                  AppTheme.ognMdGreen
                                                      .withOpacity(0.85)),
                                              ChartData(
                                                  'วันที่ลาทั้งหมด',
                                                  2,
                                                  const Color.fromARGB(
                                                      255, 244, 126, 106)),
                                            ],
                                            pointColorMapper:
                                                (ChartData data, _) =>
                                                    data.color,
                                            xValueMapper: (ChartData data, _) =>
                                                data.label,
                                            yValueMapper: (ChartData data, _) =>
                                                data.value,
                                            dataLabelMapper:
                                                (ChartData data, _) {
                                              double total = 18 + 2;
                                              double percent =
                                                  (data.value / total) * 100;
                                              return '${percent.toStringAsFixed(1)}%';
                                            },
                                            // dataLabelSettings: const DataLabelSettings(
                                            //   isVisible: true,
                                            //   labelPosition: ChartDataLabelPosition.outside, // แสดง label นอกวงกลม
                                            //   textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                            // ),
                                            dataLabelSettings:
                                                DataLabelSettings(
                                              isVisible: true,
                                              overflowMode: OverflowMode.hide,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            radius: '80%',
                                            innerRadius: '55%',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        leaveColumn(
                                            'วัน', 'วันทำงานทั้งหมด', '300',
                                            fontSizeValue: 20),
                                        leaveColumn('วัน', 'วันที่ลาทั้งหมด',
                                            '10 วัน 0 ชม. 0 นาที',
                                            fontSizeValue: 18),
                                      ],
                                    )
                                  ],
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.briefcase,
                                        size: 60,
                                        color: AppTheme.ognOrangeGold,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'ไม่มีสถิติการมาทำงานในขณะนี้',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.ognGreen),
                                      ),
                                    ],
                                  ),
                                ),
                          profileController.leaveQuotaList.isNotEmpty &&
                                  profileController.workTimeList.isNotEmpty
                              ? Obx(() {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'สถิติการลางาน ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.ognGreen),
                                          ),
                                          Text(
                                            getCurrentMonthYearThai(2),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.ognOrangeGold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        color: AppTheme.ognSmGreen
                                            .withOpacity(0.3),
                                        height: 30,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'ใช้ไปแล้ว',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppTheme.ognGreen,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'คงเหลือ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppTheme.ognGreen,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: profileController
                                                .leaveQuotaList
                                                .map((item) {
                                              // var remainingLeave =
                                              //     calculateRemainingLeave(item);

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 4),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .solidCalendar,
                                                            color: AppTheme
                                                                .ognGreen,
                                                            size: 14,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                            child: Text(
                                                              '${item['holiday_name_type']}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: AppTheme
                                                                      .ognGreen),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${item['leaveUsed']?['days']} วัน ${item['leaveUsed']?['hours']} ชม. ${item['leaveUsed']?['minutes']} นาที',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: AppTheme
                                                                .ognOrangeGold),
                                                      ),
                                                      // child: Text('${item.limit ?? 0} วัน'),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${item['remaining']?['days']} วัน ${item['remaining']?['hours']} ชม. ${item['remaining']?['minutes']} นาที',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: AppTheme
                                                                .ognGreen),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                              : SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.businessTime,
                                        size: 60,
                                        color: AppTheme.ognOrangeGold,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'ไม่มีสถิติการลางานในขณะนี้',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.ognGreen),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     itemDashboard(
                    //       'แจ้งลา',
                    //       Icons.work_history_outlined,
                    //       () => Get.toNamed('/leave'),
                    //     ),
                    //     itemDashboard(
                    //       'OGN Coin',
                    //       FontAwesomeIcons.coins,
                    //       () => Get.toNamed('/coin'),
                    //     ),
                    //     itemDashboard(
                    //       'เงินเดือน',
                    //       Icons.receipt_long,
                    //       () => Get.toNamed('/salary'),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Row(
                  children: [
                    Icon(
                      Icons.campaign_rounded,
                      size: 20,
                      color: AppTheme.ognOrangeGold,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'ข่าวสาร',
                      style: TextStyle(color: AppTheme.ognGreen),
                    ),
                  ],
                ),
              ),
              newsController.newsList.isNotEmpty
                  ? Obx(
                      () => Column(
                        children: [
                          Container(
                            child: cs.CarouselSlider(
                              carouselController: _controller,
                              options: cs.CarouselOptions(
                                  aspectRatio: 3,
                                  viewportFraction: 0.8,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 8),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  onPageChanged: (index, reason) {
                                    newsController.current.value = index;
                                  }),
                              items: newsController.newsList.map((item) {
                                return Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: InkWell(
                                    onTap: () {
                                      newsController.loadSectionData(item.id);
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: item.newsImg1 != null &&
                                                  item.newsImg1 != '' &&
                                                  item.newsImg1 != 'null'
                                              ? Image.network(
                                                  '${item.newsImg1}',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/img/logo.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${item.announcementTopic}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppTheme.ognMdGreen,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${item.announcementContent}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.grey[500]),
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis, // new
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        // Icon(
                                                        //   Icons.remove_red_eye_rounded,
                                                        //   size: 16,
                                                        //   color: Colors.grey[400],
                                                        // ),
                                                        // SizedBox(
                                                        //   width: 3,
                                                        // ),
                                                        // Text(
                                                        //   '69',
                                                        //   style: TextStyle(
                                                        //     color: Colors.grey[400],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: const Text(
                                                        'ดูเพิ่มเติม',
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13,
                                                            color: AppTheme
                                                                .ognMdGreen),
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
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: newsController.newsList
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppTheme.ognOrangeGold)
                                        .withOpacity(
                                            newsController.current == entry.key
                                                ? 0.9
                                                : 0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 150,
                      child: const Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.newspaper,
                                size: 40,
                                color: AppTheme.ognOrangeGold,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'ไม่มีข่าวสารในขณะนี้',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.ognGreen),
                              ),
                              Text(
                                'รอติดตามการอัพเดตข่าวสารเพิ่มเติมจากทาง HR',
                                style: TextStyle(color: AppTheme.ognGreen),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Map<String, dynamic> calculateRemainingLeave(Map<String, dynamic> typeData) {
    var detailLeave = profileController.workTimeList.first;

    DateTime currentDate = DateTime.now();
    String currentDateFormatted = DateFormat('yyyy-MM-dd').format(currentDate);

    DateTime setStartData = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['am_worktime_start']}");
    DateTime setEndData = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['pm_worktime_end']}");

    DateTime amEnd = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['am_worktime_end']}");
    DateTime pmStart = DateTime.parse(
        "$currentDateFormatted ${detailLeave['flexible_hours_log_line']['pm_worktime_start']}");

    Duration intervalBreak = pmStart.difference(amEnd);
    int hoursBreak = intervalBreak.inHours;
    int minutesBreak = intervalBreak.inMinutes % 60;

    Duration getDateTimeSetup = setEndData.difference(setStartData);
    int hoursSetup = getDateTimeSetup.inHours;
    int minutesSetup = getDateTimeSetup.inMinutes % 60;

    if ((hoursBreak > 0 || minutesBreak > 0)) {
      hoursSetup -= hoursBreak;
      minutesSetup -= minutesBreak;
    }
    print('Setup Minutes: $minutesSetup');

    int totalUsedDays = typeData['total_used_days'];
    int totalUsedHours = typeData['total_used_hours'];
    int totalUsedMinutes = typeData['total_used_minutes'];

    int additionalHoursFromMinutes = totalUsedMinutes ~/ 60;
    int remainingMinutes = totalUsedMinutes % 60;

    totalUsedHours += additionalHoursFromMinutes;

    int additionalDaysFromHours = totalUsedHours ~/ hoursSetup;
    int remainingHours = totalUsedHours % hoursSetup;

    totalUsedDays += additionalDaysFromHours;

    int balanceDays = int.parse(typeData['amount']) - totalUsedDays;
    int balanceHours = 0 - remainingHours;
    int balanceMinutes = 0 - remainingMinutes;

    if (balanceMinutes < 0) {
      balanceMinutes += 60;
      balanceHours -= 1;
    }

    if (balanceHours < 0) {
      balanceHours += hoursSetup;
      balanceDays -= 1;
    }

    return {
      'Leaveused': {
        'days': totalUsedDays,
        'hours': remainingHours,
        'minutes': remainingMinutes,
        'hoursSetup': hoursSetup,
      },
      'LeaveBalance': {
        'days': balanceDays,
        'hours': balanceHours,
        'minutes': balanceMinutes,
      }
    };
  }

  String getCurrentMonthYearThai(mode) {
    DateTime now = DateTime.now();
    String month = DateFormat.MMMM('th').format(now);
    int buddhistYear = now.year + 543;
    String monthYear = '';

    if (mode == 1) {
      monthYear = 'เดือน$month $buddhistYear';
    } else {
      monthYear = 'ปี $buddhistYear';
    }

    return monthYear;
  }

  Widget itemDashboard(String title, IconData icon, VoidCallback? onPress) {
    return Expanded(
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppTheme.ognSmGreen,
                  size: 45,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.ognMdGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leaveColumn(String quota, String title, String value,
      {double fontSizeValue = 16}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.ognGreen,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              ' ($quota)',
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            color: AppTheme.ognOrangeGold,
            // fontWeight: FontWeight.bold,
            fontSize: fontSizeValue,
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
    print('SCREEN : ${MediaQuery.of(context).size.width}');
  }
}

class ChartData {
  final String label;
  final int value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}
