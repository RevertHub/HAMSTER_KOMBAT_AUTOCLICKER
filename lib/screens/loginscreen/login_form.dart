
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/features/authentication/controller/signup/login/login_controller.dart';
import 'package:disaster_admin/screens/loginscreen/password_configuration/forget_password.dart';
import 'package:disaster_admin/utils/validators/validation.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';

import '../../utils/constants/text_strings.dart';
import '../signupscreen/signupscreen.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return  Form(
              key: controller.loginformKey,
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.spaceBtwSections),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                                            validator: (value)=> TValidator.validateEmail(value),

                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: TTexts.email,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                     Obx(
          ()=> TextFormField(
            controller: controller.password,
                                      validator: (value)=>TValidator.validatePassword( value),
          
            expands: false,
            obscureText: controller.hidePassword.value,
            decoration:  InputDecoration(
              labelText: TTexts.password,
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(onPressed: ()=> controller.hidePassword.value =!controller.hidePassword.value, icon:  Icon(controller.hidePassword.value? Iconsax.eye_slash: Iconsax.eye)),
              
            ),
          ),
        ),
                   
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                            const Text(TTexts.rememberMe)
                          ],
                        ),
                        TextButton(
                          onPressed: ()  => Get.to(() =>  const ForgetPassword()),
                          child: const Text(TTexts.forgetPassword),
                        )
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.emailandPasswordSignIn(),
                        child: const Text(TTexts.signIn),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Get.to (() => const SignUpscreen()),
                        child: const Text(TTexts.createAccount),
                      ),
                    ),
                  ],
                ),
              ));
  }
}