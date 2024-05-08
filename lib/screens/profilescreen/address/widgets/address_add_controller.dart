  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:disaster_admin/common/network_manager.dart';
  import 'package:disaster_admin/common/warning_snackbar.dart';
import 'package:disaster_admin/screens/profilescreen/address/address.dart';
  import 'package:disaster_admin/utils/constants/image_strings.dart';
  import 'package:disaster_admin/utils/popups/full_screen_loader.dart';

  class AddressAddController extends GetxController{
    static AddressAddController get  instance => Get.find();

    final fullName = TextEditingController();
    final phoneNumber = TextEditingController();
    final street = TextEditingController();
    final city = TextEditingController();
    final state = TextEditingController();
    final postalCode = TextEditingController();
    final country = TextEditingController();
    final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();



  @override
  void onInit() {
    super.onInit();
    
  initializeNames();
  }

  Future<void> addUserAddress() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We Are Updating Your Information', TImages.processingAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Get the current user ID
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;

      // Create a reference to the Firestore user document
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('UserAddresses').doc(userId);

      // Create a reference to the addresses subcollection
      CollectionReference addressesRef = userRef.collection('addresses');

      // Add a new document to the addresses subcollection
      await addressesRef.add({
        'FullName': fullName.text.trim(),
        'PhoneNumber': phoneNumber.text.trim(),
        'Street': street.text.trim(),
        'City': city.text.trim(),
        'State': state.text.trim(),
        'PostalCode': postalCode.text.trim(),
        'Country': country.text.trim(),
      });

      TFullScreenLoader.stopLoading();
         // Notify GetX to update the UI
    update();
      Get.offAll(const UserAddressScreen());
      TLoaders.sucessSnackBar(
          title: 'Congratulations', message: 'Your Address Has Been Added');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Your Address Could Not Be Added');
      print('Error adding address: $e');
    }
  }

  Future<void> initializeNames() async {
    try {
      // Get the current user ID
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;

      // Create a reference to the Firestore user document
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('UserAddresses').doc(userId);

      // Create a reference to the addresses subcollection
      CollectionReference addressesRef = userRef.collection('addresses');

      // Query all documents in the addresses subcollection
      QuerySnapshot addressesSnapshot = await addressesRef.get();

      // If there are addresses, initialize the fields with the first address
      if (addressesSnapshot.docs.isNotEmpty) {
        // Get the data of the first address document
        Map<String, dynamic> addressData =
            addressesSnapshot.docs.first.data() as Map<String, dynamic>;

        // Set the values to the text controllers
        fullName.text = addressData['FullName'] ?? '';
        phoneNumber.text = addressData['PhoneNumber'] ?? '';
        street.text = addressData['Street'] ?? '';
        city.text = addressData['City'] ?? '';
        state.text = addressData['State'] ?? '';
        postalCode.text = addressData['PostalCode'] ?? '';
        country.text = addressData['Country'] ?? '';
      }
    } catch (e) {
      print('Error initializing address: $e');
    }
  }
  }