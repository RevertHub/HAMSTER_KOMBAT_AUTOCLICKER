import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/network_manager.dart';
import 'package:disaster_admin/common/warning_snackbar.dart';
import 'package:disaster_admin/data/repositories/user/user_repositiory.dart';
import 'package:disaster_admin/screens/profilescreen/profilescreen.dart';
import 'package:disaster_admin/features/personalization/controllers/user_controller.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get  instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final age = TextEditingController();
  final city = TextEditingController();
  final bloodGroup = TextEditingController();
  final street = TextEditingController();
  final userController = UserController.instance;
  final userReporsiory = Get.put(UserRepositiory());
  final GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();


@override
void onInit() {
  super.onInit();
initializeNames();
}

Future<void> initializeNames()async{
  firstName.text = userController.user.value.firstName;
  lastName.text = userController.user.value.lastName;
  phoneNumber.text = userController.user.value.phoneNumber;
  age.text = userController.user.value.age.toString();
  city.text = userController.user.value.city;
  bloodGroup.text = userController.user.value.bloodGroup;
  street.text = userController.user.value.street;

}

Future<void> updateUserName() async{
try{
   TFullScreenLoader.openLoadingDialog('We Are Updating Your Information', TImages.processingAnimation);

   final isConnected = await NetworkManager.instance.isConnected();

   if (!isConnected) {
     TFullScreenLoader.stopLoading();
     return;
   }
   if (!updateNameFormKey.currentState!.validate()) {
     TFullScreenLoader.stopLoading();
     return;
   }

   Map<String, dynamic> name = {
     'FirstName': firstName.text.trim(),
     'LastName': lastName.text.trim(),
     'PhoneNumber': phoneNumber.text.trim(),
      'Age': int.parse(age.text.trim()),
      'City': city.text.trim(),
      'BloodGroup': bloodGroup.text.trim(),
      'Street': street.text.trim(),
      

   };

   await userReporsiory.updateSingleField(name);


   userController.user.value.firstName = firstName.text.trim();
    userController.user.value.lastName = lastName.text.trim();

    TFullScreenLoader.stopLoading();
    TLoaders.sucessSnackBar(title: 'Congratulations', message: 'Your Name Has Been Updated');
    Get.off(()=>const ProfileScreen()); 
}catch(e){
  TFullScreenLoader.stopLoading();
  TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Your Name Could Not Be Updated');
}
}
}