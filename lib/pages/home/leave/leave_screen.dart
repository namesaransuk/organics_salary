import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/leave_history_controller.dart';
import 'package:organics_salary/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:carousel_grid/carousel_grid.dart';
import 'dart:async';

final LeaveHistoryController leaveHistoryController =
    Get.put(LeaveHistoryController());

List listLeave = [
  {'lId': 1, 'lName': 'ลาป่วย'},
  {'lId': 2, 'lName': 'ลากิจ'},
  {'lId': 3, 'lName': 'ลาพักร้อนประจำปี'},
  {'lId': 4, 'lName': 'ลาคลอด'},
  {'lId': 5, 'lName': 'มาสาย'},
  {'lId': 6, 'lName': 'ลาอื่นๆ'},
];

List listMonth = [
  'มกราคม',
  'กุมภาพันธ์',
  'มีนาคม',
  'เมษายน',
  'พฤษภาคม',
  'มิถุนายน',
  'กรกฎาคม',
  'สิงหาคม',
  'กันยายน',
  'ตุลาคม',
  'พฤศจิกายน',
  'ธันวาคม',
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

  int? selectedLeaveId;
  XFile? image1;
  XFile? image2;
  XFile? image3;
  XFile? image4;
  XFile? image5;
  List<XFile?> selectedImages = [];
  String? reasonLeave;

  DateTime? partDateStart;
  DateTime? partDateEnd;
  TimeOfDay? partTimeStart;
  TimeOfDay? partTimeEnd;

  final ImagePicker picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.pickMultiImage(
  //       imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
  //   List<XFile> xfilePick = pickedFile;

  //   for (var i = 0; i < xfilePick.length; i++) {
  //     selectedImages.add(File(xfilePick[i].path));
  //   }

  //   setState(() {});
  // }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      // image1 = img;
      selectedImages.add(img);
    });
  }

  String startDate = 'เลือกวันที่';
  String startTime = 'เลือกเวลา';
  String endDate = 'เลือกวันที่';
  String endTime = 'เลือกเวลา';

  Future<void> _selectDate(BuildContext context, int mode) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      // final String formattedDate =
      //     DateFormat('dd MMMM yyyy', 'th').format(picked.toLocal());
      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(picked.toLocal());

      setState(() {
        if (mode == 1) {
          startDate = formattedDate;
          partDateStart = selectedDate;
        } else {
          endDate = formattedDate;
          partDateEnd = selectedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int mode) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      // final String formattedTime = DateFormat.Hm().format(newTime);
      final String formattedTime = "${pickedTime.hour}".padLeft(2, '0') +
          ":" +
          "${pickedTime.minute}".padLeft(2, '0');

      setState(() {
        if (mode == 1) {
          startTime = formattedTime;
          partTimeStart = selectedTime;
        } else {
          endTime = formattedTime;
          partTimeEnd = selectedTime;
        }
      });
    }
  }

  int? selectedOption;

  final box = GetStorage();

  @override
  void initState() {
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
                                dynamic selectedValues = value.split(' ');
                                int leaveId = int.parse(selectedValues[0]);

                                selectedLeaveId = leaveId;
                                selectedLeave = value;

                                print(selectedLeaveId);
                              });
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
                                        // child: image1 != null
                                        child: selectedImages.isNotEmpty
                                            // ? Column(
                                            //     children: [
                                            //       GridView.builder(
                                            //         shrinkWrap: true,
                                            //         itemCount:
                                            //             selectedImages.length,
                                            //         gridDelegate:
                                            //             const SliverGridDelegateWithFixedCrossAxisCount(
                                            //                 crossAxisCount: 2),
                                            //         itemBuilder:
                                            //             (BuildContext context,
                                            //                 int index) {
                                            //           return Center(
                                            //               child: Padding(
                                            //             padding:
                                            //                 const EdgeInsets
                                            //                     .symmetric(
                                            //                     vertical: 5),
                                            //             child: ClipRRect(
                                            //               borderRadius:
                                            //                   BorderRadius.all(
                                            //                       Radius
                                            //                           .circular(
                                            //                               10)),
                                            //               child: Image.file(
                                            //                   selectedImages[
                                            //                       index]),
                                            //             ),
                                            //           ));
                                            //         },
                                            //       ),
                                            //       SizedBox(
                                            //         height: 10,
                                            //       ),
                                            //       ElevatedButton(
                                            //         onPressed: () {
                                            //           selectedImages.clear();
                                            //           getImage();
                                            //           // myAlert();
                                            //         },
                                            //         child:
                                            //             Text('เลือกรูปภาพใหม่'),
                                            //       ),
                                            //     ],
                                            //   )
                                            ? Column(
                                                children:
                                                    selectedImages.map((img) {
                                                  return Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        child: Image.file(
                                                          File(img!.path),
                                                          fit: BoxFit.cover,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 300,
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          myAlert();
                                                        },
                                                        child: Text(
                                                            'เลือกรูปภาพใหม่'),
                                                      ),
                                                    ],
                                                  );
                                                }).toList(),
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
                                                        // getImage();
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
                        onChanged: (value) {
                          setState(() {
                            reasonLeave = value;
                          });
                        },
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
                        onPressed: () {
                          setState(() {
                            String leaveStart = '$startDate $startTime:00';
                            String leaveEnd = '$endDate $endTime:00';
                            print(leaveStart);
                            print(leaveEnd);
                            leaveHistoryController.sendData(selectedLeaveId,
                                selectedImages, reasonLeave, leaveStart, leaveEnd);
                          });
                        },
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
    // leaveHistoryController.loadData();

    return ListView(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(50),
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
                // ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: DropdownButton<String>(
                  value: leaveHistoryController.monthName.value,
                  borderRadius: BorderRadius.circular(20),
                  items: [
                    DropdownMenuItem<String>(
                      enabled: false,
                      value: 'กรุณาเลือกเดือน',
                      child: Text(
                        'กรุณาเลือกเดือน',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    for (final month in listMonth)
                      DropdownMenuItem<String>(
                        value: month,
                        child: Text(
                          month,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      int selectedIndex = listMonth.indexOf(value) + 1;
                      leaveHistoryController.loadData(selectedIndex);
                      leaveHistoryController.getMonthName(value);
                    }
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                  iconEnabledColor: Colors.white,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  dropdownColor: Colors.white,
                  underline: Container(),
                  isExpanded: true,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => leaveHistoryController.leaveHistoryList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: leaveHistoryController.leaveHistoryList.map((item) {
                    List<String> imagesUrls = [];

                    Map<String, dynamic> jsonData = {
                      "leave_img1": item.leaveImg1,
                      "leave_img2": item.leaveImg2,
                      "leave_img3": item.leaveImg3,
                      "leave_img4": item.leaveImg4,
                      "leave_img5": item.leaveImg5,
                    };

                    jsonData.forEach((key, value) {
                      if (value is String) {
                        imagesUrls.add(value);
                      }
                    });

                    return Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item.day} ${listMonth[item.month! - 1]} ${item.year}',
                              style: TextStyle(color: AppTheme.ognGreen),
                            ),
                            Container(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ประเภทการลา',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child:
                                                    Text('${item.leaveType}'),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        Dialog(
                                                  backgroundColor: Colors.white,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppTheme.ognGreen,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    25),
                                                            topRight:
                                                                Radius.circular(
                                                                    25),
                                                          ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 15),
                                                        child: Center(
                                                          child: Text(
                                                            '${item.day} ${listMonth[item.month! - 1]} ${item.year}',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white, // สีข้อความ
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      CarouselGrid(
                                                        // height: 285,
                                                        width: double.infinity,
                                                        listUrlImages:
                                                            imagesUrls,
                                                        loopCarouselList: false,
                                                        iconBack: const Icon(
                                                          Icons.arrow_back,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text('ปิด'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text('ดูไฟล์'),
                                          )
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
                                        child: Text('${item.leaveDetail}'),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'ระยะเวลาวันที่ลา',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'ตั้งแต่ : ${dateThaiFormat(item.leaveDateStart)}'),
                                            Text(
                                                'จนถึง : ${dateThaiFormat(item.leaveDateEnd)}'),
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
                      ],
                    );
                  }).toList(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('ไม่มีข้อมูลการลา'),
                  ],
                )),
        ),
      ],
    );
  }

  String dateThaiFormat(date) {
    DateTime originalDate = DateTime.parse('$date');

    String thaiFormattedDateTime =
        DateFormat.yMMMMd('th').add_Hm().format(originalDate);

    thaiFormattedDateTime = thaiFormattedDateTime.replaceAll(' ค.ศ.', '');

    return thaiFormattedDateTime;
  }
}
