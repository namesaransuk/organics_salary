import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/comment_controller.dart';
import 'package:organics_salary/theme.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentController commentController = Get.put(CommentController());
  late bool screenMode;

  @override
  void initState() {
    super.initState();
    commentController.loadData();
  }

  @override
  void dispose() {
    Get.delete<CommentController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var baseUrl = dotenv.env['ASSET_URL'];
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
          'เสนอความคิดเห็น',
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
              Get.toNamed('report-comment');
            },
          ),
        ],
      ),
      body: Obx(() {
        return commentController.commentList.isNotEmpty
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                    child: Text(
                      'แสดงผล ${commentController.commentList.length} รายการ',
                      style: const TextStyle(
                          color: AppTheme.ognGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: commentController.commentList.map((item) {
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
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                // child: Image.network(
                                //    '$baseUrl/${item['transaction_requests_file'][0]['file_path']}' : 'https://newhr.organicscosme.com/uploads/images/setting/reportRepair/logo.jpg',
                                //   fit: BoxFit.cover,
                                // ),
                                child:
                                    item['transaction_requests_file'] != null &&
                                            item['transaction_requests_file']
                                                .isNotEmpty &&
                                            item['transaction_requests_file'][0]
                                                    ['file_path'] !=
                                                null
                                        ? Image.network(
                                            '$baseUrl/${item['transaction_requests_file'][0]['file_path']}',
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              return Image.asset(
                                                  'assets/img/logo.jpg',
                                                  fit: BoxFit.cover);
                                            },
                                          )
                                        : Image.asset('assets/img/logo.jpg'),
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
                                                  item['subject'].toString(),
                                                  style: const TextStyle(
                                                    color: AppTheme.ognGreen,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: Text(
                                                    item['detail'].toString(),
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
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
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/menu/comment.png',
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
