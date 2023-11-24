import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingController extends GetxController {
  void dialogLoading() {
    Future.delayed(Duration.zero, () {
      Get.dialog(
        Center(
          child: SpinKitFadingCube(
            color:Color.fromRGBO(43, 157, 145, 5),
            size: 50.0,
          ),
        ),
        barrierDismissible: false,
      );
    });
  }
}