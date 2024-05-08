import 'package:disaster_admin/screens/alert_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/common/shimmer_effect.dart';
import 'package:disaster_admin/features/personalization/controllers/user_controller.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    this.message = '',
    super.key,
  });
final String message;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      actions: [
        TCardCounterWidget(
          onPressed: () {},
          iconColor: TColors.white,
        )
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
          message,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Obx(
            (){
              if(controller.profileLoading.value){
                return const TshimmerEffect( height: 80, width: 15,);
              }
               return Text(
              controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white),
            );},
          )
        ],
      ),
    );
  }
}

class TCardCounterWidget extends StatelessWidget {
  const TCardCounterWidget({
    super.key,
    required this.onPressed,
     this.iconColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(()=> const AppNotificationsScreen()),
            icon: Icon(
              Iconsax.message_text,
              color: dark?TColors.white: const Color.fromARGB(255, 255, 253, 253),
              size: 20,
            )),
       
      ],
    );
  }
}
