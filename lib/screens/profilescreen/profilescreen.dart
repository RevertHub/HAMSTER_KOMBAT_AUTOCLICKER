import 'package:disaster_admin/screens/settings/widgets/settingswidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/common/shimmer_effect.dart';
import 'package:disaster_admin/common/style/section_heading.dart';
import 'package:disaster_admin/screens/profilescreen/change_name.dart';
import 'package:disaster_admin/screens/profilescreen/profile_menu.dart';
import 'package:disaster_admin/features/personalization/controllers/user_controller.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const TAppBar(
        showbackarrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty ? networkImage: TImages.user;
                    return controller.imageUploading.value? const TshimmerEffect(height: 80, width: 80,radius: 80,): TCircularImage(
                      image:image,
                      width: 80,
                      height: 80,
                      isNetworkImage: networkImage.isNotEmpty,
                    );
                  }),
                  TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text(
                        "Change Profile Picture",
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            const Divider(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const TSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TProfileMenu(
              title: "Name",
              value: controller.user.value.fullName,
              onPressed: () => Get.to(() => const ChangeName()),
            ),
            TProfileMenu(
              title: "Username",
              value: controller.user.value.userName,
              onPressed: () {},
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const Divider(),
            const TSectionHeading(
                title: "Personal Information", showActionButton: false),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TProfileMenu(
                title: "User ID",
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {}),
            TProfileMenu(
                title: "E-Mail",
                value: controller.user.value.email,
                onPressed: () {}),
            TProfileMenu(
                title: "Phone Number",
                value: controller.user.value.phoneNumber,
                             onPressed: () => Get.to(() => const ChangeName()),
),
                 TProfileMenu(
                title: "Blood Group",
                value: controller.user.value.bloodGroup,
                             onPressed: () => Get.to(() => const ChangeName()),
),
                  TProfileMenu(
                title: "Age",
                value: controller.user.value.age.toString(),
                           onPressed: () => Get.to(() => const ChangeName()),
),
                    TProfileMenu(
                title: "Street",
                value: controller.user.value.street,
                           onPressed: () => Get.to(() => const ChangeName()),
),
                  TProfileMenu(
                title: "City",
                value: controller.user.value.city,
                        onPressed: () => Get.to(() => const ChangeName()),
),
          

           
           
            const Divider(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
              child: OutlinedButton(
                  onPressed: () => controller.deleteAccountWarningPopUp(),
                  child: const Text(
                    "Close Account",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
