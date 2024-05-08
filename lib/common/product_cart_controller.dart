import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCartYController extends GetxController {
  // Define an observable variable to track loading state
  var isLoading = true.obs;

  // Define an observable list to hold product data
  var productDataList = [].obs;

  // Method to fetch product data from Firestore
  void fetchProductData() async {
    try {
      isLoading(true); // Set loading state to true

      // Retrieve product data from Firestore
      var snapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Cart_Items')
          .get();

      // Clear existing data before adding new data
      productDataList.clear();

      // Loop through each document in the snapshot
      for (var doc in snapshot.docs) {
        // Extract field values from each document
        String productId = doc['productId'];
        String productImage = doc['image'];
        String productName = doc['productName'];
        int productPrice = doc['productPrice'];
        String productDescription = doc['productDescription'];
        String productCategory = doc['productCategory'];
        int productQuantity = doc['productQuantity'];
        String sellerName = doc['sellerName'];
        int discount = doc['discount'];

print('Product ID: $productId');

        // Add extracted field values to productDataList
        productDataList.add({
          'productId': productId,
          'image': productImage,
          'productName': productName,
          'productPrice': productPrice,
          'productDescription': productDescription,
          'productCategory': productCategory,
          'productQuantity': productQuantity,
          'sellerName': sellerName,
          'discount': discount,
        });
        print('Product Data: $productDataList');
      }
    } catch (error) {
      // Handle errors
      print('Error fetching product data: $error');
    } finally {
      isLoading(false); // Set loading state to false
    }
  }

  @override
  void onInit() {
    // Fetch product data when the controller initializes
    fetchProductData();
    super.onInit();
  }
}
