import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/request_doc_controller.dart';
import 'package:organics_salary/theme.dart';

class ConfirmSentRequestScreen extends StatefulWidget {
  const ConfirmSentRequestScreen({super.key});

  @override
  State<ConfirmSentRequestScreen> createState() =>
      _ConfirmSentRequestScreenState();
}

class _ConfirmSentRequestScreenState extends State<ConfirmSentRequestScreen> {
  int status = 0;
  final RequestDocController controller = Get.put(RequestDocController());

  String apiMessage = ''; // ✅ เก็บข้อความจาก backend
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String displayMessage;

    if (status == 1) {
      imagePath = 'assets/img/success.png';
      displayMessage = apiMessage.isNotEmpty ? apiMessage : 'บันทึกสำเร็จ!';
    } else if (status == 2) {
      imagePath = 'assets/img/failed.png';
      displayMessage = apiMessage.isNotEmpty ? apiMessage : 'บันทึกล้มเหลว!';
    } else {
      imagePath = 'assets/img/warning.png';
      displayMessage = 'คุณต้องการยืนยันใช่หรือไม่?';
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: status == 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: AppTheme.ognOrangeGold,
                onPressed: () => Get.back(),
              )
            : null,
        title: Text(
          status == 0 ? 'ยืนยันการบันทึกข้อมูล' : '',
          style: const TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    Image.asset(
                      imagePath,
                      width: 120,
                      height: 120,
                    ),
                  const SizedBox(height: 20),
                  Text(
                    displayMessage,
                    style: const TextStyle(
                      color: AppTheme.ognGreen,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                if (status == 0) ...[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(color: AppTheme.ognOrangeGold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ognOrangeGold,
                      ),
                      onPressed: () async {
                        final result = await controller.sendRequest();

                        setState(() {
                          status = result ? 1 : 2;
                          apiMessage =
                              controller.lastMessage; // ✅ ดึงข้อความมาแสดง
                        });
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              'ยืนยัน',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ognOrangeGold,
                      ),
                      onPressed: () {
                        Navigator.pop(context, "go_tab2");
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              'กลับ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
