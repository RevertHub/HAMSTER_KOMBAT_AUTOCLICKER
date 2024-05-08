import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/network_manager.dart';
import 'package:disaster_admin/common/warning_snackbar.dart';
import 'package:disaster_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:disaster_admin/data/repositories/user/user_model.dart';
import 'package:disaster_admin/data/repositories/user/user_repositiory.dart';
import 'package:disaster_admin/screens/signupscreen/verifyemail.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final bloodGroup = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();
  final city = TextEditingController();
  final street = TextEditingController();
  final eligible = 'false';

  Rx<String?> dropdownValue = Rx<String?>(null); // Rx variable to hold dropdown value
    Rx<String?> dropdownValue2 = Rx<String?>(null); // Rx variable to hold dropdown value
        Rx<String?> dropdownValue3 = Rx<String?>(null); // Rx variable to hold dropdown value





  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

    // Function to update dropdown value
  void updateDropdownValue(String value) {
    dropdownValue.value = value;
  }

      // Function to update dropdown value
  void updateDropdownValue2(String value) {
    dropdownValue2.value = value;
  }

      // Function to update dropdown value
  void updateDropdownValue3(String value) {
    dropdownValue3.value = value;
  }


  String generateRandomWord() {
  // Define the alphabet to choose from
  String alphabet = '1234567890';
  
  // Initialize a Random object
  Random random = Random();
  
  // Initialize an empty string to store the random word
  String word = '';
  
  // Generate a 5-letter word
  for (int i = 0; i < 3; i++) {
    int randomIndex = random.nextInt(alphabet.length);
    word += alphabet[randomIndex];
  }
  
  return word;
}

  @override
  void signup() async {
    try {
       String randomWord = generateRandomWord();






      TFullScreenLoader.openLoadingDialog(
          'We Are Processing Your Information...', TImages.processingAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!signUpFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In Order to create acount,you must Accept Privacy Policy & Terms and Conditions');
        return;
      }
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: firstName.text.trim() + randomWord,
        bloodGroup: dropdownValue.value!,
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        age: int.parse(age.text.trim()),
        gender: dropdownValue3.value!,
        city: dropdownValue2.value!,
        street: street.text.trim(),
        eligible: eligible,
        
      );

      final userRepository = Get.put(UserRepositiory());
      await userRepository.saveUserRecord(newUser);
      
      TFullScreenLoader.stopLoading();

      TLoaders.sucessSnackBar(
          title: "Congratulations!",
          message:
              "Your Account has been created! Verify your email to Continue.");
      Get.to(() =>  VerifyEmailScreen(
        email: email.text.trim()  ,
      ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
