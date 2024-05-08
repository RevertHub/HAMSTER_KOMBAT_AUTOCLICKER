 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';


class TLoaders{


static hideSnckBar()=> ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

static coustomToast({required messsage}){
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      
      content: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: THelperFunctions.isDarkMode(Get.context!)? TColors.darkerGrey.withOpacity(0.9): TColors.grey.withOpacity(0.9),
        ),
        child:  Center(child: Text(messsage,style: Theme.of(Get.context!).textTheme.labelLarge),
      ))
  ));
}







static warningSnackBar({
  required String title,
   message = '',
  duration =3
}) {
  Get.snackbar(
    title,
    message,
  isDismissible: true,
  shouldIconPulse: true,
  backgroundColor: Colors.orange,
  colorText: TColors.white,
  snackPosition: SnackPosition.BOTTOM,
  duration: Duration(seconds: duration),
  margin: const EdgeInsets.all(20),
  icon: const Icon(Iconsax.warning_2,color: TColors.white,)
  );
}


static errorSnackBar({
  required String title,
   message = '',
 
}) {
  Get.snackbar(
    title,
    message,
  isDismissible: true,
  shouldIconPulse: true,
  backgroundColor: Colors.red.shade600,
  colorText: TColors.white,
  snackPosition: SnackPosition.BOTTOM,
  duration: const Duration(seconds: 3),
  margin: const EdgeInsets.all(20),
  icon: const Icon(Iconsax.warning_2,color: TColors.white,)
  );
}


static sucessSnackBar({
  required String title,
   message = '',
  duration =3
 
}) {
  Get.snackbar(
    title,
    message,
  isDismissible: true,
  shouldIconPulse: true,
  backgroundColor: TColors.primary,
  colorText: TColors.white,
  snackPosition: SnackPosition.BOTTOM,
  duration: Duration(seconds: duration),
  margin: const EdgeInsets.all(10),
  icon: const Icon(Iconsax.warning_2,color: TColors.white,)
  );
}

}