import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/social_security_controller.dart';
import 'package:organics_salary/theme.dart';

class SocialSecurityPage extends StatefulWidget {
  const SocialSecurityPage({super.key});

  @override
  State<SocialSecurityPage> createState() => _SocialSecurityPageState();
}

class _SocialSecurityPageState extends State<SocialSecurityPage> {
  final SocialSecurityController socialSecurityController =
      Get.put(SocialSecurityController());
  var baseUrl = dotenv.env['ASSET_URL'];
  late bool screenMode;

  @override
  void initState() {
    super.initState();
    socialSecurityController.loadData();
  }

  @override
  void dispose() {
    Get.delete<SocialSecurityController>();
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
          'สิทธิ์ประกันสังคม',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.filePen,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed('request-social-security');
            },
          ),
        ],
      ),
      body: Obx(() {
        return socialSecurityController.socialSecurityList.isNotEmpty
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                    child: Text(
                      'แสดงผล ${socialSecurityController.socialSecurityList.length} รายการ',
                      style: const TextStyle(
                          color: AppTheme.ognGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: socialSecurityController.socialSecurityList
                          .map((item) {
                        DateTime dateTime = DateTime.parse(item['created_at']);
                        final thaiYear = dateTime.year + 543;
                        final thaiMonths = [
                          'มกราคม',
                          'กุมภาพันธ์',
                          'มีนาคม',
                          'เมษายน',
                          'พฤษภาคม',
                          'มิถุนายน',
                          'กรกฎาคม',
                          'สิงหาคม',
                          'กันยายน',
                          'ตุลาคม',
                          'พฤศจิกายน',
                          'ธันวาคม'
                        ];
                        final thaiMonth = thaiMonths[dateTime.month - 1];

                        String formattedDate =
                            '${dateTime.day} $thaiMonth $thaiYear';

                        Color colorStatus = Colors.grey;
                        if (item['status'] == 1) {
                          colorStatus = Colors.grey;
                        } else if (item['status'] == 2) {
                          colorStatus = Colors.amber;
                        } else if (item['status'] == 3) {
                          colorStatus = Colors.orange;
                        } else if (item['status'] == 4) {
                          colorStatus = AppTheme.stepperGreen;
                        } else if (item['status'] == 5) {
                          colorStatus = Colors.red;
                        } else if (item['status'] == 6) {
                          colorStatus = Colors.red;
                        }

                        return Container(
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(5),
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                child: item['sso_doc'] != null &&
                                        item['sso_doc'].isNotEmpty
                                    ? Image.network(
                                        '$baseUrl/${item['sso_doc'][0]['file_path']}',
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            'assets/img/logo.jpg',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        'assets/img/logo.jpg',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item['detail'].toString(),
                                                  style: const TextStyle(
                                                    color: AppTheme.ognGreen,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: Text(
                                                    item['sso_detail']['detail']
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: AppTheme
                                                          .ognOrangeGold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: colorStatus,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(35),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.fiber_manual_record,
                                                  size: 10,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  item['status_follower_data'][
                                                              'curent_status'] !=
                                                          null
                                                      ? (item['status_follower_data']
                                                                  ['curent_status']
                                                              is List
                                                          ? (item['status_follower_data']['curent_status']
                                                                  .isNotEmpty
                                                              ? item['status_follower_data']
                                                                          ['curent_status'][0][
                                                                      'emp_status_app']
                                                                  .toString()
                                                              : 'รายการใหม่')
                                                          : item['status_follower_data']
                                                                      ['curent_status']
                                                                  ['emp_status_app']
                                                              .toString())
                                                      : 'รายการใหม่',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'วันที่ส่งข้อมูล : $formattedDate',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/social_security/social-security.png',
                      width: MediaQuery.of(context).size.width *
                          (screenMode ? 0.10 : 0.25),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ไม่มีประวัติการทำรายการของคุณ',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
