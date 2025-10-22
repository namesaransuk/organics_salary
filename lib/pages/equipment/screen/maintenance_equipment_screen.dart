import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/equipment_controller.dart';
import 'package:organics_salary/theme.dart';

class MaintenanceEquipmentScreen extends StatefulWidget {
  const MaintenanceEquipmentScreen({super.key});

  @override
  State<MaintenanceEquipmentScreen> createState() =>
      _MaintenanceEquipmentScreenState();
}

class _MaintenanceEquipmentScreenState
    extends State<MaintenanceEquipmentScreen> {
  final EquipmentController equipmentController =
      Get.put(EquipmentController());
  final baseUrl = dotenv.env['ASSET_URL'];
  late bool screenMode;

  @override
  void initState() {
    super.initState();
    equipmentController.loadDataMaintenance();
  }

  @override
  void dispose() {
    Get.delete<EquipmentController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return equipmentController.equipmentMaintenanceList.isNotEmpty
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'แสดงผล ${equipmentController.equipmentMaintenanceList.length} รายการ',
                          style: const TextStyle(
                              color: AppTheme.ognGreen,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed('history-maintenance-equipment');
                        },
                        child: const Text(
                          'ดูประวัติการซ่อมบำรุง',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppTheme.ognOrangeGold,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.ognOrangeGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: equipmentController.equipmentMaintenanceList
                        .map((item) {
                      return Container(
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            // print(item);
                            // returnDetailSheet(context, item);
                            Get.toNamed('detail-maintenance-return',
                                arguments: item);
                          },
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
                                child: Image.network(
                                  '$baseUrl/${item['item_data']['asset_image']['file_path']}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/img/logo.jpg',
                                      fit: BoxFit.cover,
                                    );
                                  },
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
                                                  item['name'].toString(),
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
                                                    'หมายเลขทะเบียน : ${item['item_data']['hr_code']['code']}',
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'จำนวนที่เคยเบิก : ${double.parse(item['amount_item']).toInt()} ${item['item_data']['unit']['units_name']['singletexts']['name']}',
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
          : Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/equipment/maintenance.png',
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

  void returnDetailSheet(BuildContext context, item) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'กรอกเลขบัตรประชาชน 13 หลักเพื่อเปลี่ยนรหัส PIN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // checkIdCard();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.ognGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'ตรวจสอบ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenMode = MediaQuery.of(context).size.width > 768;
  }
}
