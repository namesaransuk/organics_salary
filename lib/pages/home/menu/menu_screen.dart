import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/profile_controller.dart';
import 'package:organics_salary/theme.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.loadFlowLeave();
    super.initState();
  }

  final List<Map<String, dynamic>> itemInformations = [
    {
      'title': 'ข้อมูลส่วนตัว',
      'icon': 'assets/img/menu/user.png',
      'onpress': () => Get.toNamed('profile')
    },
    {
      'title': 'เกียรติประวัติ',
      'icon': 'assets/img/honor/badge.png',
      'onpress': () => Get.toNamed('honor')
    },
    {
      'title': 'สถิติการเข้างาน',
      'icon': 'assets/img/menu/statistics.png',
      'onpress': () => Get.toNamed('time-history')
    },
    {
      'title': 'รถส่วนตัว',
      'icon': 'assets/img/car/car-wash.png',
      'onpress': () => Get.toNamed('car')
    },
    {
      'title': 'เงินเดือน',
      'icon': 'assets/img/menu/salary.png',
      'onpress': () => Get.toNamed('salary')
    },
    {
      'title': 'เอกสารและสัญญา',
      'icon': 'assets/img/document_contract/contract.png',
      'onpress': () => Get.toNamed('document-contract')
    },
    {
      'title': '16 Personality',
      'icon': 'assets/img/menu/personality.png',
      'onpress': () => Get.toNamed('personality')
    },
    {
      'title': 'ประวัติทำรายการ',
      'icon': 'assets/img/transection/file.png',
      'onpress': () => Get.toNamed('transection')
    },
        {
      'title': 'ขอเอกสารรับรอง ',
      'icon': 'assets/img/document.png',
      'onpress': () => Get.toNamed('request_doc')
    },
  ];

  final List<Map<String, dynamic>> itemServices = [
    {
      'title': 'อุปกรณ์',
      'icon': 'assets/img/equipment/maintenance.png',
      'onpress': () => Get.toNamed('equipment')
    },
    {
      'title': 'การลา',
      'icon': 'assets/img/menu/leave.png',
      'onpress': () => Get.toNamed('leave')
    },
    {
      'title': 'ประกันสังคม',
      'icon': 'assets/img/social_security/social-security.png',
      'onpress': () => Get.toNamed('social-security')
    },
    {
      'title': 'แลกของรางวัล',
      'icon': 'assets/img/menu/money.png',
      'onpress': () => Get.toNamed('coin')
    },
    {
      'title': 'Organics Wallet',
      'icon': 'assets/img/menu/wallet.png',
      'onpress': () => Get.toNamed('wallet')
    },
    // {
    //   'title': 'แบบประเมิน',
    //   'icon': 'assets/img/menu/assessment.png',
    //   'onpress': () => Get.toNamed('assessment')
    // },
    // {
    //   'title': 'เงินออม',
    //   'icon': 'assets/img/menu/savings.png',
    //   'onpress': () => Get.toNamed('savings')
    // },
    // {
    //   'title': 'กองทุนสำรองเลี้ยงชีพ',
    //   'icon': 'assets/img/menu/loan-life.png',
    //   'onpress': () => Get.toNamed('provident-fund')
    // },
    // {
    //   'title': 'ประกันกลุ่ม',
    //   'icon': 'assets/img/menu/group-security.png',
    //   'onpress': () => Get.toNamed('group-security')
    // },
  ];

  final List<Map<String, dynamic>> itemMissions = [
    {
      'title': 'แจ้งซ่อมบำรุง',
      'icon': 'assets/img/menu/maintenance.png',
      'onpress': () => Get.toNamed('maintenance')
    },
    {
      'title': 'เสนอความคิดเห็น',
      'icon': 'assets/img/menu/comment.png',
      'onpress': () => Get.toNamed('comment')
    },
  ];

  final List<Map<String, dynamic>> itemSupervisors = [
    {
      'title': 'คำขอลางาน',
      'icon': 'assets/img/menu/part-time.png',
      'onpress': () => Get.toNamed('leave-approve')
    },
  ];

  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppTheme.ognSoftGreen,
          AppTheme.ognSoftGreen,
          AppTheme.bgSoftGreen,
          AppTheme.bgSoftGreen,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          color: AppTheme.bgSoftGreen,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: AppTheme.ognSoftGreen,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
                  // child: Text(
                  //   'เมนู',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: AppTheme.ognGreen,
                  //   ),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'เมนู',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ognGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  // alignment: Alignment.topCenter,
                  children: [
                    CustomPaint(
                      painter: _WavePainter(),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                    ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // MediaQuery.of(context).size.width > 768
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.userTie,
                                      color: AppTheme.ognMdGreen,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ข้อมูลของฉัน',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.ognMdGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: screenMode ? 5 : 3,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount:
                                    itemInformations.length, // จำนวนรายการ
                                itemBuilder: (BuildContext context, int index) {
                                  return AspectRatio(
                                    aspectRatio: 1,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      surfaceTintColor: Colors.white,
                                      color: Colors.white,
                                      child: InkWell(
                                        onTap: itemInformations[index]
                                            ['onpress'],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (screenMode ? 0.06 : 0.1),
                                                child: Image.asset(
                                                    itemInformations[index]
                                                        ['icon']),
                                              ),
                                              SizedBox(
                                                  height: screenMode ? 14 : 10),
                                              Text(
                                                itemInformations[index]
                                                    ['title'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppTheme.ognMdGreen,
                                                    fontSize:
                                                        screenMode ? 14 : 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // MediaQuery.of(context).size.width > 768
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.handHoldingHeart,
                                      color: AppTheme.ognMdGreen,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'สวัสดิการ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.ognMdGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: screenMode ? 5 : 3,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: itemServices.length, // จำนวนรายการ
                                itemBuilder: (BuildContext context, int index) {
                                  return AspectRatio(
                                    aspectRatio: 1,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      surfaceTintColor: Colors.white,
                                      color: Colors.white,
                                      child: InkWell(
                                        onTap: itemServices[index]['onpress'],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (screenMode ? 0.06 : 0.1),
                                                child: Image.asset(
                                                    itemServices[index]
                                                        ['icon']),
                                              ),
                                              SizedBox(
                                                  height: screenMode ? 14 : 10),
                                              Text(
                                                itemServices[index]['title'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppTheme.ognMdGreen,
                                                    fontSize:
                                                        screenMode ? 14 : 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // MediaQuery.of(context).size.width > 768
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidFlag,
                                      color: AppTheme.ognMdGreen,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ภารกิจ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.ognMdGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: screenMode ? 5 : 3,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: itemMissions.length, // จำนวนรายการ
                                itemBuilder: (BuildContext context, int index) {
                                  return AspectRatio(
                                    aspectRatio: 1,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      surfaceTintColor: Colors.white,
                                      color: Colors.white,
                                      child: InkWell(
                                        onTap: itemMissions[index]['onpress'],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (screenMode ? 0.06 : 0.1),
                                                child: Image.asset(
                                                    itemMissions[index]
                                                        ['icon']),
                                              ),
                                              SizedBox(
                                                  height: screenMode ? 14 : 10),
                                              Text(
                                                itemMissions[index]['title'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppTheme.ognMdGreen,
                                                    fontSize:
                                                        screenMode ? 14 : 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          final flowLeave = profileController.flowLeaveList;
                          // return flowLeave['flow_step'] == 2
                          return flowLeave.isNotEmpty &&
                                  (flowLeave.first['emp_id'] != null ||
                                      flowLeave.first['c_positions_id'] !=
                                          null ||
                                      flowLeave.first['c_companies_id'] !=
                                          null ||
                                      flowLeave.first['c_departments_id'] !=
                                          null)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 85),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // MediaQuery.of(context).size.width > 768
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 0, 10),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidIdBadge,
                                              color: AppTheme.ognMdGreen,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'เฉพาะหัวหน้างาน',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.ognMdGreen,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: screenMode ? 5 : 3,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemCount: itemSupervisors
                                            .length, // จำนวนรายการ
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return AspectRatio(
                                            aspectRatio: 1,
                                            child: Card(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                              surfaceTintColor: Colors.white,
                                              color: Colors.white,
                                              child: InkWell(
                                                onTap: itemSupervisors[index]
                                                    ['onpress'],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            (screenMode
                                                                ? 0.06
                                                                : 0.1),
                                                        child: Image.asset(
                                                            itemSupervisors[
                                                                index]['icon']),
                                                      ),
                                                      SizedBox(
                                                          height: screenMode
                                                              ? 14
                                                              : 10),
                                                      Text(
                                                        itemSupervisors[index]
                                                            ['title'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .ognMdGreen,
                                                            fontSize: screenMode
                                                                ? 14
                                                                : 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 100,
                                );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // paint.color = AppTheme.ognSoftGreen;

    final gradient = const LinearGradient(
      colors: [
        AppTheme.ognSoftGreen,
        AppTheme.bgSoftGreen,
      ], // Adjust the colors as needed
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(100, 10, size.width, 300));

    paint.shader = gradient;

    paint.strokeWidth = 20.0;
    paint.style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(0, size.height * .265);
    path.quadraticBezierTo(size.width * .23, size.height * .31,
        size.width * .46, size.height * .27);
    path.quadraticBezierTo(
        size.width * .75, size.height * .22, size.width, size.height * .225);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
