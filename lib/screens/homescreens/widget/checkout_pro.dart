import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/common/productcartvertical.dart';
import 'package:disaster_admin/common/success_screen/sucess_screen.dart';
import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_admin/screens/profilescreen/address/address.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';
import 'package:disaster_admin/widget/navigationbar.dart';

class CheckoutScreenMain extends StatefulWidget {
  const CheckoutScreenMain(
      {super.key,
      required this.image,
      required this.productName,
      required this.productPrice,
      required this.productDescription,
      required this.productCategory,
      required this.productQuantity,
      required this.sellerName,
      required this.discount,
      required this.productId,
      required this.selectedQuantity});
  final String image;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final int productQuantity;
  final String sellerName;
  final int discount;
  final int selectedQuantity;
  final String productId;

  @override
  State<CheckoutScreenMain> createState() => _CheckoutScreenMainState();
}

class _CheckoutScreenMainState extends State<CheckoutScreenMain> {
  // Declare variables to hold address information
  String fullName =
      'Select Your Delivery Address'; // Initialize with empty string or default value
  String phoneNumber = ''; // Initialize with empty string or default value
  String street = ''; // Initialize with empty string or default value
  String city = ''; // Initialize with empty string or default value
  String country = ''; // Initialize with empty string or default value


  void _updateProductQuantity() async {
  // Reference to the Firestore collection containing the product details
  CollectionReference productsCollection = FirebaseFirestore.instance.collection('Products');

  try {
    // Retrieve the document containing the product details
    DocumentSnapshot productSnapshot = await productsCollection.doc(widget.productId).get();
    print(widget.productId);
    // Get the current product quantity
    int currentQuantity = productSnapshot['ProductQuantity'];
    
    // Calculate the new product quantity (decrement by 1)
    int newQuantity = currentQuantity - widget.selectedQuantity;

    // Update the product quantity in the Firestore document
    await productsCollection.doc(widget.productId).update({
      'ProductQuantity': newQuantity,
    });

    print('Product quantity updated successfully.');
  } catch (e) {
    // Handle any errors
    print('Error updating product quantity: $e');
  }
}

void _saveOrderToFirestore() async {
  // Get the current user
      int discountedPrice =
        widget.productPrice - ((widget.productPrice * widget.discount) ~/ 100);
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    // Get the user ID
    String userId = user.uid;

    // Reference to the Firestore collection
    CollectionReference ordersCollection = FirebaseFirestore.instance.collection('Orders');
    
Timestamp orderTimestamp = Timestamp.now();

// Convert Timestamp to DateTime
DateTime toDay = orderTimestamp.toDate();

// Extract day and month from DateTime
int day = toDay.day;
int month = toDay.month;
int year = toDay.year;

String orderDate = '$day/$month/$year';
    try {
      // Add the order details as a document in the user's collection
      await ordersCollection.doc(userId).collection('User_Orders').doc(widget.productId).set({
        'image': widget.image,
        'productName': widget.productName,
        'productPrice': widget.productPrice,
        'productDescription': widget.productDescription,
        'productCategory': widget.productCategory,
        'productQuantity': widget.productQuantity,
        'sellerName': widget.sellerName,
        'discount': widget.discount,
        'selectedQuantity': widget.selectedQuantity,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'street': street,
        'city': city,
        'country': country,
        'orderDate': orderDate,
        'totalAmount': widget.selectedQuantity * discountedPrice + 50,
        'productId': widget.productId,

        // Add other order details as needed
      });

      // Show a success message or navigate to the success screen
      // Here you can navigate to the success screen or show a success message
      Get.to(() => SucessScreen(
            image: TImages.successfulPaymentIcon,
            title: "Payment Successful",
            subTitle: 'Your Item Will be Delivered Soon',
            onPressed: () => Get.offAll(() => const NavigationbarScreen()),
          ));
    } catch (e) {
      // Handle any errors
      print('Error saving order: $e');
    }
  } else {
    // Handle case where user is not logged in
    print('User is not logged in.');
  }
}
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    int discountedPrice =
        widget.productPrice - ((widget.productPrice * widget.discount) ~/ 100);
    int serviceFee = 50;

    return Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Row(
              children: [
                TRoundedImage(
                  isNetworkImage: true,
                  imageUrl: widget.image,
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(TSizes.sm),
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.darkerGrey
                      : TColors.light,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TBRandTitleWithVerificationICon(
                        title: widget.sellerName,
                      ),
                      Flexible(
                        child: Text(
                          widget.productName,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Quantity: ',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            text: widget.selectedQuantity.toString(),
                            style: Theme.of(context).textTheme.bodyLarge),
                      ]))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              showBorder: true,
              backgroundColor: dark ? TColors.black : TColors.white,
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product Price",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            widget.productPrice.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount Price",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            discountedPrice.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quantity",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            widget.selectedQuantity.toString(),
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Service Fee",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            serviceFee.toString(),
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '${widget.selectedQuantity * discountedPrice + serviceFee}',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Column(
                    children: [
                      TSectionHeading(
                          title: "Payment Method",
                          showActionButton: true,
                          buttonTitle: "Change",
                          onPressed: () {}),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          TRoundedContainer(
                            width: 40,
                            height: 40,
                            backgroundColor:
                                dark ? TColors.light : TColors.white,
                            padding: const EdgeInsets.all(TSizes.sm),
                            child: const Image(
                              image: AssetImage(TImages.cod),
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems / 2,
                          ),
                          Text(
                            "Cash on Delivery",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          TRoundedContainer(
                            width: 60,
                            height: 35,
                            backgroundColor:
                                dark ? TColors.light : TColors.white,
                            padding: const EdgeInsets.all(TSizes.sm),
                            child: const Image(
                              image: AssetImage(TImages.googlePay),
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems / 2,
                          ),
                          Text(
                            "Google Pay",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: 'Delivery Address',
                        showActionButton: true,
                        
                        buttonTitle: 'Change',
                        onPressed: () async {
                          final selectedAddress =
                              await Get.to(() => const UserAddressScreen());
                          if (selectedAddress != null) {
                            setState(() {
                              // Update the address information
                              fullName = selectedAddress['fullName'];
                              phoneNumber = selectedAddress['phoneNumber'];
                              street = selectedAddress['street'];
                              city = selectedAddress['city'];
                              country = selectedAddress['country'];
                            });
                          }
                        },
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            fullName,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            phoneNumber,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_history,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Expanded(
                              child: Text(
                            "$country,$city,$street",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => {
              _saveOrderToFirestore(),
              _updateProductQuantity(),
              Get.to(() => SucessScreen(
                  image: TImages.processingAnimation,
                  title: "Order Successful",
                  subTitle: 'Your Item Will be Delivered Soon',
                  onPressed: () =>
                      Get.offAll(() => const NavigationbarScreen()),
                )),},
            child:  Text("Checkout Rs:- ${widget.selectedQuantity * discountedPrice + serviceFee}")),
      ),
    );
  }
}
