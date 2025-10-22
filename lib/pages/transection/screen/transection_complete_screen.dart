import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/transection_controller.dart';
import 'package:organics_salary/theme.dart';

class TransectionCompleteScreen extends StatefulWidget {
  const TransectionCompleteScreen({super.key});

  @override
  State<TransectionCompleteScreen> createState() =>
      _TransectionCompleteScreenState();
}

class _TransectionCompleteScreenState extends State<TransectionCompleteScreen> {
  final TransectionController transectionController =
      Get.put(TransectionController());
  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    transectionController.loadDataSuccess();
    return Obx(() {
      return transectionController.transectionSuccessList.isNotEmpty
          ? SizedBox(
              height: MediaQuery.of(context)
                  .size
                  .height, // กำหนดความสูงของ Container
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                    child: Text(
                      'แสดงผล ${transectionController.transectionSuccessList.length} รายการ',
                      style: const TextStyle(
                          color: AppTheme.ognGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: transectionController.transectionSuccessList
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

                        return Container(
                          height: 120,
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
                              // Container(
                              //   width: 100,
                              //   height: 100,
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.only(
                              //       topLeft: Radius.circular(15),
                              //       bottomLeft: Radius.circular(15),
                              //     ),
                              //     child: Image.network(
                              //       'https://media.istockphoto.com/id/1418476287/photo/businessman-analyzing-companys-financial-balance-sheet-working-with-digital-augmented-reality.jpg?s=612x612&w=0&k=20&c=Cgdq4iCELzmCVg19Z69GPt0dgNYbN7zbAARkzNSpyno=',
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
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
                                                  item['note1'].toString(),
                                                  style: const TextStyle(
                                                    color: AppTheme.ognGreen,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  'หัวข้อ : ${item['subject']}',
                                                  style: const TextStyle(
                                                    color: AppTheme.ognMdGreen,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                item['detail'] != null
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 2),
                                                        child: Text(
                                                          'รายละเอียด : ${item['detail']}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 12),
                                            decoration: const BoxDecoration(
                                              color: AppTheme.stepperGreen,
                                              borderRadius: BorderRadius.all(
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
                                                              : 'เสร็จสิ้น')
                                                          : item['status_follower_data']
                                                                      ['curent_status']
                                                                  ['emp_status_app']
                                                              .toString())
                                                      : 'เสร็จสิ้น',
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
                                            color: Colors.grey.shade400),
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
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/transection/file.png',
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
              ],
            );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
