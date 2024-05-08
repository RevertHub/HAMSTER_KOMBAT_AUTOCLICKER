import 'dart:ui';

import 'package:disaster_management/bloc/weather_bloc_bloc.dart';
import 'package:disaster_management/screens/disaster/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.blueGrey,
          extendBodyBehindAppBar: true,
          body: Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(3, -0.2),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 32, 3, 176),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, -0.2),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 32, 3, 176),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.0),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Enter your Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(20.0),
            child: RegistrationForm(),
          ),
        ),
      ],
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? _selectedGender;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(user.uid)
              .set({
            'name': _nameController.text,
            'age': _ageController.text,
            'address': _addressController.text,
            'gender': _genderController.text,
            'phoneNumber': _phoneNumberController.text,
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => FutureBuilder(
                      future: _determinePosition(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return BlocProvider<WeatherBlocBloc>(
                            create: (context) => WeatherBlocBloc()
                              ..add(FetchWeather(snap.data as Position)),
                            child: const HomeScreen(),
                          );
                        } else {
                          return const Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      })));
        }
      } catch (e) {
        print('Error saving user data: $e');
      }
    }
  }

  Widget _navigateToHomeScreen(BuildContext context) {
    return FutureBuilder(
        future: _determinePosition(),
        builder: (context, snap) {
          if (snap.hasData) {
            return BlocProvider<WeatherBlocBloc>(
              create: (context) =>
                  WeatherBlocBloc()..add(FetchWeather(snap.data as Position)),
              child: const HomeScreen(),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.greenAccent),
                hintStyle: TextStyle(color: Colors.white24),
                hintText: "Enter your Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(color: Colors.greenAccent),
                hintStyle: TextStyle(color: Colors.white24),
                hintText: "Wnter your Age"),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(color: Colors.greenAccent),
                hintStyle: TextStyle(color: Colors.white24),
                hintText: "Enter Your Address"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedGender,
            onChanged: (newValue) {
              setState(() {
                _selectedGender = newValue;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Gender',
              labelStyle: TextStyle(color: Colors.greenAccent),
              hintStyle: TextStyle(color: Colors.white24),
            ),
            items: <String>['Male', 'Female'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 200, // Specify the desired width here
                  child: Text(value),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your gender';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.greenAccent),
                hintStyle: TextStyle(color: Colors.white24),
                hintText: "Enter your Phone Number"),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

Future<Position> _determinePosition() async {
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
