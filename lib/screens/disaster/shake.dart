import 'dart:ui';

import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shake/shake.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibration/vibration.dart';

class ShakeLocationPage extends StatefulWidget {
  @override
  _ShakeLocationPageState createState() => _ShakeLocationPageState();
}

class _ShakeLocationPageState extends State<ShakeLocationPage> {
  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      _sendLocationToFirebase();
      _showSOSAlert();
      _triggerVibration(); // Trigger haptic feedback
    });
  }

  Future<void> _sendLocationToFirebase() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference locations = firestore.collection('locations');
      await locations.add({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': DateTime.now(),
      });
      print(
          'Location sent to Firebase: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Error sending location: $e');
    }
  }

  Future<void> _showSOSAlert() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emergency SOS'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This is an emergency alert!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text('Your location has been sent to emergency services.'),
              SizedBox(height: 10),
              Text(
                'Please remain calm and stay where you are until help arrives.',
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Trigger haptic feedback
  void _triggerVibration() {
                          Vibration.vibrate(duration: 1000);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Shake for SOS'),
        showbackarrow: true,
        
      
      ),
      body: Column(
        children: [
          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              // height: MediaQuery.of(context).size.height,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(3, -0.2),
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 61, 22, 255),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(-3, -0.2),
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 84, 50, 255),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0, -1.0),
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: const BoxDecoration(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 100.0, sigmaY: 100.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                    ),
                                  ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Center(
                  child: Lottie.asset(
                    'Assets2/Images/animations/sos.json', // path to your Lottie animation file
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
         const Padding(
            padding:  EdgeInsets.only(left: 25.0 , right: 20.0 , top: 450.0),
            child: Center(
              child: Text(
                'Shake your Phone to Send Your Location To Emergency Services and Trigger SOS Alert to Reach Rescue Teams⚠️',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                
              ),
            ),
          ),
        ],
      ),
    ))]));
  }
}
