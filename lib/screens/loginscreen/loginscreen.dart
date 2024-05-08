
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/style/spacing_style.dart';
import 'package:disaster_admin/features/authentication/controller/signup/login/login_controller.dart';
import 'package:disaster_admin/screens/loginscreen/login_form.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

import '../../utils/constants/text_strings.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const TLoginHeader(),
             const TLoginForm(),
             TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwItems),
              const SocialButton()
              
              
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: TColors.grey),
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                            onPressed: () => controller.googleSignIn(),
                            icon: const Image(
                                width: TSizes.iconMd,
                                height: TSizes.iconMd,
                                image: AssetImage(
                                  TImages.google,
                                ))),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      )
                    ],
                  ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                            width: TSizes.iconMd,
                            height: TSizes.iconMd,
                            image: AssetImage(TImages.facebook))),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  )
                ],
              )
                ],
              );
  }
}

class TFormDivider extends StatelessWidget {
  const TFormDivider({super.key, required this.dividerText});
final String dividerText;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? TColors.darkGrey : TColors.grey,
                      indent: 60,
                      endIndent: 5,
                      thickness: 0.5,
                    ),
                  ),
                  Text(
                    TTexts.orSignInWith.capitalize!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Flexible(
                    child: Divider(
                      color: dark ? TColors.darkGrey : TColors.grey,
                      indent: 5,
                      endIndent: 60,
                      thickness: 0.5,
                    ),
                  )
                ],
              );


  }
}


class TLoginHeader extends StatelessWidget {
  const TLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                  ),
                  // Image(
                  //   height: 150,
                  //   image: AssetImage(
                  //       dark ? TImages.lightAppLogo : TImages.darkAppLogo),
                  // ),
                  Text(TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.sm),
                  Text(TTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              );
  }
}
