import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/honor_controller.dart';
import 'package:organics_salary/theme.dart';

class HonorStandardScreen extends StatefulWidget {
  const HonorStandardScreen({super.key});

  @override
  State<HonorStandardScreen> createState() => _HonorStandardScreenState();
}

class _HonorStandardScreenState extends State<HonorStandardScreen> {
  final HonorController honorController = Get.put(HonorController());
  var baseUrl = dotenv.env['ASSET_URL'];
  late bool screenMode;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return honorController.honorStandardList.isNotEmpty
          ? ListView(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Text(
                      'เกียรติประวัติ (ตามมาตรฐาน)',
                      style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: honorController.honorStandardList
                        .map((item) => Column(
                              children: [
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.personChalkboard,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${item.fileDetail}',
                                        style: const TextStyle(
                                            color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: Image.network(
                                    '$baseUrl/${item.filePath}',
                                    width:
                                        MediaQuery.of(context).size.height * 1,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return Image.asset(
                                          'assets/img/logo-error-thumbnail.jpeg');
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/honor/badge.png',
                  width: MediaQuery.of(context).size.width *
                      (screenMode ? 0.10 : 0.25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'ไม่มีข้อมูลเกียรติประวัติของคุณ',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
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
