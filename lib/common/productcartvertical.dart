import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/productcardvertical_controller.dart';
import 'package:disaster_admin/common/shadow.dart';
import 'package:disaster_admin/common/shapes/t_circular_icon.dart';
import 'package:disaster_admin/common/style/product_price.dart';
import 'package:disaster_admin/common/style/product_title_text.dart';
import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/enums.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class TProductCartVertical extends StatelessWidget {
  const TProductCartVertical({Key? key, this.index = 0}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final ProductcardverticalController controller =
        Get.find<ProductcardverticalController>();
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const ()),
      child: Obx(() {
        if (controller.isLoading.value) {
          // Return a loading indicator if data is still loading
          return const CircularProgressIndicator();
        } else if (controller.productDataList.isEmpty ||
            controller.productDataList.length <= index) {
          // Handle cases where product data is not available or index is out of range
          return Container(); // Return an empty container or a placeholder widget
        } else {
          // Return the actual product data
          return Container(
            width: 180,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              boxShadow: [TshadowStyle.verticalProductShadow],
              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              color: dark ? TColors.darkerGrey : TColors.white,
            ),
            child: Column(
              children: [
                TRoundedContainer(
                  height: 180,
                  padding: const EdgeInsets.all(TSizes.sm),
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  child: Stack(
                    children: [
                      TRoundedImage(
                        isNetworkImage: true,
                        imageUrl:
                            controller.productDataList[index]['productImage'],
                        applyImageRadius: true,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 12,
                        child: TRoundedContainer(
                          radius: TSizes.md,
                          backgroundColor:
                              TColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm,
                            vertical: TSizes.xs,
                          ),
                          child: Text(
                            '25%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: TColors.black),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        child: TCircularIcon(
                          icon: Iconsax.heart5,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(
                        title: controller.productDataList[index]
                            ['productName'],
                        smallSize: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Column(
                        children: [
                          TBRandTitleWithVerificationICon(
                            title: controller.productDataList[index]
                                ['UserName'],
                            brandTextSize: TextSizes.small,
                            maxLines: 1,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: TSizes.sm),
                      child: TProductPRice(
                        price: controller.productDataList[index]
                            ['productPrice'],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: TColors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(TSizes.productImageRadius),
                        ),
                      ),
                      child: const SizedBox(
                        height: TSizes.iconLg * 1.2,
                        width: TSizes.iconLg * 1.2,
                        child: Center(
                          child: Icon(
                            Iconsax.add,
                            color: TColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}


class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({
    super.key,
    required this.title,
    this.color,
    this.maxLines = 1,
    this.brandTextSize = TextSizes.small,
    this.textAlign = TextAlign.center,
  });
  final String title;
  final Color? color;
  final int maxLines;
  final TextSizes brandTextSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.medium
              ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
              : brandTextSize == TextSizes.large
                  ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
                  : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}

class TBRandTitleWithVerificationICon extends StatelessWidget {
  const TBRandTitleWithVerificationICon(
      {super.key,
      required this.title,
      this.maxLines = 1,
      this.textColor,
      this.iconColor = TColors.primary,
      this.textAlign = TextAlign.center,
      this.brandTextSize = TextSizes.small});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: TBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
          
        )),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: TSizes.iconXs,
        )
      ],
    );
  }
}
