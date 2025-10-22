// import 'dart:async';

// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// // import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ScanPage extends StatefulWidget {
//   const ScanPage({super.key});

//   @override
//   State<ScanPage> createState() => _ScanPageState();
// }

// class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
//   // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   final MobileScannerController controller = MobileScannerController(
//     detectionSpeed: DetectionSpeed.noDuplicates,
//   );

//   StreamSubscription<Object?>? _subscription;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // Start listening to lifecycle changes.
//   //   WidgetsBinding.instance.addObserver(this);
//   //   // Start listening to the barcode events.
//   //   // _subscription = controller.barcodes.listen(_handleBarcode);
//   //   // Finally, start the scanner itself.
//   //   unawaited(controller.start());
//   // }

//   // @override
//   // Future<void> dispose() async {
//   //   // Stop listening to lifecycle changes.
//   //   WidgetsBinding.instance.removeObserver(this);
//   //   // Stop listening to the barcode events.
//   //   unawaited(_subscription?.cancel());
//   //   _subscription = null;
//   //   // Dispose the widget itself.
//   //   super.dispose();
//   //   // Finally, dispose of the controller.
//   //   await controller.dispose();
//   // }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   // If the controller is not ready, do not try to start or stop it.
//   //   // Permission dialogs can trigger lifecycle changes before the controller is ready.
//   //   if (!controller.value.isInitialized) {
//   //     return;
//   //   }
//   //   switch (state) {
//   //     case AppLifecycleState.detached:
//   //     case AppLifecycleState.hidden:
//   //     case AppLifecycleState.paused:
//   //       return;
//   //     case AppLifecycleState.resumed:
//   //       // Restart the scanner when the app is resumed.
//   //       // Don't forget to resume listening to the barcode events.
//   //       // _subscription = controller.barcodes.listen(_handleBarcode);
//   //       unawaited(controller.start());
//   //     case AppLifecycleState.inactive:
//   //       // Stop the scanner when the app is paused.
//   //       // Also stop the barcode events subscription.
//   //       unawaited(_subscription?.cancel());
//   //       _subscription = null;
//   //       unawaited(controller.stop());
//   //   }
//   // }

//   void selectedData(capture) {
//     /// The row string scanned barcode value
//     final String? result = capture.barcodes.first.rawValue;
//     debugPrint("Barcode scanned: $result");

//     /// The `Uint8List` image is only available if `returnImage` is set to `true`.
//     final Uint8List? image = capture.image;
//     debugPrint("Barcode image: $image");

//     /// row data of the barcode
//     final Object? raw = capture.raw;
//     debugPrint("Barcode raw: $raw");

//     /// List of scanned barcodes if any
//     final List<Barcode> barcodes = capture.barcodes;
//     debugPrint("Barcode list: $barcodes");

//     if (result != null) {
//       if (result.startsWith('http') || result.startsWith('https')) {
//         _open(result);
//       } else if (result.startsWith('paste_card')) {
//         Get.toNamed('/record-work-time');
//       } else if (result.startsWith('redeem')) {
//         Get.toNamed('/coin');
//       }
//     }
//   }

//   _open(String url) async {
//     if (!await launchUrl(
//       Uri.parse(url),
//       mode: LaunchMode.inAppBrowserView,
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   // @override
//   // void reassemble() {
//   //   super.reassemble();
//   //   if (Platform.isAndroid || Platform.isIOS) {
//   //     controller!.pauseCamera();
//   //   }
//   //   controller!.resumeCamera();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return AiBarcodeScanner(
//       hideGalleryButton: true,
//       hideSheetDragHandler: true,
//       hideSheetTitle: true,
//       onDispose: () {
//         debugPrint("Barcode scanner disposed!");
//       },
//       controller: controller,
//       onDetect: (BarcodeCapture capture) {
//         Get.back();
//         selectedData(capture);
//       },
//       validator: (value) {
//         if (value.barcodes.isEmpty) {
//           return false;
//         }
//         if (!(value.barcodes.first.rawValue?.contains('flutter.dev') ??
//             false)) {
//           return false;
//         }
//         return true;
//       },
//     );
//   }
// }
