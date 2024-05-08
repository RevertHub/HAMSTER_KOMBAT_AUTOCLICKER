import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:disaster_admin/common/warning_snackbar.dart';
import 'package:disaster_admin/screens/profilescreen/address/widgets/address_add_controller.dart';

class UserAddressController extends GetxController {
      static AddressAddController get  instance => Get.find();

  RxList<Map<String, dynamic>> userAddresses = <Map<String, dynamic>>[].obs;
  RxInt defaultAddressIndex = RxInt(-1); // Initialize with -1 indicating no default address

  void setDefaultAddress(int index) {
    defaultAddressIndex.value = index;
  }

  @override
  void onInit() {
    fetchUserAddresses(); // Fetch user addresses when the controller is initialized
    super.onInit();
  }

  Future<void> fetchUserAddresses() async {
    try {
      // Get the current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a reference to the Firestore collection
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('UserAddresses').doc(userId);
      CollectionReference addressesRef = userRef.collection('addresses');

      // Get all documents in the collection
      QuerySnapshot querySnapshot = await addressesRef.get();

      // Convert each document to a Map and add it to the userAddresses list
      List<Map<String, dynamic>> addresses = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> address = doc.data() as Map<String, dynamic>;
        address['addressId'] = doc.id; // Add document ID to the address data
        addresses.add(address);
      }

      userAddresses.assignAll(addresses);
    } catch (e) {
      print('Error fetching user addresses: $e');
    }
  }

  Future<void> deleteAddress(int index) async {
    try {
      // Get the current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a reference to the Firestore document to be deleted
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('UserAddresses').doc(userId);
      CollectionReference addressesRef = userRef.collection('addresses');

      // Delete the document from Firestore
      await addressesRef.doc(userAddresses[index]['addressId']).delete();

      // Remove the address from the userAddresses list
      userAddresses.removeAt(index);

      TLoaders.errorSnackBar(
          title: 'Deleted Address', message: 'Your Address Has Been Deleted');
    } catch (e) {
      print('Error deleting user address: $e');
    }
  }
}
