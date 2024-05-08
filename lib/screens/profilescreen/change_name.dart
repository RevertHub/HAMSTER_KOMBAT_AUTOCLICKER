import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/screens/profilescreen/update_name_controller.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/constants/text_strings.dart';
import 'package:disaster_admin/utils/validators/validation.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return  Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title:  Text('Change Name',
        style:  Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(padding:const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text('Use Reak Name for easy verifcation.This name will be visible to all users',
        style:  Theme.of(context).textTheme.labelMedium,),
        const SizedBox(height: TSizes.spaceBtwSections),
        Form(
          key: controller.updateNameFormKey ,
          child: Column(
            children: [
        TextFormField(
          controller: controller.firstName,
          validator: (value)=> TValidator.validateEmptyText('First Name', value),
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.firstName,
            prefixIcon: Icon(Iconsax.user),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        TextFormField(
          controller: controller.lastName,
          validator: (value)=> TValidator.validateEmptyText('Last Name', value),
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.lastName,
            prefixIcon: Icon(Iconsax.user),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        TextFormField(
          controller: controller.phoneNumber,
          validator: (value)=> TValidator.validateEmptyText('Phone Number', value),
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.phoneNo,
            prefixIcon: Icon(Iconsax.user),
          ),
        ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
        TextFormField(
          controller: controller.age,
          validator: (value)=> TValidator.validateEmptyText('Age', value),
          expands: false,
          decoration: const InputDecoration(
            labelText: 'Age',
            prefixIcon: Icon(Iconsax.user),
          ),
        ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
        TextFormField(
          controller: controller.bloodGroup,
          validator: (value)=> TValidator.validateEmptyText('', value),
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.bloodGroup,
            prefixIcon: Icon(Iconsax.user),
          ),
        ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
        TextFormField(
          controller: controller.street,
          validator: (value)=> TValidator.validateEmptyText('', value),
          expands: false,
          decoration: const InputDecoration(
            labelText: 'Street',
            prefixIcon: Icon(Iconsax.user),
          ),
        ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
          controller: controller.city,
          validator: (value)=> TValidator.validateEmptyText('', value),
          expands: false,
          decoration: const InputDecoration(
            labelText: 'Street',
            prefixIcon: Icon(Iconsax.user),
          ),
        )
            ],
          )),
          const SizedBox(height: TSizes.spaceBtwSections),
        
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
        onPressed: ()=> controller.updateUserName(),
        child: const Text('Save'),
            ),
          )
          ],
        ),
        ),
      ),
    );
  }
}