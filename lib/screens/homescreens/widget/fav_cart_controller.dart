import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartControllerPro extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Map to hold cart items for each user
 RxMap<String, List<Map<String, dynamic>>> cartItemsMap =
      <String, List<Map<String, dynamic>>>{}.obs;
  // Function to fetch cart items for multiple users
  Future<void> fetchCartItems(List<String> userIds) async {
    try {
      // Clear previous cart items
      cartItemsMap.clear();

      for (String userId in userIds) {
        // Reference to the Firestore collection 'cart' for the user
        CollectionReference cartCollection = _firestore
            .collection('Cart')
            .doc(userId)
            .collection('Cart_Items');

        // Get the documents in the cart collection
        QuerySnapshot querySnapshot = await cartCollection.get();

        // List to hold cart items for the current user
        List<Map<String, dynamic>> userCartItems = [];

        // Iterate through each document in the cart collection
        for (var doc in querySnapshot.docs) {
          // Retrieve specific fields from the document data
          Map<String, dynamic> cartItem = {
            'productName': doc['productName'],
            'productPrice': doc['productPrice'],
            'productQuantity': doc['productQuantity'],
            'productCategory': doc['productCategory'],
            'sellerName': doc['sellerName'],
            'productDescription': doc['productDescription'],
            'discount': doc['discount'],
            'selectedQuantity': doc['selectedQuantity'],
            'image': doc['image'],
            'productId': doc['productId'],
            
            // Add other fields as needed
          };
          // Add the cart item to the list
          userCartItems.add(cartItem);
        }

        // Update the cart items map with fetched items for the current user
        cartItemsMap[userId] = userCartItems;
      }
    } catch (error) {
      // Handle errors
      print('Failed to fetch cart items: $error');
    }
  }
}
