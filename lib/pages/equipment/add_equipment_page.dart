import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/controllers/equipment_controller.dart';
import 'package:organics_salary/theme.dart';

class AddEquipmentPage extends StatefulWidget {
  const AddEquipmentPage({super.key});

  @override
  State<AddEquipmentPage> createState() => _AddEquipmentPageState();
}

class _AddEquipmentPageState extends State<AddEquipmentPage> {
  final EquipmentController equipmentController =
      Get.put(EquipmentController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    equipmentController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    equipmentController.fetchEquipment();

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
          'เบิกอุปกรณ์ใหม่',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'กรุณาระบุข้อมูลให้ครบถ้วน',
                      style: TextStyle(
                        color: AppTheme.ognGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.construction_rounded,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'อุปกรณ์',
                                        style: TextStyle(
                                            color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                    Obx(() {
                                      return equipmentController
                                              .assetSupplyCount.value.isNotEmpty
                                          ? Text(
                                              'คงเหลือ : ${equipmentController.assetSupplyCount.value}',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
                                            )
                                          : Container();
                                    })
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Obx(
                                  () => DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == 'เลือกอุปกรณ์' ||
                                          value == null ||
                                          value.isEmpty) {
                                        return 'เลือกอุปกรณ์';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 25),
                                      labelText: 'กรอกรายละเอียด',
                                      labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      hintStyle: const TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: 'เลือกอุปกรณ์',
                                        enabled: false,
                                        child: Text(
                                          'เลือกอุปกรณ์',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(
                                            textStyle: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      for (final equipment
                                          in equipmentController.listEquipment)
                                        DropdownMenuItem<String>(
                                          value: '${equipment['id']}',
                                          child: Text(
                                            '${equipment['name']}',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.kanit(
                                              textStyle: const TextStyle(
                                                  color: AppTheme.ognMdGreen,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                    ],
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        equipmentController
                                            .selectedEquipmentText
                                            .value = value;
                                        print(equipmentController
                                            .selectedEquipmentText.value);

                                        var filteredItems = equipmentController
                                            .listEquipment
                                            .where((item) =>
                                                item['id'] == int.parse(value))
                                            .toList();
                                        print(filteredItems);

                                        equipmentController
                                                .selectedUnitText.value =
                                            filteredItems.first['hr_code']
                                                ['categories_option'];

                                        equipmentController
                                            .checkAssetAndSupply(value);
                                      }
                                    },
                                    value: equipmentController
                                            .selectedEquipmentText.value.isEmpty
                                        ? 'เลือกอุปกรณ์'
                                        : equipmentController
                                            .selectedEquipmentText.value,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    iconEnabledColor: Colors.white,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.filter_1_rounded,
                                      size: 16,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          'จำนวน ${equipmentController.selectedUnitText.value == 1 ? '(ไม่สามารถเพิ่มหรือเปลี่ยนแปลงได้)' : ''}',
                                          style: const TextStyle(
                                              color: AppTheme.ognMdGreen),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Obx(
                                  () => TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรอกรายละเอียด';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (equipmentController
                                              .selectedUnitText.value !=
                                          1) {
                                        equipmentController
                                            .selectedEquipmentUnit
                                            .value = value;
                                      }
                                    },
                                    controller: TextEditingController(
                                      text: equipmentController
                                                  .selectedUnitText.value ==
                                              1
                                          ? '1'
                                          : equipmentController
                                              .selectedEquipmentUnit.value,
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                        color: AppTheme.ognMdGreen,
                                        fontSize: 14),
                                    maxLength: 3,
                                    enabled: equipmentController
                                            .selectedUnitText.value !=
                                        1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 25),
                                      labelText: 'กรอกจำนวน',
                                      labelStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      hintStyle: const TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.circleExclamation,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'เหตุผลการเบิกอุปกรณ์',
                                        style: TextStyle(
                                            color: AppTheme.ognMdGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  onChanged: (value) => equipmentController
                                      .selectedEquipmentDetail.value = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรอกรายละเอียด';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.start,
                                  minLines: 4,
                                  maxLines: null,
                                  style: const TextStyle(
                                      color: AppTheme.ognMdGreen, fontSize: 14),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 25),
                                    labelText: 'กรอกรายละเอียด',
                                    labelStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: const TextStyle(fontSize: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.ognOrangeGold,
                ),
                onPressed: () {
                  // Get.toNamed('confirm-changepass');
                  if ((equipmentController.assetSupplyCount.value != '0') &&
                      (_formKey.currentState?.validate() ?? false)) {
                    equipmentController.sendData();
                  } else {
                    alertEmptyData('แจ้งเตือน',
                        'ยอดคงเหลือไม่เพียงพอ ไม่สามารถส่งคำขอได้');
                  }
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void alertEmptyData(String title, String detail) {
    Get.dialog(
      AlertDialog(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: AppTheme.ognSmGreen,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Text(detail),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.ognSmGreen,
            ),
            child: const Text(
              "ตกลง",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
