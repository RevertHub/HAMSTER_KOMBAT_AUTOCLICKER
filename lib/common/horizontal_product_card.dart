import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/common/product_cart_controller.dart';
import 'package:disaster_admin/common/productcartvertical.dart';
import 'package:disaster_admin/common/shadow.dart';
import 'package:disaster_admin/common/shapes/TGrid_Layout.dart';
import 'package:disaster_admin/common/shimmer_effect.dart';
import 'package:disaster_admin/common/style/product_price.dart';
import 'package:disaster_admin/common/style/product_title_text.dart';
import 'package:disaster_admin/screens/homescreens/widget/addtocart.dart';
import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/enums.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class ProductCarty extends StatelessWidget {
  const ProductCarty({super.key});

  @override
  Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductCartYController());
    return Scaffold(
      appBar: const TAppBar(
        showbackarrow: true,
        title:  Text(
          'Your Cart Items',
        ),
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
              Obx(
              (){ if (controller.isLoading.value) {
                // Return a loading indicator if data is still loading
                return const Center(child: TshimmerEffect(
                  height: 180,
                  width: 180,
                ));
              } else {
                return  TGridLayout(
              itemCount: controller.productDataList.length,
              itemBuilder: (_, index) =>  GestureDetector(
                onTap: () => Get.to(() =>  Addtocart(
                  productId: controller.productDataList[index]['productId'],
                  image: controller.productDataList[index]['image'],
                  productPrice: controller.productDataList[index]['productPrice'],
                  productName: controller.productDataList[index]['productName'],
                  sellerName: controller.productDataList[index]['sellerName'],
                  productCategory: controller.productDataList[index]['productCategory'],
                  productDescription: controller.productDataList[index]['productDescription'],
                  productQuantity: controller.productDataList[index]['productQuantity'],
                  discount: controller.productDataList[index]['discount'],
                    
                    
                    
                )),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    // Return a loading indicator if data is still loading
                    return const TshimmerEffect(
                  height: 180,
                  width: 180,
                );
                  } else if (controller.productDataList.isEmpty ||
                      controller.productDataList.length <= index) {
                    // Handle cases where product data is not available or index is out of range
                    return const TshimmerEffect(
                  height: 180,
                  width: 180,
                ); // Return an empty container or a placeholder widget
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
                                      controller.productDataList[index]['image'],
                                  applyImageRadius: true,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 12,
                                  child: TRoundedContainer(
                                    radius: TSizes.md,
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 213, 0).withOpacity(0.8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.sm,
                                      vertical: TSizes.xs,
                                    ),
                                    child: Text(
                                                                  '${controller.productDataList[index]['discount']}%',
                    
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .apply(color: TColors.black),
                                    ),
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
                                          ['sellerName'],
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
              ),
              );
              }}),
            ],
        ),
      ),
    );
  }
}