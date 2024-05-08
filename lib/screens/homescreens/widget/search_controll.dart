import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchControll extends GetxController {
  static SearchControll get to => Get.find();
  
  // Define an observable list to hold the fetched data
  var productDataList = <Map<String, dynamic>>[].obs;
  
  // Observable boolean to track loading state
  var isLoading = false.obs;

  // Observable list to hold filtered product data based on search query
  var filteredProductDataList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Call a function to fetch data when the controller is initialized
    fetchData();
  }

  void fetchData() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      
      // Access Firestore instance
      var firestore = FirebaseFirestore.instance;

      // Replace 'Products' with the actual name of your Firestore collection
      var querySnapshot = await firestore.collection('Products').get();

      // Extract the desired field values from each document
      var dataList = querySnapshot.docs.map((doc) {
        // Extract multiple fields from each document and store them in a map
        return {
          'productName': doc['ProductName'],
          'productPrice': doc['ProductPrice'],
          'productDescription': doc['ProductDescription'],
          'productImage': doc['Image_Url'],
          'productQuantity': doc['ProductQuantity'],
          'productCategory': doc['Dropdown_Value'],
          'userId': doc['UserId'],
          'UserName': doc['UserName'],
          'discount':doc['Discount'],
          'productId':doc['productId'],
          // Add more fields as needed
        };
      }).toList();
      
      // Update the value of the observable list
      productDataList.value = dataList;

      // Initialize filteredProductDataList with the fetched data
      filteredProductDataList.assignAll(productDataList);
    } catch (e) {
      // Handle errors if any
      print('Error fetching data: $e');
    } finally {
      // Set loading state to false after data fetching completes or encounters an error
      isLoading.value = false;
    }
  }

  // Method to search products based on the query
  void searchProduct(String query) {
    if (query.isEmpty) {
      // If the search query is empty, reset the filtered list to the original data
      filteredProductDataList.assignAll(productDataList);
    } else {
      // Filter the productDataList based on the search query
      var filteredList = productDataList.where((product) =>
          product['productName'].toLowerCase().contains(query.toLowerCase())).toList();
      
      // Update the value of filteredProductDataList
      filteredProductDataList.assignAll(filteredList);
    }
  }
    // Method to clear the filter and reset the product list
  void clearFilter() {
    filteredProductDataList.assignAll(productDataList);
  }

}
