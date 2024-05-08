import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disaster_admin/common/network_manager.dart';
import 'package:disaster_admin/common/warning_snackbar.dart';
import 'package:disaster_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:disaster_admin/data/repositories/user/user_model.dart';
import 'package:disaster_admin/data/repositories/user/user_repositiory.dart';
import 'package:disaster_admin/screens/loginscreen/loginscreen.dart';
import 'package:disaster_admin/screens/profilescreen/re_authenticate_user_login.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepositiory = Get.put(UserRepositiory());
  final hidePassword = true.obs;

  final imageUploading = false.obs;
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepositiory.fectchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Future<void> saveUserRecords(UserCredential? userCredential) async {
  //   try {
  //     await fetchUserRecord();
  //     if (user.value.id.isEmpty) {
  //       if (userCredential != null) {
  //         final nameParts =
  //             UserModel.nameParts(userCredential.user!.displayName ?? '');
  //         final userName = UserModel.generateUsername(
  //             userCredential.user!.displayName ?? '');

  //         final user = UserModel(
  //           id: userCredential.user!.uid,
  //           email: userCredential.user!.email ?? '',
  //           firstName: nameParts[0],
  //           lastName: nameParts.length > 1 ? nameParts.sublist(1).join('') : '',
  //           userName: userName,
  //           profilePicture: userCredential.user!.photoURL ?? '',
  //           phoneNumber: userCredential.user!.phoneNumber ?? '',
  //         );
  //         await userRepositiory.saveUserRecord(user);
  //       }
  //     }
  //   } catch (e) {
  //     TLoaders.warningSnackBar(
  //         title: 'Data Not Saved',
  //         message:
  //             'Something went wrong While Saving Data,You can re-save it from Profile');
  //   }
  // }


  Future<void> saveUserRecords(UserCredential? userCredential) async {
    try {
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          final userName = UserModel.generateUsername(
              userCredential.user!.displayName ?? '');
              String bloodGroup = 'Nill';
              int  age = 18;
              String gender = '';
              String city = '';
              String street = '';

          final user = UserModel(
            id: userCredential.user!.uid,
            email: userCredential.user!.email ?? '',
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join('') : '',
            bloodGroup: bloodGroup,
            age: age,
            gender: gender,
            city: city,
            street: street,
          
            userName: userName,
            profilePicture: userCredential.user!.photoURL ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            eligible: 'false'
          );
          await userRepositiory.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data Not Saved',
          message:
              'Something went wrong While Saving Data,You can re-save it from Profile');
    }
  }

  void deleteAccountWarningPopUp() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account?',
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAcount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red, width: 2)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete'),
          ),
        ),
        cancel: OutlinedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ));
  }

  void deleteUserAcount() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing', TImages.processingAnimation);

      final auth = AuthenticationRepository.instance;

      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const Loginscreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing', TImages.processingAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const Loginscreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepositiory.uploadImage('Users/Images/Profile/', image);
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepositiory.updateSingleField(json);
        user.value.profilePicture = imageUrl;
        TLoaders.sucessSnackBar(
            title: 'Congragulations',
            message: 'Profile Picture Updated Successfully');
        user.refresh();
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Something went wrong, Please try again later.');
    } finally {
      imageUploading.value = false;
    }
  }
}
