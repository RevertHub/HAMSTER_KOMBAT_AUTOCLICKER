import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_admin/screens/profilescreen/address/add_new_address.dart';
import 'package:disaster_admin/screens/profilescreen/address/widgets/address_controller.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(UserAddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showbackarrow: true,
        title: Text(
          "Address",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final List<Map<String, dynamic>> userAddresses =
            controller.userAddresses.toList();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: userAddresses.asMap().entries.map((entry) {
                final index = entry.key;
                final address = entry.value;
                return GestureDetector(
                  onTap: () {
                     Navigator.pop(
    context,
    {
      'fullName': address['FullName'],
      'phoneNumber': address['PhoneNumber'],
      'street': address['Street'],
      'city': address['City'],
      'country': address['Country'],
    },
  );
                    controller.setDefaultAddress(index);
                  },
                  child: TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.md),
                    width: double.infinity,
                    showBorder: true,
                    backgroundColor:
                        controller.defaultAddressIndex.value == index
                            ? TColors.primary.withOpacity(0.5)
                            : Colors.transparent,
                    borderColor:
                        controller.defaultAddressIndex.value == index
                            ? Colors.transparent
                            : dark
                                ? TColors.darkerGrey
                                : TColors.grey,
                    margin: const EdgeInsets.only(
                        bottom: TSizes.spaceBtwItems),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address['FullName'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(
                                        height: TSizes.sm / 2,
                                      ),
                                      Text(
                                        address['PhoneNumber'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${address['Street']}, ${address['City']}, ${address['Country']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                      const SizedBox(
                                        height: TSizes.sm / 2,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Show delete confirmation dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Deletion"),
                                          content: const Text(
                                              "Are you sure you want to delete this address?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(false);
                                              },
                                              child: const Text("No"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller.deleteAddress(index);
                                                Navigator.of(context).pop(true);
                                              },
                                              child: const Text("Yes"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Iconsax.trash,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
