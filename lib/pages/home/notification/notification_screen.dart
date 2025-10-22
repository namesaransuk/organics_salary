import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/loading_controller.dart';
import 'package:organics_salary/controllers/notification_controller.dart';
import 'package:organics_salary/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController =
      Get.put(NotificationController());
  final LoadingController loadingController = Get.put(LoadingController());
  late bool screenMode;

  final GlobalKey _itemKey = GlobalKey();
  bool _readyToMeasure = false;
  bool _loadingRealData = false;

  @override
  void initState() {
    super.initState();
    // notificationController.loaddata();
    notificationController.limit = 1;
    notificationController.loaddata().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox? box =
            _itemKey.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          final itemHeight = box.size.height;
          final screenHeight = MediaQuery.of(context).size.height;
          final usableHeight =
              screenHeight - kToolbarHeight - (screenMode ? 0 : 50);
          final visibleItemCount = (usableHeight / itemHeight).floor();

          print('Item สูง: $itemHeight');
          print('โหลดได้ $visibleItemCount รายการพอดีกับหน้าจอ');

          notificationController.limit = visibleItemCount;
          _loadingRealData = true;
          notificationController.loaddata().then((_) {
            setState(() {
              _readyToMeasure = true;
            });
          });
        }
      });
    });
  }

  // @override
  // void dispose() {
  //   Get.delete<NotificationController>();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgSoftGreen,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 30, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'แจ้งเตือน',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ognGreen,
                        ),
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'แสดงเฉพาะที่ยังไม่ได้อ่าน',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Obx(
                            () => Transform.scale(
                              alignment: Alignment.centerLeft,
                              scale: 0.8,
                              child: Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value:
                                    notificationController.showUnreadOnly.value,
                                onChanged: (val) {
                                  notificationController.showUnreadOnly.value =
                                      val!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    return await notificationController.loaddata();
                  },
                  child: Obx(() {
                    final filteredList =
                        notificationController.showUnreadOnly.value
                            ? notificationController.notificationList
                                .where((item) => item['read_status'] == 0)
                                .toList()
                            : notificationController.notificationList;

                    return filteredList.isNotEmpty
                        ? ListView(
                            children: [
                              Column(
                                children: [
                                  Column(
                                    children: filteredList
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      final item = entry.value;

                                      DateTime createdAt = DateTime.parse(
                                          item['created_at'].toString());
                                      DateTime currentTime = DateTime.now();
                                      Duration difference =
                                          currentTime.difference(createdAt);
                                      int minutesDifference =
                                          difference.inMinutes.abs();
                                      String timeFormatted;
                                      IconData iconTitle;

                                      if (minutesDifference > (60 * 24)) {
                                        int daysDifference =
                                            difference.inDays.abs();
                                        timeFormatted =
                                            '$daysDifference วันที่แล้ว';
                                      } else if (minutesDifference > 60) {
                                        int hoursDifference =
                                            difference.inHours.abs();
                                        timeFormatted =
                                            '$hoursDifference ชั่วโมงที่แล้ว';
                                      } else if (minutesDifference > 1) {
                                        timeFormatted =
                                            '$minutesDifference นาทีที่แล้ว';
                                      } else {
                                        timeFormatted = 'เมื่อสักครู่';
                                      }

                                      switch (item['icon']?['actions_name']) {
                                        case 'แจ้งเตือนการลาหยุด':
                                          iconTitle =
                                              FontAwesomeIcons.exclamation;
                                          break;
                                        case 'คำขอลางานของคุณไม่ได้รับการอนุมัติ':
                                          iconTitle = FontAwesomeIcons.xmark;
                                          break;
                                        case 'คำขอลางานของคุณได้รับการอนุมัติแล้ว':
                                          iconTitle = FontAwesomeIcons
                                              .personCircleCheck;
                                          break;
                                        default:
                                          iconTitle =
                                              FontAwesomeIcons.paperPlane;
                                      }

                                      final childWidget = Container(
                                        key: index == 0 ? _itemKey : null,
                                        color: item['read_status'] == 0
                                            ? AppTheme.ogn2XsmGreen
                                            : null,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: ListTile(
                                            // onTap: () async {
                                            //   if (item['read_status'] == 0) {
                                            //     await notificationController
                                            //         .readUpdate(item['id']);

                                            //     notificationController
                                            //         .loaddata();
                                            //   }

                                            //   // Get.toNamed(
                                            //   //   item['route'],
                                            //   //   arguments:
                                            //   //       item['module_id'] != null
                                            //   //           ? item['module_id']
                                            //   //           : null,
                                            //   // );
                                            //   Get.toNamed(
                                            //     item['route'],
                                            //     arguments: {
                                            //       'treId': item[
                                            //           'module_id'],
                                            //     },
                                            //   );
                                            // },
                                            
                                            onTap: () async {
                                              print('this is item :$item');
                                              final route = item['route'];
                                              // final moduleId =
                                              //     item['module_id'];
                                              final id = item['id'];

                                              if (item['read_status'] == 0) {
                                                // 1) อัปเดตในหน่วยความจำทันที (optimistic update)
                                                item['read_status'] = 1;

                                                // ถ้า list เป็น RxList ให้ refresh:
                                                notificationController
                                                    .notificationList
                                                    .refresh();
                                                // ถ้าใช้ GetBuilder ให้เรียก controller.update();

                                                // 2) ยิง API อัปเดตสถานะ (จะ await หรือไม่ก็ได้)
                                                await notificationController
                                                    .readUpdate(id);
                                              }

                                              // 3) นำทาง พร้อมส่ง treId
                                              await Get.toNamed(
                                                route,
                                                arguments: item['module_id'],
                                              );

                                              // 4) (แนะนำ) รีโหลดเมื่อ "กลับ" มาหน้านี้ เพื่อ sync กับเซิร์ฟเวอร์
                                              await notificationController
                                                  .loaddata();
                                            },
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  AppTheme.ognMdGreen,
                                              child: Icon(
                                                iconTitle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Wrap(
                                              children: [
                                                Text(
                                                  item['title'].toString(),
                                                  style: const TextStyle(
                                                      color: AppTheme.ognGreen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${item['detail']}'
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    letterSpacing: 0.0,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              timeFormatted,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.fiber_manual_record,
                                              color: item['read_status'] == 0
                                                  ? AppTheme.ognOrangeGold
                                                  : Colors.transparent,
                                              size: 10,
                                            ),
                                          ),
                                        ),
                                      );

                                      if (!_readyToMeasure && index == 0) {
                                        return Opacity(
                                          opacity: 0.0,
                                          child: childWidget,
                                        );
                                      }

                                      return childWidget;
                                    }).toList(),
                                  ),
                                  Obx(
                                    () => filteredList.length >=
                                                notificationController.limit &&
                                            notificationController.limit != 1
                                        ? Column(
                                            children: [
                                              if (notificationController
                                                  .isMoreLoading.value)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              !notificationController
                                                          .isMoreLoading
                                                          .value &&
                                                      !notificationController
                                                          .isLastPage.value &&
                                                      !notificationController
                                                          .showUnreadOnly.value
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 8,
                                                        bottom: screenMode
                                                            ? 10
                                                            : Platform.isAndroid
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.22
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.16,
                                                      ),
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                            AppTheme
                                                                .ognOrangeGold,
                                                          ),
                                                          foregroundColor:
                                                              WidgetStatePropertyAll(
                                                            Colors.white,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          notificationController
                                                              .loaddata(
                                                                  isLoadMore:
                                                                      true);
                                                        },
                                                        child: Text(
                                                            'โหลดเพิ่มเติม'),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: screenMode
                                                            ? 10
                                                            : Platform.isAndroid
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.22
                                                                : MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.16,
                                                      ),
                                                    ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/notification/notification.png',
                                width: MediaQuery.of(context).size.width *
                                    (screenMode ? 0.10 : 0.25),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'ไม่มีการแจ้งเตือนในขณะนี้',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 80,
                              )
                            ],
                          );
                  }),
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
