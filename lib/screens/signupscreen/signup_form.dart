import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/features/authentication/controller/signup/signup_controller.dart';
import 'package:disaster_admin/screens/signupscreen/terms_and_condition.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/constants/text_strings.dart';
import 'package:disaster_admin/utils/validators/validation.dart';

class SignUpFormFeild extends StatelessWidget {
  const SignUpFormFeild({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signUpFormKey,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value)=>TValidator.validateEmptyText('First Name', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                                validator: (value)=>TValidator.validateEmptyText('Last Name', value),

                controller: controller.lastName,
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.lastName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            )
          ],
        ),
     
      
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        // TextFormField(
        //   controller: controller.bloodGroup,
        //                   validator: (value)=>TValidator.validateEmptyText('BloodGroup', value),

        //   expands: false,
        //   decoration: const InputDecoration(
        //     labelText: TTexts.bloodGroup,
        //     prefixIcon: Icon(Icons.bloodtype),
        //   ),
        // ),
           DropdownButtonFormField(
                        hint: const Text('Select Blood Group'),
                        value: controller.dropdownValue.value,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.sort),
                        ),
                        onChanged: (value) {
                          controller.updateDropdownValue(
                            value.toString(),
                          ); // Update dropdown value
                        },
                        items: [
                          'A+',
                          'A-',
                          'B+',
                          'B-',
                          'AB+',
                          'AB-',
                          'O+',
                          'O-',
                        ].map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
         const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
          Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              TValidator.validateEmptyText('Age', value),
                          controller: controller.age,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.calendar),
                              labelText: 'Age'),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child:  DropdownButtonFormField(
                        hint: const Text('Gender'),
                        value: controller.dropdownValue3.value,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.sort),
                        ),
                        onChanged: (value) {
                          controller.updateDropdownValue3(
                            value.toString(),
                          ); // Update dropdown value
                        },
                        items: [
                          'Male',
                          'Female'
                        
                        ].map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  DropdownButtonFormField(
                  hint: const Text('City',
                  overflow: TextOverflow.ellipsis,
                  ),
                  value: controller.dropdownValue2.value,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.sort),
                  ),
                  onChanged: (value) {
                    controller.updateDropdownValue2(
                      value.toString(),
                    ); // Update dropdown value
                  },
                  items: [
                    'Alappuzha',
                    'Ernakulam',
                    'Idukki',
                    'Kannur',
                    'Kasaragod',
                    'Kollam',
                    'Kottayam',
                    'Kozhikode',
                    'Malappuram',
                    'Palakkad',
                    'Pathanamthitta',
                    'Thiruvananthapuram',
                    'Thrissur',
                    'Wayanad',
                     
                  ].map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                                        ),
                                        const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                                        ),
                                        TextFormField(
                                          validator: (value) =>
                                              TValidator.validateEmptyText('Street', value),
                                          controller: controller.street,
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Iconsax.activity),
                                              labelText: 'Street'),
                                        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                          validator: (value)=>TValidator.validateEmail( value),

          controller: controller.email,
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.email,
            prefixIcon: Icon(Iconsax.direct),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                                    validator: (value)=>TValidator.validatePhoneNumber( value),

          controller: controller.phoneNumber,
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.phoneNo,
            prefixIcon: Icon(Iconsax.call),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
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
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        const TermsAndConditionCheckBox(),
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: ()  => controller.signup(),
            child: const Text(TTexts.createAccount),
          ),
        ),
      ],
    ));
  }
}
