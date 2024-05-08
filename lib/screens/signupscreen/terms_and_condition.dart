import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/features/authentication/controller/signup/signup_controller.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/constants/text_strings.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';
class TermsAndConditionCheckBox extends StatelessWidget {
  const TermsAndConditionCheckBox({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: screenWidth * 0.06, // Adjust the percentage as needed
            child: Obx(() => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
            )),
          ),
          SizedBox(width: screenWidth * 0.02), // Adjust the spacing percentage as needed
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${TTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: TTexts.privacyPolicy,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                      ),
                ),
                TextSpan(
                  text: ' ${TTexts.and}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: ' ${TTexts.termsOfUse}',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.defaultSpace),
        ],
      ),
    );
  }
}
