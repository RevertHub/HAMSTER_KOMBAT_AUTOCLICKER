import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString address = ''.obs;

  Future<void> fetchAddress(String userId) async {
    try {
      // Assuming you have a collection named 'users' with documents containing addresses
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(userId).get();
      
      if (snapshot.exists) {
        address.value = snapshot.data()?['address'] ?? '';
      }
    } catch (error) {
      print('Error fetching address: $error');
    }
  }
}
