
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disaster_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:disaster_admin/data/repositories/user/user_model.dart';
import 'package:disaster_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:disaster_admin/utils/exceptions/format_exceptions.dart';
import 'package:disaster_admin/utils/exceptions/platform_exceptions.dart';



class UserRepositiory extends GetxController{
  static UserRepositiory get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

 Future<void> saveUserRecord(UserModel user)async{
  try{
    await _db.collection("Users").doc(user.id).set(user.toJson());

  }on FirebaseException catch(e){
    throw TFirebaseException(e.code).message;
  }on FormatException catch(_){
    throw const TFormatException();

  }on PlatformException catch(e){
    throw TPlatformException(e.code).message;
  } catch(e){
    throw 'Something went wrong, Please try again later.';
  }
 }



  Future<UserModel> fectchUserDetails()async{
  try{
final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
if(documentSnapshot.exists){
  return UserModel.fromSnapshot(documentSnapshot);
}else{
  return UserModel.empty();
}
  }on FirebaseException catch(e){
    throw TFirebaseException(e.code).message;
  }on FormatException catch(_){
    throw const TFormatException();

  }on PlatformException catch(e){
    throw TPlatformException(e.code).message;
  } catch(e){
    throw 'Something went wrong, Please try again later.';
  }
 }
  









 Future<void> updateUserDetails(UserModel updatedUser)async{
  try{
    await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());

  }on FirebaseException catch(e){
    throw TFirebaseException(e.code).message;
  }on FormatException catch(_){
    throw const TFormatException();

  }on PlatformException catch(e){
    throw TPlatformException(e.code).message;
  } catch(e){
    throw 'Something went wrong, Please try again later.';
  }
 }


 Future<void> updateSingleField(Map<String,dynamic> json)async{
  try{
    await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);

  }on FirebaseException catch(e){
    throw TFirebaseException(e.code).message;
  }on FormatException catch(_){
    throw const TFormatException();

  }on PlatformException catch(e){
    throw TPlatformException(e.code).message;
  } catch(e){
    throw 'Something went wrong, Please try again later.';
  }
 }


 Future<void> removeUserRecord(String userId)async{
  try{
    await _db.collection("Users").doc(userId).delete();

  }on FirebaseException catch(e){
    throw TFirebaseException(e.code).message;
  }on FormatException catch(_){
    throw const TFormatException();

  }on PlatformException catch(e){
    throw TPlatformException(e.code).message;
  } catch(e){
    throw 'Something went wrong, Please try again later.';
  }
 }

Future<String> uploadImage(String path, XFile image)async{
  try{
final ref = FirebaseStorage.instance.ref(path).child(image.name);
await ref.putFile(File(image.path));
final url = await ref.getDownloadURL();
return url;
  }on FirebaseException catch(e){
    throw TFirebaseException(e.code).message;
  }on FormatException catch(_){
    throw const TFormatException();

  }on PlatformException catch(e){
    throw TPlatformException(e.code).message;
  } catch(e){
    throw 'Something went wrong, Please try again later.';
  }
}


}