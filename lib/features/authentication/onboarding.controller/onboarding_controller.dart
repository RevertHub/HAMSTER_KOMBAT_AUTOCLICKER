import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:disaster_admin/screens/loginscreen/loginscreen.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> curentPage = 0.obs;

  void updatePageIndicator(index) => curentPage.value = index;

  void dotNavigationClick(index) {
    curentPage.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (curentPage.value == 2) {
      final Storage = GetStorage();

      if (kDebugMode) {
        print("================GET STORAGE NExt Button =====================");
        print(Storage.read('isFirstTime'));
      }
      Storage.writeIfNull('isFirstTime', false);
      Get.offAll(const Loginscreen());
    } else {
      int index = curentPage.value + 1;
      pageController.jumpToPage(index);
    }
  }

  void skipPage() {
    curentPage.value = 2;
    pageController.jumpTo(2);
  }
}
