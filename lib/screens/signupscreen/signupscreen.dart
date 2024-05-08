import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/screens/loginscreen/loginscreen.dart';
import 'package:disaster_admin/screens/signupscreen/signup_form.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/constants/text_strings.dart';

class SignUpscreen extends StatelessWidget {
  const SignUpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    TTexts.signupTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                const SignUpFormFeild(),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                TFormDivider(
                  dividerText: TTexts.signupTitle.capitalize!,
                ),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                const SocialButton()
              ],
            )),
      ),
    );
  }
}
