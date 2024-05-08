import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:disaster_admin/features/authentication/controller/signup/verify_email_controller.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/constants/text_strings.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email ;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put( VerifyEmailController());
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Get.offAll(() => AuthenticationRepository.instance.logOut()),
                icon: const Icon(Icons.clear))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Image(
                  image: const AssetImage(TImages.deliveredEmailIllustration),
                  width: THelperFunctions.screenWidth() * 0.6,
                ),
              const  SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
               const SizedBox(height: TSizes.spaceBtwItems),
                Text(email??'',style:  Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwItems),
                  Text(
                  TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                SizedBox( width: double.infinity, child: ElevatedButton( onPressed: () =>  Get.to(() =>  controller.checkEmailVerificationStatus()),  child: const Text( TTexts.tContinue),),),
                const SizedBox(height: TSizes.spaceBtwItems),
                                SizedBox( width: double.infinity, child: TextButton( onPressed: ()=> controller.sendEmailVerification(),child: const Text( TTexts.resendEmail),),),],
            ),
          ),
        ));
  }
}
