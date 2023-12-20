import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> listLeave = [
  {'lId': 1, 'lName': 'ลาป่วย'},
  {'lId': 2, 'lName': 'มาสาย'},
  {'lId': 3, 'lName': 'ลากิจ'},
  {'lId': 4, 'lName': 'ลาพักร้อนประจำปี'},
  {'lId': 5, 'lName': 'ลาคลอด'},
  {'lId': 6, 'lName': 'ลาอื่นๆ'},
];

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SegmentedTabControl(
                radius: const Radius.circular(0),
                backgroundColor: Colors.grey.shade500,
                indicatorColor: Color.fromARGB(255, 19, 110, 104),
                tabTextColor: Colors.white,
                selectedTabTextColor: Colors.white,
                squeezeIntensity: 2,
                height: 55,
                tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                textStyle: Theme.of(context).textTheme.bodyLarge,
                tabs: [
                  SegmentTab(label: 'แจ้งลา'),
                  SegmentTab(label: 'ประวัติการลา'),
                ],
              ),
            ),
            // Sample pages
            Container(
              padding: EdgeInsets.only(top: 55),
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  LeaveReport(),
                  LeaveHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------

class LeaveReport extends StatefulWidget {
  const LeaveReport({super.key});

  @override
  State<LeaveReport> createState() => _LeaveReportState();
}

class _LeaveReportState extends State<LeaveReport> {
  // late TextEditingController _nameController;
  // late TextEditingController _empIdController;
  // late TextEditingController _departmentController;

  String? selectedLeave;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String startDate = 'เลือกวันที่';
  String startTime = 'เลือกเวลา';
  String endDate = 'เลือกวันที่';
  String endTime = 'เลือกเวลา';

  Future<void> _selectDate(BuildContext context, int mode) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      final String formattedDate =
          DateFormat('dd MMMM yyyy', 'th').format(picked!.toLocal());
      setState(() {
        if (mode == 1) {
          startDate = formattedDate;
        } else {
          endDate = formattedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int mode) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      final DateTime now = DateTime.now();
      final DateTime newTime =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);

      final String formattedTime = DateFormat.Hm().format(newTime);

      setState(() {
        if (mode == 1) {
          startTime = formattedTime;
        } else {
          endTime = formattedTime;
        }
      });
    }
  }

  int? selectedOption;

  final box = GetStorage();

  @override
  void initState() {
    // _nameController = TextEditingController(text: '${box.read('f_name')} ${box.read('l_name')}');
    // _empIdController = TextEditingController(text: box.read('employee_code'));
    // _departmentController = TextEditingController(text: box.read('position_name_th'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  // TextField(
                  //   controller: _nameController,
                  //   readOnly: true,
                  //   decoration: InputDecoration(
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                  //     labelText: 'ชื่อ-นามสกุล',
                  //     alignLabelWithHint: true,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30.0),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30.0),
                  //       borderSide: BorderSide(color: AppTheme.ognGreen),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30.0),
                  //       borderSide: BorderSide(color: Colors.grey),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextField(
                  //         controller: _empIdController,
                  //         readOnly: true,
                  //         decoration: InputDecoration(
                  //           labelText: 'รหัสพนักงาน',
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 7, horizontal: 16),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //             borderSide: BorderSide(color: AppTheme.ognGreen),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //             borderSide: BorderSide(color: Colors.grey),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 16),
                  //     Expanded(
                  //       child: TextField(
                  //         controller: _departmentController,
                  //         readOnly: true,
                  //         decoration: InputDecoration(
                  //           labelText: 'แผนก / ฝ่าย',
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 7, horizontal: 16),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //             borderSide: BorderSide(color: AppTheme.ognGreen),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //             borderSide: BorderSide(color: Colors.grey),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Divider(height: 40, color: Colors.black45),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ประเภทการลา'),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(50),
                          // boxShadow: <BoxShadow>[
                          //   BoxShadow(
                          //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                          // ],
                        ),
                        child: DropdownButton(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          borderRadius: BorderRadius.circular(20),
                          hint: Text('เลือกประเภทการลา'),
                          items: [
                            DropdownMenuItem<String>(
                              value: 'เลือกประเภทการลา',
                              enabled: false,
                              child: Text(
                                'เลือกประเภทการลา',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),
                            for (final leave in listLeave)
                              DropdownMenuItem<String>(
                                value: '${leave['lId']} ${leave['lName']}',
                                child: Text(
                                  '${leave['lName']}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                          ],
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                selectedLeave = value;
                              });
                              // dynamic selectedValues = value.split(' ');
                              // int selectedMonth = int.parse(selectedValues[0]);
                              // String selectedMonthName = selectedValues[1];

                              // salaryController.loadData(selectedMonth);
                              // salaryController.getMonthName(selectedMonthName);
                              // print(selectedMonth);
                            }
                          },
                          value: selectedLeave,
                          icon: const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              )),
                          iconEnabledColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          dropdownColor: Colors.white,
                          underline: Container(),
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  selectedLeave != null && selectedLeave!.startsWith('1')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value;
                                        print("Button value: $value");
                                      });
                                    },
                                  ),
                                  Text('ไม่มีใบรับรองแพทย์')
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value;
                                        print("Button value: $value");
                                      });
                                    },
                                  ),
                                  Text('มีใบรับรองแพทย์')
                                ],
                              ),
                              selectedOption == 2
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: DottedBorder(
                                        dashPattern: [8, 4],
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(12),
                                        padding: EdgeInsets.all(20),
                                        child: image != null
                                            ? Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    child: Image.file(
                                                      File(image!.path),
                                                      fit: BoxFit.cover,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 300,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      myAlert();
                                                    },
                                                    child:
                                                        Text('เลือกรูปภาพใหม่'),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "ไม่ได้เลือกรูปภาพ",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        myAlert();
                                                      },
                                                      child: Text('อัพโหลดรูป'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('เหตุผลการลา'),
                      TextField(
                        minLines: 3,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: '',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: AppTheme.ognGreen),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ตั่งแต่'),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('วันที่ : ${startDate}'),
                            ElevatedButton(
                              onPressed: () => _selectDate(context, 1),
                              child: Text('เลือกวันที่'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('เวลา : $startTime'),
                            ElevatedButton(
                              onPressed: () => _selectTime(context, 1),
                              child: Text('เลือกเวลา'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('จนถึง'),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('วันที่ : $endDate'),
                            ElevatedButton(
                              onPressed: () => _selectDate(context, 2),
                              child: Text('เลือกวันที่'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('เวลา : $endTime'),
                            ElevatedButton(
                              onPressed: () => _selectTime(context, 2),
                              child: Text('เลือกเวลา'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Card(
                    color: AppTheme.ognGreen,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'กฏระเบียบการลา',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ลาพักร้อน ลาป่วย ลากิจ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet consectetur adipisicing elit. Beatae, molestias pariatur. Accusamus facilis beatae quas impedit consequuntur laudantium temporibus aut autem porro pariatur praesentium doloremque optio deleniti, odio, dicta eaque.',
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.ognGreen,
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'บันทึกใบลา',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('กรุณาเลือกรูป'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        SizedBox(width: 7),
                        Text('จากแกลลอรี่'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(width: 7),
                        Text('จากกล้อง'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// --------------------------------------------------------------

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '28 พ.ย. 2566',
                    style: TextStyle(color: AppTheme.ognGreen),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ลาป่วย',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('ไม่มีใบรับรองแพทย์'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'สาเหตุการลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('เป็นไข้ ปวดหัว ตัวร้อน นอนไม่หลับ'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'จำนวนวันที่ลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ตั้งแต่ 28 พ.ย. 2566 เวลา 08.00 น.'),
                                  Text('จนถึง 28 พ.ย. 2566 เวลา 18.00 น.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '20 ก.ย. 2566',
                    style: TextStyle(color: AppTheme.ognGreen),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ลาป่วย',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text('มีใบรับรองแพทย์'),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('ดูไฟล์'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'สาเหตุการลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('ติดเชื้อ Covid 19'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'จำนวนวันที่ลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ตั้งแต่ 20 ก.ย. 2566 เวลา 08.00 น.'),
                                  Text('จนถึง 25 ก.ย. 2566 เวลา 18.00 น.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10 ก.ค. 2566',
                    style: TextStyle(color: AppTheme.ognGreen),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ลาพักร้อน',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('-'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'สาเหตุการลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('ลาพักร้อนประจำปี'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'จำนวนวันที่ลา',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ตั้งแต่ 19 ก.ค. 2566 เวลา 08.00 น.'),
                                  Text('จนถึง 21 ก.ค. 2566 เวลา 18.00 น.'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
