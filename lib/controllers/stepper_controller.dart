import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExampleNotifier extends GetxController {
  TextEditingController controller = TextEditingController();

  RxInt currentStep = 0.obs;

  void updateStep(int index) {
    currentStep.value = index;
  }

  void nextStep() {
    if (currentStep < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep.value--;
    }
  }
}
