import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:organics_salary/theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CoinScanPage extends StatefulWidget {
  const CoinScanPage({super.key});

  @override
  State<CoinScanPage> createState() => _CoinScanPageState();
}

class _CoinScanPageState extends State<CoinScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(flex: 8, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Material(
                          color: Colors.transparent,
                          child: Center(
                            child: Ink(
                              decoration: const ShapeDecoration(
                                color: AppTheme.ognGreen,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  await controller?.flipCamera();
                                  setState(() {});
                                },
                                color: Colors.white,
                                icon: describeEnum(snapshot.data!) == 'back'
                                    ? Icon(Icons.camera_rear_rounded)
                                    : Icon(Icons.camera_front_rounded),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Text('loading');
                      }
                    },
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Material(
                        color: Colors.transparent,
                        child: Center(
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: AppTheme.ognGreen,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              color: Colors.white,
                              icon: snapshot.data == true
                                  ? Icon(Icons.flash_off_rounded)
                                  : Icon(Icons.flash_auto_outlined),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
