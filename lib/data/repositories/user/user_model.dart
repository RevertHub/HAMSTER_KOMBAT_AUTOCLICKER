import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_admin/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String bloodGroup;
  final String email;
  String phoneNumber;
  
  
  String profilePicture;
    int age;
    String gender;
    String city;
    String street;
    String eligible;


  UserModel({
   required this.id,
  required  this.firstName,
   required this.lastName,
   required this.userName,
    required this.bloodGroup,
   required this.email,
   required this.phoneNumber,
   required this.profilePicture,
    required this.age,
    required this.gender,
    required this.city,
    required this.street,
    required this.eligible,
   
  });


  String get fullName => '$firstName $lastName';

  String get formmatedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullname)=> fullname.split(" ");

  static String generateUsername(fullname){
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length>1?nameParts[1].toLowerCase():"";

    String camelCaseUserName = "$firstName$lastName";
    String usernameWithPrefix = "Doner$camelCaseUserName";
    return usernameWithPrefix;
  }

  static UserModel empty()=> UserModel(
    id: '',
    firstName: '',
    lastName: '',
    userName: '',
    bloodGroup: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
    age: 18,
    gender: '',
    city: '',
    street: '',
    eligible: 'false',

  );

  Map<String, dynamic> toJson()  {
    return{
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'BloodGroup': bloodGroup,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Age': age,
      'Gender': gender,
      'City': city,
      'Street': street,
      'Eligible': eligible,

    };
   
  }


  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    if(document.data()!=null){
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        userName: data['UserName'] ?? '',
        bloodGroup: data['BloodGroup'] ?? '',
        gender: data['Gender'] ?? '',
        age: data['Age'] ?? '',
        city: data['City'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        street: data['Street'] ?? '',
        eligible: data['Eligible'] ?? '',
      );

    }
      return UserModel.empty();
    
  }
}
