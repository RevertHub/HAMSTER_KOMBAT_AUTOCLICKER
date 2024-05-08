import 'dart:ui';

import 'package:disaster_admin/bloc/weather_bloc_bloc.dart';
import 'package:disaster_admin/screens/alert_screen.dart';
import 'package:disaster_admin/screens/disaster/MapScreen.dart';
import 'package:disaster_admin/screens/disaster/communication_screen.dart';
import 'package:disaster_admin/screens/disaster/staticdata_screen.dart';
import 'package:disaster_admin/screens/disaster/volunteer_screen.dart';
import 'package:disaster_admin/screens/homescreens/widget/home_appbar.dart';
import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_admin/weather/data/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
final navigatorKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
     
             
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                      decoration: const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                    builder: (context, state) {
                      if (state is WeatherBlocSuccess) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 const  TPrimaryHeaderContainer(
                            child: Column(
                              children: [
                                 THomeAppBar(),
                              SizedBox(
                                height: 20,
                              )
                              ],
                            ),
                                    ),
                              Text(
                                '📍 ${state.weather.areaName}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                getGreetingMessage() as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .end, // Aligning to the right
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: getWeatherIcon(
                                          state.weather.weatherConditionCode!),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      '${state.weather.temperature!.celsius!.round()} °C',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 55,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                             
                              Center(
                                child: Text(
                                  state.weather.weatherMain!.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Text(
                                  DateFormat('EEEE dd •')
                                      .add_jm()
                                      .format(state.weather.date!),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "Assets2/Images/sunrise.png",
                                        scale: 10,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Sunrise',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunrise!),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "Assets2/Images/sunset.png",
                                        scale: 10,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Sunset',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunset!),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "Assets2/Images/maxtemp.png",
                                        scale: 10,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Max Temp',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${state.weather.tempMax!.celsius!.round()} °C',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "Assets2/Images/mintemp.png",
                                        scale: 10,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Min Temp',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${state.weather.tempMin!.celsius!.round()} °C',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: AlertBox(),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.map,
                                            size: 30, color: Colors.white),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MapPage()));
                                        },
                                      ),
                                      const Text(
                                        'Map',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.chat,
                                            size: 30, color: Colors.white),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MeetScreen()));
                                        },
                                      ),
                                      const Text(
                                        'Communication',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.call,
                                            size: 30, color: Colors.white),
                                        onPressed: () {},
                                      ),
                                      const Text(
                                        'Helpline',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.person,
                                            size: 40, color: Colors.white),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const VolunteerScreen()),
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Volunteer',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.handyman,
                                            size: 40, color: Colors.white),
                                        onPressed: () {},
                                      ),
                                      const Text(
                                        'Resource Management',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.call_made,
                                            size: 40, color: Colors.white),
                                        onPressed: () {},
                                      ),
                                      const Text(
                                        'Translator',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.info,
                                            size: 40, color: Colors.white),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                       DisasterManagementPage()));
                                        },
                                      ),
                                      const Text(
                                        'Info',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.add_alert,
                                            size: 40, color: Colors.white),
                                        onPressed: () {
                                           Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AppNotificationsScreen()));
                          
                                        },
                                      ),
                                      const Text(
                                        'Alerts',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.person,
                                            size: 40, color: Colors.white),
                                        onPressed: () {},
                                      ),
                                      const Text(
                                        ' Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

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

Future<void> _signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login screen or any other screen you desire
  } catch (e) {
    print('Error signing out: $e');
    // Handle sign-out error
  }
}

enum TimeOfDayEnum {
  MORNING,
  AFTERNOON,
  EVENING,
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
