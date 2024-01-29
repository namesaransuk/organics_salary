// Column(
//   children: [
//     // TextField(
//     //   controller: _nameController,
//     //   readOnly: true,
//     //   decoration: InputDecoration(
//     //     contentPadding:
//     //         EdgeInsets.symmetric(vertical: 7, horizontal: 16),
//     //     labelText: 'ชื่อ-นามสกุล',
//     //     alignLabelWithHint: true,
//     //     border: OutlineInputBorder(
//     //       borderRadius: BorderRadius.circular(30.0),
//     //     ),
//     //     focusedBorder: OutlineInputBorder(
//     //       borderRadius: BorderRadius.circular(30.0),
//     //       borderSide: BorderSide(color: AppTheme.ognGreen),
//     //     ),
//     //     enabledBorder: OutlineInputBorder(
//     //       borderRadius: BorderRadius.circular(30.0),
//     //       borderSide: BorderSide(color: Colors.grey),
//     //     ),
//     //   ),
//     // ),
//     // SizedBox(height: 16),
//     // Row(
//     //   children: [
//     //     Expanded(
//     //       child: TextField(
//     //         controller: _empIdController,
//     //         readOnly: true,
//     //         decoration: InputDecoration(
//     //           labelText: 'รหัสพนักงาน',
//     //           contentPadding: EdgeInsets.symmetric(
//     //               vertical: 7, horizontal: 16),
//     //           border: OutlineInputBorder(
//     //             borderRadius: BorderRadius.circular(30.0),
//     //           ),
//     //           focusedBorder: OutlineInputBorder(
//     //             borderRadius: BorderRadius.circular(30.0),
//     //             borderSide: BorderSide(color: AppTheme.ognGreen),
//     //           ),
//     //           enabledBorder: OutlineInputBorder(
//     //             borderRadius: BorderRadius.circular(30.0),
//     //             borderSide: BorderSide(color: Colors.grey),
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //     SizedBox(width: 16),
//     //     Expanded(
//     //       child: TextField(
//     //         controller: _departmentController,
//     //         readOnly: true,
//     //         decoration: InputDecoration(
//     //           labelText: 'แผนก / ฝ่าย',
//     //           contentPadding: EdgeInsets.symmetric(
//     //               vertical: 7, horizontal: 16),
//     //           border: OutlineInputBorder(
//     //             borderRadius: BorderRadius.circular(30.0),
//     //           ),
//     //           focusedBorder: OutlineInputBorder(
//     //             borderRadius: BorderRadius.circular(30.0),
//     //             borderSide: BorderSide(color: AppTheme.ognGreen),
//     //           ),
//     //           enabledBorder: OutlineInputBorder(
//     //             borderRadius: BorderRadius.circular(30.0),
//     //             borderSide: BorderSide(color: Colors.grey),
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // ),
//     // Divider(height: 40, color: Colors.black45),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('ประเภทการลา'),
//         DecoratedBox(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey, width: 1),
//             borderRadius: BorderRadius.circular(50),
//             // boxShadow: <BoxShadow>[
//             //   BoxShadow(
//             //       color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
//             // ],
//           ),
//           child: DropdownButton(
//             padding: EdgeInsets.only(left: 30, right: 30),
//             borderRadius: BorderRadius.circular(20),
//             hint: Text('เลือกประเภทการลา'),
//             items: [
//               DropdownMenuItem<String>(
//                 value: 'เลือกประเภทการลา',
//                 enabled: false,
//                 child: Text(
//                   'เลือกประเภทการลา',
//                   style: const TextStyle(color: Colors.black54),
//                 ),
//               ),
//               for (final leave in listLeave)
//                 DropdownMenuItem<String>(
//                   value: '${leave['lId']} ${leave['lName']}',
//                   child: Text(
//                     '${leave['lName']}',
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ),
//             ],
//             onChanged: (String? value) {
//               if (value != null) {
//                 setState(() {
//                   dynamic selectedValues = value.split(' ');
//                   int leaveId = int.parse(selectedValues[0]);

//                   selectedLeaveId = leaveId;
//                   selectedLeave = value;

//                   print(selectedLeaveId);
//                 });
//                 // int selectedMonth = int.parse(selectedValues[0]);
//                 // String selectedMonthName = selectedValues[1];

