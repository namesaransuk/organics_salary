import 'dart:typed_data';
import 'package:pdfx/pdfx.dart';

class PdfToImageHelper {
  static Future<Uint8List?> pageAsPng(
    Uint8List pdfBytes, {
    int pageIndex = 1,
    double targetWidth = 2048, 
  }) async {
    PdfDocument? doc;
    PdfPage? page;
    try {
      doc = await PdfDocument.openData(pdfBytes);
      final pageCount = doc.pagesCount;
      if (pageCount == 0) return null;

      final safeIndex = pageIndex.clamp(1, pageCount);
      page = await doc.getPage(safeIndex);

      final aspectRatio = page.width / page.height;
      final targetHeight = targetWidth / aspectRatio;

      final pageImage = await page.render(
        width: targetWidth,
        height: targetHeight,
        format: PdfPageImageFormat.png,
        backgroundColor: '#FFFFFF', // ป้องกัน transparency
      );

      return pageImage?.bytes;
    } finally {
      try {
        await page?.close();
      } catch (_) {}
      try {
        await doc?.close();
      } catch (_) {}
    }
  }

  /// เรียกง่าย: แปลงหน้าแรกของ PDF -> PNG
  static Future<Uint8List?> firstPageAsPng(
    Uint8List pdfBytes, {
    double targetWidth = 2048, // ✅ เปลี่ยนเป็น double เช่นกัน
  }) {
    return pageAsPng(pdfBytes, pageIndex: 1, targetWidth: targetWidth);
  }
}
