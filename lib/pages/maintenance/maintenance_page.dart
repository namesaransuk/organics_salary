import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/maintenance_controller.dart';
import 'package:organics_salary/theme.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  final MaintenanceController maintenanceController =
      Get.put(MaintenanceController());
  final baseUrl = dotenv.env['ASSET_URL'];
  late bool screenMode;

  @override
  void initState() {
    super.initState();
    maintenanceController.loadData();
  }

  @override
  void dispose() {
    Get.delete<MaintenanceController>();
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
          'แจ้งซ่อมบำรุง',
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
              Get.toNamed('report-maintenance');
            },
          ),
        ],
      ),
      body: Obx(
        () => maintenanceController.maintenanceList.isNotEmpty
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                    child: Text(
                      'แสดงผล ${maintenanceController.maintenanceList.length} รายการ',
                      style: const TextStyle(
                          color: AppTheme.ognGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children:
                          maintenanceController.maintenanceList.map((item) {
                        DateTime dateTime =
                            DateTime.parse(item['created_at'].toString());
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

                        String? image;
                        String? typeHeader;
                        String? subHeader;

                        switch (item['note2']) {
                          case 'location':
                            image = null;
                            typeHeader = 'สถานที่';
                            subHeader =
                                '${item['location_detail']['place_name']} (${item['location_detail']['building_location']['location_name']})';
                            break;
                          case 'asset':
                            image = item['supply_detail']?['asset_image']
                                        ?['file_path'] !=
                                    null
                                ? '$baseUrl/${item['supply_detail']['asset_image']['file_path']}'
                                : null;
                            typeHeader = 'สินทรัพย์';
                            subHeader = '${item['supply_detail']['name']}';
                            break;
                          case 'other':
                            image = null;
                            typeHeader = 'อื่น ๆ';
                            subHeader = '${item['note1']}';
                            break;
                          default:
                        }

                        return Container(
                          height: 130,
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed('detail-maintenance',
                                  arguments: item);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 130,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: image != null
                                      ? Image.network(
                                          image,
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
                                                  Wrap(
                                                    children: [
                                                      Text(
                                                        '[$typeHeader]',
                                                        style: const TextStyle(
                                                          color: AppTheme
                                                              .ognOrangeGold,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        subHeader.toString(),
                                                        style: const TextStyle(
                                                          color:
                                                              AppTheme.ognGreen,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Text(
                                                      // item['detail'].toString(),
                                                      'รายละเอียด : ${item['detail']}',
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal: 12),
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
                                                                            ['curent_status'][0]
                                                                        [
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'วันที่แจ้งซ่อม : $formattedDate',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade400),
                                        ),
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
                      'assets/img/menu/maintenance.png',
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