//                 // leaveHistoryController.loadData(selectedMonth);
//                 // leaveHistoryController.getMonthName(selectedMonthName);
//                 // print(selectedMonth);
//               }
//             },
//             value: selectedLeave,
//             icon: const Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.black,
//                 )),
//             iconEnabledColor: Colors.white,
//             style: const TextStyle(
//                 color: Colors.black, fontSize: 15),
//             dropdownColor: Colors.white,
//             underline: Container(),
//             isExpanded: true,
//           ),
//         ),
//       ],
//     ),
//     selectedLeave != null && selectedLeave!.startsWith('1')
//         ? Padding(
//             padding: const EdgeInsets.symmetric(
//                 vertical: 8.0, horizontal: 16.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Radio(
//                       value: 1,
//                       groupValue: selectedOption,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedOption = value;
//                           print("Button value: $value");
//                         });
//                       },
//                     ),
//                     Text('ไม่มีใบรับรองแพทย์')
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Radio(
//                       value: 2,
//                       groupValue: selectedOption,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedOption = value;
//                           print("Button value: $value");
//                         });
//                       },
//                     ),
//                     Text('มีใบรับรองแพทย์')
//                   ],
//                 ),
//                 selectedOption == 2
//                     ? Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10),
//                         child: DottedBorder(
//                           dashPattern: [8, 4],
//                           borderType: BorderType.RRect,
//                           radius: Radius.circular(12),
//                           padding: EdgeInsets.all(20),
//                           // child: image1 != null
//                           child: selectedImages.isNotEmpty
//                               // ? Column(
//                               //     children: [
//                               //       GridView.builder(
//                               //         shrinkWrap: true,
//                               //         itemCount:
//                               //             selectedImages.length,
//                               //         gridDelegate:
//                               //             const SliverGridDelegateWithFixedCrossAxisCount(
//                               //                 crossAxisCount: 2),
//                               //         itemBuilder:
//                               //             (BuildContext context,
//                               //                 int index) {
//                               //           return Center(
//                               //               child: Padding(
//                               //             padding:
//                               //                 const EdgeInsets
//                               //                     .symmetric(
//                               //                     vertical: 5),
//                               //             child: ClipRRect(
//                               //               borderRadius:
//                               //                   BorderRadius.all(
//                               //                       Radius
//                               //                           .circular(
//                               //                               10)),
//                               //               child: Image.file(
//                               //                   selectedImages[
//                               //                       index]),
//                               //             ),
//                               //           ));
//                               //         },
//                               //       ),
//                               //       SizedBox(
//                               //         height: 10,
//                               //       ),
//                               //       ElevatedButton(
//                               //         onPressed: () {
//                               //           selectedImages.clear();
//                               //           getImage();
//                               //           // myAlert();
//                               //         },
//                               //         child:
//                               //             Text('เลือกรูปภาพใหม่'),
//                               //       ),
//                               //     ],
//                               //   )
//                               ? Column(
//                                   children: [
//                                     Text(
//                                         'แนบไฟล์รูปภาพได้สูงสุด 5 ไฟล์'),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       child:
//                                           selectedImages != null
//                                               ? GridView.builder(
//                                                   shrinkWrap:
//                                                       true,
//                                                   gridDelegate:
//                                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                                     crossAxisCount:
//                                                         2,
//                                                     crossAxisSpacing:
//                                                         8.0,
//                                                     mainAxisSpacing:
//                                                         8.0,
//                                                   ),
//                                                   itemCount: selectedImages.length < 5
//                                                       ? selectedImages
//                                                               .length +
//                                                           1
//                                                       : selectedImages
//                                                           .length,
//                                                   itemBuilder:
//                                                       (BuildContext
//                                                               context,
//                                                           int index) {
//                                                     if (index ==
//                                                             selectedImages
//                                                                 .length &&
//                                                         selectedImages
//                                                                 .length <
//                                                             5) {
//                                                       return Expanded(
//                                                         child:
//                                                             InkWell(
//                                                           onTap:
//                                                               () {
//                                                             myAlert();
//                                                           },
//                                                           child:
//                                                               Card(
//                                                             child:
//                                                                 Column(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment.center,
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment.center,
//                                                               children: [
//                                                                 Icon(
//                                                                   Icons.add_photo_alternate_outlined,
//                                                                   color: AppTheme.ognGreen,
//                                                                   size: 24.0,
//                                                                 ),
//                                                                 Text(
//                                                                   'เลือกรูปเพิ่ม',
//                                                                   style: TextStyle(color: AppTheme.ognGreen),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       );
//                                                     }

//                                                     var img =
//                                                         selectedImages[
//                                                             index];

//                                                     return Expanded(
//                                                       child:
//                                                           ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .all(
//                                                           Radius.circular(
//                                                               5),
//                                                         ),
//                                                         child:
//                                                             Stack(
//                                                           children: [
//                                                             Image
//                                                                 .file(
//                                                               File(img!.path),
//                                                               fit:
//                                                                   BoxFit.cover,
//                                                               width:
//                                                                   MediaQuery.of(context).size.width / 2 - 12,
//                                                             ),
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment.topRight,
//                                                               child:
//                                                                   Padding(
//                                                                 padding: const EdgeInsets.all(8.0),
//                                                                 child: Material(
//                                                                   color: Colors.transparent,
//                                                                   child: Ink(
//                                                                     width: 25,
//                                                                     height: 25,
//                                                                     decoration: const ShapeDecoration(
//                                                                       color: Colors.red,
//                                                                       shape: CircleBorder(),
//                                                                     ),
//                                                                     child: IconButton(
//                                                                       icon: const Icon(
//                                                                         Icons.close,
//                                                                         size: 9,
//                                                                       ),
//                                                                       color: Colors.white,
//                                                                       onPressed: () {
//                                                                         setState(() {
//                                                                           selectedImages.remove(img);
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                 )
//                                               : Container(
//                                                   width: double
//                                                       .infinity,
//                                                   child: Column(
//                                                     children: [
//                                                       Text(
//                                                         "ไม่ได้เลือกรูปภาพ",
//                                                         style: TextStyle(
//                                                             fontSize:
//                                                                 18),
//                                                       ),
//                                                       ElevatedButton(
//                                                         onPressed:
//                                                             () {
//                                                           // getImage();
//                                                           myAlert();
//                                                         },
//                                                         child: Text(
//                                                             'อัพโหลดรูป'),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                     ),
//                                   ],
//                                 )
//                               : Container(
//                                   width: double.infinity,
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         "ไม่ได้เลือกรูปภาพ",
//                                         style: TextStyle(
//                                             fontSize: 18),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           // getImage();
//                                           myAlert();
//                                         },
//                                         child: Text('อัพโหลดรูป'),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                         ),
//                       )
//                     : Container(),
//               ],
//             ),
//           )
//         : Container(),
//     SizedBox(height: 16),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('เหตุผลการลา'),
//         TextField(
//           onChanged: (value) {
//             setState(() {
//               reasonLeave = value;
//             });
//           },
//           minLines: 3,
//           maxLines: null,
//           keyboardType: TextInputType.multiline,
//           decoration: InputDecoration(
//             alignLabelWithHint: true,
//             hintText: '',
//             contentPadding: EdgeInsets.symmetric(
//                 vertical: 16, horizontal: 16),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: BorderSide(color: AppTheme.ognGreen),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//           ),
//         ),
//       ],
//     ),
//     SizedBox(height: 16),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('ตั่งแต่'),
//         SizedBox(
//           height: 5,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 16, vertical: 2),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('วันที่ : ${startDate}'),
//               ElevatedButton(
//                 onPressed: () => _selectDate(context, 1),
//                 child: Text('เลือกวันที่'),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 16, vertical: 2),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('เวลา : $startTime'),
//               ElevatedButton(
//                 onPressed: () => _selectTime(context, 1),
//                 child: Text('เลือกเวลา'),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//     SizedBox(height: 16),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('จนถึง'),
//         SizedBox(
//           height: 5,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 16, vertical: 2),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('วันที่ : $endDate'),
//               ElevatedButton(
//                 onPressed: () => _selectDate(context, 2),
//                 child: Text('เลือกวันที่'),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 16, vertical: 2),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('เวลา : $endTime'),
//               ElevatedButton(
//                 onPressed: () => _selectTime(context, 2),
//                 child: Text('เลือกเวลา'),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//     SizedBox(height: 16),
//     Card(
//       color: AppTheme.ognGreen,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'กฏระเบียบการลา',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'ลาพักร้อน ลาป่วย ลากิจ',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Lorem ipsum dolor sit amet consectetur adipisicing elit. Beatae, molestias pariatur. Accusamus facilis beatae quas impedit consequuntur laudantium temporibus aut autem porro pariatur praesentium doloremque optio deleniti, odio, dicta eaque.',
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     Padding(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       child: Center(
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppTheme.ognGreen,
//           ),
//           onPressed: () {
//             setState(() {
//               String leaveStart = '$startDate $startTime:00';
//               String leaveEnd = '$endDate $endTime:00';
//               print(leaveStart);
//               print(leaveEnd);
//               leaveHistoryController.sendData(
//                   selectedLeaveId,
//                   selectedImages,
//                   reasonLeave,
//                   leaveStart,
//                   leaveEnd);
//             });
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text(
//               'บันทึกใบลา',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     )
//   ],
// ),
