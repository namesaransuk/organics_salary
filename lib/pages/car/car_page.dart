import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/car_controller.dart';
import 'package:organics_salary/theme.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final CarController carController = Get.put(CarController());
  late bool screenMode;
  String carCategory = '';
  var baseUrl = dotenv.env['ASSET_URL'];

  @override
  void initState() {
    super.initState();
    carController.loadData();
  }

  @override
  void dispose() {
    Get.delete<CarController>();
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
          'รถส่วนตัว',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Obx(
        //     () => carController.carList.isNotEmpty
        //         ? IconButton(
        //             icon: const FaIcon(
        //               FontAwesomeIcons.solidPenToSquare,
        //               color: AppTheme.ognOrangeGold,
        //               size: 20,
        //             ),
        //             onPressed: () {
        //               Get.toNamed('car-edit');
        //             },
        //           )
        //         : Container(),
        //   )
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ข้อมูลรถส่วนตัว',
                  style: TextStyle(
                    color: AppTheme.ognGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                if (carController.carList.isNotEmpty) {
                  if (carController.carList.first.carCategoryId == 1) {
                    carCategory = 'รถยนต์';
                  } else if (carController.carList.first.carCategoryId == 2) {
                    carCategory = 'รถมอเตอร์ไซค์';
                  }
                }
                return carController.carList.isNotEmpty
                    ? Expanded(
                        child: ListView(
                          children: [
                            listCar(
                                Icons.widgets_rounded, 'ประเภท', carCategory),
                            listCar(Icons.pin_rounded, 'ทะเบียน',
                                '${carController.carList.first.carRegistration}'),
                            listCar(FontAwesomeIcons.carTunnel, 'ยี่ห้อ',
                                '${carController.carList.first.carBrand}'),
                            listCar(Icons.palette_rounded, 'สี',
                                '${carController.carList.first.carColor}'),
                            const Padding(
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
                                    style:
                                        TextStyle(color: AppTheme.ognMdGreen),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: carController.carList.first.carImage !=
                                      null
                                  ? Image.network(
                                      '$baseUrl/${carController.carList.first.carImage!.filePath}',
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          'assets/img/car/car-warning.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/img/car/car-warning.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      fit: BoxFit.cover,
                                    ),
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/img/car/car-wash.png',
                                    width: MediaQuery.of(context).size.width *
                                        (screenMode ? 0.10 : 0.25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'ไม่มีข้อมูลรถส่วนตัวของคุณ',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.ognOrangeGold,
                              ),
                              onPressed: () {
                                Get.toNamed('car-add');
                              },
                              child: const SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Center(
                                    child: Text(
                                      'เพิ่มข้อมูลรถส่วนตัว',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
              }),
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
                detail,
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
