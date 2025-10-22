// import 'package:flutter/material.dart';
// // import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ScanPage extends StatefulWidget {
//   const ScanPage({super.key});

//   @override
//   State<ScanPage> createState() => _ScanPageState();
// }

// class _ScanPageState extends State<ScanPage> {
//   // Barcode? result;
//   // QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   String qrCode = '';

//   // void selectedData() {
//   //   if (result != null) {
//   //     if (result!.code!.startsWith('http') || result!.code!.startsWith('https')) {
//   //       _open('${result!.code}');
//   //     } else if (result!.code!.startsWith('paste_card')) {
//   //       Get.toNamed('/record-work-time');
//   //     } else if (result!.code!.startsWith('redeem')) {
//   //       Get.toNamed('/coin');
//   //     }
//   //   }
//   // }

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
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.white,
//         centerTitle: true,
//         iconTheme: const IconThemeData.fallback(),
//         automaticallyImplyLeading: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           color: Colors.white,
//           onPressed: () => Navigator.pop(context, false),
//         ),
//         title: const Text(
//           'แสกน QR Code',
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: const Stack(
//         children: <Widget>[
//           // _buildQrView(context),
//           // Center(
//           //   child: (result != null)
//           //       ? Text(
//           //           'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//           //       : Container(),
//           // ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildQrView(BuildContext context) {
//   //   var scanArea = (MediaQuery.of(context).size.width < 400 ||
//   //           MediaQuery.of(context).size.height < 400)
//   //       ? 250.0
//   //       : 350.0;
//   //   return QRView(
//   //     key: qrKey,
//   //     onQRViewCreated: _onQRViewCreated,
//   //     overlay: QrScannerOverlayShape(
//   //         borderColor: Colors.red,
//   //         borderRadius: 10,
//   //         borderLength: 30,
//   //         borderWidth: 10,
//   //         cutOutSize: scanArea),
//   //     onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//   //   );
//   // }

//   // void _onQRViewCreated(QRViewController controller) {
//   //   setState(() {
//   //     this.controller = controller;
//   //   });
//   //   controller.scannedDataStream.listen((scanData) {
//   //     setState(() {
//   //       result = scanData;
//   //       selectedData();
//   //     });
//   //   });
//   // }

//   // void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//   //   log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//   //   if (!p) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('no Permission')),
//   //     );
//   //   }
//   // }

//   // @override
//   // void dispose() {
//   //   controller?.dispose();
//   //   super.dispose();
//   // }
// }
