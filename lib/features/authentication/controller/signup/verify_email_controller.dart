import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/success_screen/sucess_screen.dart';
import 'package:disaster_admin/common/warning_snackbar.dart';
import 'package:disaster_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.sucessSnackBar(
          title: 'Email Sent',
          message: 'Verification Email has been sent to your email address');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SucessScreen(
            image: TImages.succuessfullyRegisterAnimation,
            title: TTexts.yourAccountCreatedTitle,
            subTitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }
  checkEmailVerificationStatus()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null&& currentUser.emailVerified){
      Get.off(()=> SucessScreen(image: TImages.succuessfullyRegisterAnimation, title: TTexts.yourAccountCreatedTitle, subTitle:  TTexts.yourAccountCreatedSubTitle, onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
