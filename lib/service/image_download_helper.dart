import 'dart:typed_data';
import 'package:saver_gallery/saver_gallery.dart';

class ImageDownloadHelper {
  static Future<bool> saveBytesToGallery(
    Uint8List bytes, {
    String prefix = 'salary-slip', // ชื่อไฟล์ขึ้นต้น
    int quality = 100,
  }) async {
    final now = DateTime.now();
    final formattedTime =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}';
    final uniqueFileName = '$prefix-$formattedTime.png';

    final result = await SaverGallery.saveImage(
      bytes,
      fileName: uniqueFileName,
      quality: quality,
      skipIfExists: false, // ไม่ข้ามแม้ชื่อจะคล้ายกัน
      androidRelativePath: 'Pictures/OrganicsSalary', // โฟลเดอร์ใน Android
    );

    return result.isSuccess;
  }
}
