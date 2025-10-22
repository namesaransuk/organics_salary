import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

import 'package:organics_salary/controllers/salary_controller.dart';
import 'package:organics_salary/service/pdf_to_image_helper.dart';
import 'package:organics_salary/service/image_download_helper.dart';
import 'package:organics_salary/theme.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SlipViewSection extends StatefulWidget {
  final String? filePath; // อาจเป็น URL หรือ พาธไฟล์ในเครื่อง

  const SlipViewSection({super.key, this.filePath});

  @override
  _SlipViewSectionState createState() => _SlipViewSectionState();
}

class _SlipViewSectionState extends State<SlipViewSection> {
  final SalaryController salaryController = Get.put(SalaryController());
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfViewerController = PdfViewerController();

  bool get _isUrl {
    final p = widget.filePath;
    if (p == null) return false;
    final uri = Uri.tryParse(p);
    return uri != null &&
        (uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https'));
  }

  @override
  Widget build(BuildContext context) {
    final src = widget.filePath;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _saveFile, // ใช้เมธอดเดิมชื่อเดิม
        backgroundColor: AppTheme.ognOrangeGold,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
      ),
      body: src == null || src.isEmpty
          ? const Center(child: Text('ไม่พบไฟล์'))
          : _isUrl
              ? SfPdfViewer.network(
                  src,
                  key: _pdfViewerKey,
                  controller: _pdfViewerController,
                )
              : SfPdfViewer.file(
                  File(src),
                  key: _pdfViewerKey,
                  controller: _pdfViewerController,
                ),
    );
  }

  /// แทนที่เนื้อหาเมธอดเดิมของคุณ:
  /// - ถ้าเป็น URL: ดาวน์โหลดด้วย Dio -> bytes
  /// - ถ้าเป็นไฟล์โลคัล: อ่านไฟล์โดยตรง -> bytes
  /// แล้วแปลงหน้าแรกเป็น PNG และบันทึกลง Photos/Gallery
  Future<void> _saveFile() async {
    try {
      final path = widget.filePath;
      if (path == null || path.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ไม่พบไฟล์ PDF')),
        );
        return;
      }

      Uint8List pdfBytes;

      if (_isUrl) {
        // ดาวน์โหลด PDF จาก URL
        final dio = Dio();
        final resp = await dio.get<List<int>>(
          path,
          options: Options(responseType: ResponseType.bytes),
        );
        final data = resp.data;
        if (data == null || data.isEmpty) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ดาวน์โหลดไฟล์ไม่สำเร็จ')),
          );
          return;
        }
        pdfBytes = Uint8List.fromList(data);
      } else {
        // อ่านจากไฟล์ในเครื่อง
        pdfBytes = await File(path).readAsBytes();
      }

      // แปลงหน้าแรกเป็น PNG (กำหนดเป็น double และคำนวณ height ภายใน helper)
      final pngBytes = await PdfToImageHelper.firstPageAsPng(
        pdfBytes,
        targetWidth: 2048, // double
      );

      if (pngBytes == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('แปลง PDF เป็นรูปไม่สำเร็จ')),
        );
        return;
      }

      // บันทึก PNG ลง Photos/Gallery
      final ok = await ImageDownloadHelper.saveBytesToGallery(
        pngBytes,
        prefix: 'salary-slip', // ใช้ prefix แทน fileName
        quality: 100,
      );

      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('บันทึกรูปเรียบร้อย ✅')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('บันทึกรูปไม่สำเร็จ ❌')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';
// import 'package:organics_salary/controllers/salary_controller.dart';
// import 'package:organics_salary/service/save_helper.dart';
// import 'package:organics_salary/theme.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class SlipViewSection extends StatefulWidget {
//   final String? filePath;

//   const SlipViewSection({super.key, this.filePath});

//   @override
//   _SlipViewSectionState createState() => _SlipViewSectionState();
// }

// class _SlipViewSectionState extends State<SlipViewSection> {
//   final SalaryController salaryController = Get.put(SalaryController());
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
//   final PdfViewerController _pdfViewerController = PdfViewerController();

//   @override
//   Widget build(BuildContext context) {
//     print(widget.filePath);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: _saveFile,
//         backgroundColor: AppTheme.ognOrangeGold,
//         shape: const CircleBorder(),
//         child: const Icon(
//           Icons.download,
//           color: Colors.white,
//         ),
//       ),
//       body: SfPdfViewer.network(
//         widget.filePath.toString(),
//         key: _pdfViewerKey,
//         controller: _pdfViewerController,
//       ),
//     );
//   }

//   Future<void> _saveFile() async {
//     try {
//       if (_pdfViewerController.pageCount > 0) {
//         List<int> bytes = await _pdfViewerController.saveDocument();
//         String fileName =
//             Uri.parse(salaryController.salaryList.value).pathSegments.last;

//         bool? result = await SaveHelper.save(bytes, fileName);

//         if (result == true) {
//           // ✅ บันทึกสำเร็จ
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('ดาวน์โหลดไฟล์เสร็จเรียบร้อยแล้ว'),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         } else {
//           // ❌ ผู้ใช้ยกเลิก (เช่นไม่เลือก path) -> ไม่แสดง SnackBar ใดๆ
//         }
//       } else {
//         // ❌ PDF ไม่พร้อม
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('เกิดข้อผิดพลาด ไม่สามารถดาวน์โหลดไฟล์นี้ได้'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       // ❌ กรณีเกิด exception (เช่น user กดย้อนกลับ)
//       print('User canceled or error: $e');
//       // 👉 ไม่แสดงอะไรเลย
//     }
//   }
// }

