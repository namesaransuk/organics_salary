import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/theme.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool switchEmail = true;
  bool switchPush = true;

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
          'การแจ้งเตือน',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ตั้งค่าการแจ้งเตือน',
              style: TextStyle(
                color: AppTheme.ognGreen,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: <Widget>[
                // Row(
                //   children: [
                //     Icon(
                //       Icons.email_rounded,
                //       color: AppTheme.ognOrangeGold,
                //       size: 20,
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //       child: Text(
                //         'การแจ้งเตือนอีเมล',
                //         style: TextStyle(color: AppTheme.ognMdGreen),
                //       ),
                //     ),
                //     Expanded(
                //       child: Align(
                //         alignment: Alignment.centerRight,
                //         child: Transform.scale(
                //           scale: 0.7,
                //           child: Switch(
                //             value: switchEmail,
                //             inactiveTrackColor: Colors.grey[400],
                //             onChanged: (bool value) {
                //               setState(() {
                //                 switchEmail = value;
                //               });
                //             },
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    const Icon(
                      Icons.mark_chat_unread_rounded,
                      color: AppTheme.ognOrangeGold,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        'การแจ้งเตือนแบบพุช',
                        style: TextStyle(color: AppTheme.ognMdGreen),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: switchPush,
                            inactiveTrackColor: Colors.grey[400],
                            onChanged: (bool value) {
                              setState(() {
                                switchPush = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ognOrangeGold,
              ),
              // onPressed: submit,
              onPressed: () {
                Get.back();
              },
              child: const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      'บันทึก',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
