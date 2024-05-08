import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/screens/profilescreen/address/widgets/address_add_controller.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressAddController());

    return Scaffold(
      appBar: const TAppBar(
        title: Text("Add New Address"),
        showbackarrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
              key: controller.addressFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.fullName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Full Name', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user), labelText: 'Full Name'),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    validator: (value) =>
                        TValidator.validateEmptyText('Phone Number', value),
                    controller: controller.phoneNumber,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: 'Phone Number'),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              TValidator.validateEmptyText('Street', value),
                          controller: controller.street,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building_31),
                              labelText: 'Street'),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.postalCode,
                          validator: (value) => TValidator.validateEmptyText(
                              'Postal Code', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.code),
                              labelText: 'Postal Code'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              TValidator.validateEmptyText('City', value),
                          controller: controller.city,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building),
                              labelText: 'City'),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              TValidator.validateEmptyText('State', value),
                          controller: controller.state,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              labelText: 'State'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.country,
                    validator: (value) =>
                        TValidator.validateEmptyText('Country', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                  ),
                  const SizedBox(
                    height: TSizes.defaultSpace,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller
                              .addUserAddress(); // Call the addUserAddress method
                        },
                        child: const Text("Save"),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
