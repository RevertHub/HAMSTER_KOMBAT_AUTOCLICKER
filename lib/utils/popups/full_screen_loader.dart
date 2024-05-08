import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/animation_loader.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class TFullScreenLoader {
static void openLoadingDialog(String text, String animation) {
  showDialog(
    context: Get.overlayContext!,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: Container(
        color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Use Center widget to center the content vertically
            Center(
              child: TAnimationLoaderWidget(
                text: text ?? '', // Provide a default value if text is null
                animation: animation ?? '', // Provide a default value if animation is null
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

