import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/personality_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PersonalityPage extends StatefulWidget {
  const PersonalityPage({super.key});

  @override
  State<PersonalityPage> createState() => _PersonalityPageState();
}

class _PersonalityPageState extends State<PersonalityPage> {
  final PersonalityController personalityController =
      Get.put(PersonalityController());

  var baseUrl = dotenv.env['ASSET_URL'] ?? "";
  final box = GetStorage();

  final Map<String, Color> personalityColors = {
    'personal-purple': Color(0xFF7C588D), // สีม่วง
    'personal-green': Color(0xFF31996B), // สีเขียว
    'personal-cyan': Color(0xFF3C8EA9), // น้ำเงิน
    'personal-yellow': Color(0xFFE0A33F), // สีเหลือง
  };

  late bool screenMode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }

  @override
  void initState() {
    super.initState();
    personalityController.loadData();
    screenMode = false; // หรือกำหนดตาม logic เริ่มต้นของคุณ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          '16 Personality',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          final char = personalityController.character;
          final msg = personalityController.message.value;

          if (char.isEmpty) {
            if (msg.isNotEmpty) {
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 🔹 ส่วนกลาง
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/img/characterwarning.png',
                                  width: MediaQuery.of(context).size.width *
                                      (screenMode ? 0.10 : 0.25),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  msg,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.ognOrangeGold,
                            ),
                            onPressed: () {
                              _open(char['link'] ??
                                  "https://www.16personalities.com/th/แบบทดสอบบุคคลิกภาพ");
                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: Text(
                                    'ไปที่เว็ปไซต์เพื่อทำแบบทดสอบบุคคลิกภาพ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            // ถ้าไม่มี character และยังไม่มีข้อความ → แสดงกำลังโหลด
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header
                      Container(
                        decoration: BoxDecoration(
                          color: personalityColors[char['color_tag']] ??
                              Colors.grey,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ข้อความฝั่งซ้าย
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("บุคลิกภาพของคุณคือ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  const SizedBox(height: 8),
                                  Text(
                                    char['discription'] ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    char['variant'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    char['tagline'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // รูป
                            SizedBox(
                              width: 120,
                              child: Center(
                                child: Image.network(
                                  "$baseUrl${char['personality_img']}",
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // เนื้อหา
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              char['overview'] ?? '',
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              char['str_weak'] ?? '',
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              child: Image.network(
                                "$baseUrl${char['illustration_img']}",
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.5,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image,
                                      size: 80, color: Colors.grey);
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator
                                          .ballPulseRise, // ลองเปลี่ยนเป็น ballBeat, ballPulse ฯลฯ
                                      colors: [AppTheme.ogn2XsmGreen],
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              char['relationship'] ?? '',
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              char['workplace'] ?? '',
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              char['summary'] ?? '',
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ปุ่ม
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.ognOrangeGold,
                  ),
                  onPressed: () {
                    _open(char['link'] ?? "https://www.16personalities.com/");
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Text('ไปที่เว็ปไซต์เพื่ออ่าน',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  _open(String url) async {
    if (!await launchUrl(
      Uri.parse(url.replaceAll('"', "")),
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
