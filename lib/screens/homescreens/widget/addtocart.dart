import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_admin/screens/settings/widgets/settingswidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:disaster_admin/common/productcartvertical.dart';
import 'package:disaster_admin/common/shapes/t_circular_icon.dart';
import 'package:disaster_admin/common/style/product_price.dart';
import 'package:disaster_admin/common/style/product_title_text.dart';
import 'package:disaster_admin/screens/homescreens/widget/checkout_pro.dart';
import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:get/get.dart';

import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/enums.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

class Addtocart extends StatelessWidget {
  const Addtocart({
    Key? key,
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productQuantity,
    required this.sellerName,
    required this.discount,
    required this.productId,

  }) : super(key: key);
final String productId;
  final String image;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final int productQuantity;
  final String sellerName;
  final int discount;

  @override
  Widget build(BuildContext context) {
final dark = THelperFunctions.isDarkMode(context);
    int discountedPrice = productPrice - ((productPrice * discount) ~/ 100);
    final CounterController counterController = Get.put(CounterController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
         
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  // const TRatingAndShare(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TRoundedContainer(
                            radius: TSizes.sm,
                            backgroundColor:
                                TColors.secondary.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.sm, vertical: TSizes.sm),
                            child: Text('$discount %',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(
                                      color: TColors.black,
                                    )),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text('RS: $productPrice',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(
                                      decoration:
                                          TextDecoration.lineThrough)),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          TProductPRice(
                            price: discountedPrice,
                            islarge: true,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),
                      TProductTitleText(title: productName),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Status'),
                          const SizedBox(
                            width: TSizes.spaceBtwItems / 1.5,
                          ),
                          Text("In Stock $productQuantity",
                              style: Theme.of(context).textTheme.titleMedium!),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 1.5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),
                      Row(
                        children: [
                        const  TCircularImage(
                            image: TImages.user,
                            width: 32,
                            height: 32,
                           fit: BoxFit.contain,
                          ),
                          TBRandTitleWithVerificationICon(
                            title: sellerName,
                            brandTextSize: TextSizes.medium,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.defaultSpace,
                            vertical: TSizes.defaultSpace / 2),
                        decoration: BoxDecoration(
                          color: dark ? TColors.darkerGrey : TColors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusLg),
                              topRight: Radius.circular(TSizes.cardRadiusLg),
                              bottomLeft: Radius.circular(TSizes.cardRadiusLg),
                              bottomRight: Radius.circular(TSizes.cardRadiusLg),)
                        ),
                        child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TCircularIcon(
                                      icon: Iconsax.minus,
                                      backgroundColor: TColors.darkGrey,
                                      width: 40,
                                      height: 40,
                                      color: TColors.white,
                                      onPressed: () =>
                                          counterController.decrement(),
                                    ),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems,
                                    ),
                                    Text(counterController.counter.value.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems,
                                    ),
                                    TCircularIcon(
                                      icon: Iconsax.add,
                                      backgroundColor: TColors.black,
                                      width: 40,
                                      height: 40,
                                      color: TColors.white,
                                      onPressed: () =>
                                          counterController.increment(),
                                    ),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems,
                                    ),
                                    const TProductTitleText(
                                      title: 'Total : ',
                                    ),
                                    TProductPRice(
                                      price: counterController.counter.value != 0
                                          ? discountedPrice * counterController.counter.value
                                          : discountedPrice,
                                      islarge: true,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {

addToCart(productId: productId, image: image, productName: productName, productPrice: productPrice, productDescription: productDescription, productCategory: productCategory, productQuantity: productQuantity, sellerName: sellerName, discount: discount, selectedQuantity: counterController.counter.value,);
                            Get.to(() =>  CheckoutScreenMain(
                              productId: productId,
                              image: image,
                              productName: productName,
                              productPrice: productPrice,
                              productDescription: productDescription,
                              productCategory: productCategory,
                              productQuantity: productQuantity,
                              sellerName: sellerName,
                              discount: discount,
                              selectedQuantity: counterController.counter.value,
                                
                            ));
                          }, child: const Text("Purchase Now"))),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                   ReadMoreText(
                    productDescription,
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimCollapsedText: 'Show More',
                    trimExpandedText: 'Show Less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  // Function to add the product details to the cart in Firestore
  void addToCart({
  required String productId,
  required String image,
  required String productName,
  required int productPrice,
  required String productDescription,
  required String productCategory,
  required int productQuantity,
  required String sellerName,
  required int discount,
  required int selectedQuantity,
}) {
  // Get the current user's ID (You'll need to implement your own authentication logic)
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // Reference to the Firestore collection 'cart' for the user
  CollectionReference cartCollection = FirebaseFirestore.instance
      .collection('Cart')
      .doc(userId)
      .collection('Cart_Items');

  // Add the product details to the cart with productId as the document name
  cartCollection.doc(productId).set({
    'productId': productId,
    'image': image,
    'productName': productName,
    'productPrice': productPrice,
    'productDescription': productDescription,
    'productCategory': productCategory,
    'productQuantity': productQuantity,
    'sellerName': sellerName,
    'discount': discount,
    'selectedQuantity': selectedQuantity,
  }).then((_) {
    // Handle success
    print('Product added to cart successfully');
  }).catchError((error) {
    // Handle errors
    print('Failed to add product to cart: $error');
  });
}

}




class CounterController extends GetxController {
  var counter = 1.obs;

  void increment() => counter++;
  void decrement() {
    if (counter > 0) counter--;
  }
}
