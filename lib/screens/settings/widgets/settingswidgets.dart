
import 'package:cached_network_image/cached_network_image.dart';
import 'package:disaster_admin/common/shimmer_effect.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/features/personalization/controllers/user_controller.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';


class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed,
  });

final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
 leading: const TCircularImage(
       width: 50,
       height: 50,
       padding: 0,
       image: TImages.user,
       ),
       title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
     subtitle: Text(controller.user.value.email, 
     maxLines: 1,
      overflow: TextOverflow.ellipsis,
     style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
     trailing:  IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,color: TColors.white,)),
                  );
                  
  }
}

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.height = 56,
    this.width = 56,
    this.padding = TSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double height, width, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.light,
        borderRadius: BorderRadius.circular(100),
      ),
      child:ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
        child:   isNetworkImage?
          CachedNetworkImage(imageUrl: image,fit: fit,
          color: overlayColor,
          progressIndicatorBuilder: (context,url,downloadProgress) => const TshimmerEffect(height: 55, width: 55),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          ):
         Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(image)
                : AssetImage(image) as ImageProvider,
            color: overlayColor),
             ),
      ) );
  }
}
