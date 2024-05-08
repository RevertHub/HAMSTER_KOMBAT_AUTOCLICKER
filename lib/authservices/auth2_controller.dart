import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  static AuthController get instance => Get.find();

Widget getWeatherIcon(int code) {
  switch (code) {
    case >= 200 && < 300:
      return Image.asset('Assets2/Images/thunderstorm.png', scale: 5);
    case >= 300 && < 400:
      return Image.asset('Assets2/Images/lightrain.png', scale: 5);
    case >= 500 && < 600:
      return Image.asset('Assets2/Images/heavyrain.png', scale: 5);
    case >= 600 && < 700:
      return Image.asset('Assets2/Images/snow.png', scale: 5);
    case >= 700 && < 800:
      return Image.asset('Assets2/Images/darkclouds.png', scale: 5);
    case == 800:
      return Image.asset('Assets2/Images/sunny.png', scale: 5);
    case > 800 && <= 804:
      return Image.asset('Assets2/Images/cloudy.png', scale: 5);
    default:
      return Image.asset('Assets2/Images/cloudy.png', scale: 5);
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login screen or any other screen you desire
  } catch (e) {
    print('Error signing out: $e');
    // Handle sign-out error
  }
}


TimeOfDayEnum getTimeOfDay() {
  final hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return TimeOfDayEnum.MORNING;
  } else if (hour >= 12 && hour < 18) {
    return TimeOfDayEnum.AFTERNOON;
  } else {
    return TimeOfDayEnum.EVENING;
  }
}

Object getGreetingMessage() {
  final timeOfDay = getTimeOfDay();
  switch (timeOfDay) {
    case TimeOfDayEnum.MORNING:
      return 'Good Morning';

    case TimeOfDayEnum.AFTERNOON:
      return 'Good Afternoon';
    case TimeOfDayEnum.EVENING:
      return 'Good Evening';
    default:
      return "Good evening";
  }
}


Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}


}
enum TimeOfDayEnum {
  MORNING,
  AFTERNOON,
  EVENING,
}
