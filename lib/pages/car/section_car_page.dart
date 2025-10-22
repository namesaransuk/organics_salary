import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/car_controller.dart';
import 'package:organics_salary/theme.dart';

class SectionCarPage extends StatefulWidget {
  const SectionCarPage({super.key});

  @override
  State<SectionCarPage> createState() => _SectionCarPageState();
}

class _SectionCarPageState extends State<SectionCarPage> {
  final CarController carController = Get.put(CarController());
  String carCategory = '';

  @override
  Widget build(BuildContext context) {
    // if (carController.filteredCarList.first['car_category_id'] == 1) {
    //   carCategory = 'รถยนต์';
    // } else if (carController.filteredCarList.first['car_category_id'] == 2) {
    //   carCategory = 'รถมอเตอร์ไซค์';
    // }
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
          'รถส่วนตัว',
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
              FontAwesomeIcons.solidPenToSquare,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed('car-edit');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'ข้อมูลรถส่วนตัว',
                      style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        children: [
                          // listCar(Icons.widgets_rounded, 'ประเภท', carCategory),
                          // listCar(Icons.pin_rounded, 'ทะเบียน', '${carController.filteredCarList.first['car_registration']}'),
                          // listCar(FontAwesomeIcons.carTunnel, 'ยี่ห้อ', '${carController.filteredCarList.first['car_brand']}'),
                          // listCar(Icons.palette_rounded, 'สี', '${carController.filteredCarList.first['car_color']}'),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidImage,
                                  size: 18,
                                  color: AppTheme.ognOrangeGold,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'รูปถ่าย',
                                  style: TextStyle(color: AppTheme.ognMdGreen),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // Image.network('${carController.filteredCarList.first['car_image']}')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listCar(IconData icon, String prefix, String detail) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppTheme.ognOrangeGold,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    prefix,
                    style: const TextStyle(color: AppTheme.ognMdGreen),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                detail != '' ? detail : '-',
                textAlign: TextAlign.right,
                style: const TextStyle(color: AppTheme.ognMdGreen),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
