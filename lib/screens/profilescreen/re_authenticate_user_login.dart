
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/features/personalization/controllers/user_controller.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/constants/text_strings.dart';
import 'package:disaster_admin/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =UserController.instance;
    return  Scaffold(
      appBar: const TAppBar(
        title: Text("Re-Authenticate User"),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: 
        const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          
          key:  controller.reAuthFormKey,
          child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
  TextFormField(
    controller: controller.verifyEmail,
    validator: TValidator.validateEmail,
    decoration: const InputDecoration(
    prefixIcon: Icon(Iconsax.direct_right),
      labelText: TTexts.email,
    ),
  ),
  const SizedBox(height: TSizes.spaceBtwInputFields),

   Obx(
     ()=> TextFormField(
      obscureText: controller.hidePassword.value,
      controller: controller.verifyPassword,
      validator:(value)=> TValidator.validateEmptyText('Password', value),
      decoration:  InputDecoration(
      prefixIcon: const Icon(Iconsax.password_check),
      suffixIcon: IconButton(onPressed:()=> controller.hidePassword.value = !controller.hidePassword.value,
      icon: const Icon(Iconsax.eye_slash)),
        labelText: TTexts.password,
      ),
       ),
   ),
   const SizedBox(height: TSizes.spaceBtwSections),
   SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => controller.reAuthenticateEmailAndPassword(),
      child: const Text("Verify"),
    ),
   )
],
        )),)
      ),
    );
  }
}