import 'dart:ui';

import 'package:disaster_admin/authservices/auth2_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_admin/bloc/weather_bloc_bloc.dart';
import 'package:disaster_admin/screens/disaster/MapScreen.dart';
import 'package:disaster_admin/screens/disaster/page_model.dart';
import 'package:disaster_admin/screens/disaster/shake.dart';
import 'package:disaster_admin/screens/disaster/staticdata_screen.dart';
import 'package:disaster_admin/screens/homescreens/widget/home_appbar.dart';
import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_admin/weather/data/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:disaster_admin/utils/helpers/helper_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  String? mtoken = "";
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<String?> fetchEligibility(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          (await FirebaseFirestore.instance.collection('Users').doc(uid).get());
      if (snapshot.exists) {
        final String isEligible = snapshot.data()?['Eligible'];
        return isEligible;
      } else {
        await FirebaseFirestore.instance.collection("Users").doc(uid).set({
          'Eligible': 'false',
        });
        return 'false';
      }
    } catch (e) {
      print("Error for eligibility");
      return 'false';
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User permission granted");
      getToken();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Provisional status given");
    } else {
      print("User permission for notification not given");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(() {
          mtoken = token;
          print("My token is $mtoken");
        });
        saveToken(token!);
      },
    );
  }

  void saveToken(String token) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userSnapshot.exists) {
        final String? bloodGroup = userSnapshot.data()?['BloodGroup'];
        final String? city = userSnapshot.data()?['City'];

        if (bloodGroup != null) {
          await FirebaseFirestore.instance.collection("tokens").doc(uid).set({
            'token': token,
            'bloodgroup': bloodGroup,
            'City': city,
          });
          print("Token and blood group saved successfully");
        } else {
          print("Blood group not found for user with UID: $uid");
        }
      } else {
        print("User document not found for UID: $uid");
      }
    } catch (e) {
      print("Error fetching blood group: $e");
    }
  }
  // void handleNotification(RemoteMessage? message) {
  //   if (message == null) return;
  //   navigatorKey.currentState
  //       ?.pushNamed('handle_notification', arguments: message);
  // }

  // Future initPushNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((message) {
  //     if (message != null) {
  //       handleNotification(message);
  //     }
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  // }

  @override
  Widget build(BuildContext context) {
    final AuthController controller = AuthController();

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
        body: FutureBuilder(
            future: controller.determinePosition(),
            builder: (context, snap) {
              if (snap.hasData) {
                return BlocProvider<WeatherBlocBloc>(
                    create: (context) => WeatherBlocBloc()
                      ..add(FetchWeather(snap.data as Position)),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              // height: MediaQuery.of(context).size.height,
                              child: Stack(
                                children: [
                                   Align(
                alignment: const AlignmentDirectional(2, -0.1),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 72, 58, 147),
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
                    color: Color.fromARGB(255, 47, 18, 189),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 114, 63, 197),
                  ),
                ),
              ),
              Column(
                children: [
                     Align(
                alignment: const AlignmentDirectional(2, -0.1),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 72, 52, 171),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Align(
                  alignment: const AlignmentDirectional(-3, -0.2),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 104, 80, 225),
                    ),
                  ),
                ),
              ),
              
                ],
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
                                  BlocBuilder<WeatherBlocBloc,
                                      WeatherBlocState>(
                                    builder: (context, state) {
                                      if (state is WeatherBlocSuccess) {
                                        return SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TPrimaryHeaderContainer(
                                                child: Column(
                                                  children: [
                                                    THomeAppBar(
                                                      message: controller
                                                              .getGreetingMessage()
                                                          as String,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(

                                                    padding: const EdgeInsets.only(left :15.0, right: 10),
                                                child: Row(
                                                  children: [
                                                    const Icon(Iconsax.location_add,
                                                        color: Color.fromARGB(
                                                            255, 245, 2, 2)),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${state.weather.areaName}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: controller
                                                          .getWeatherIcon(state
                                                              .weather
                                                              .weatherConditionCode!),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      '${state.weather.temperature!.celsius!.round()} °C',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 55,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Center(
                                                child: Text(
                                                  state.weather.weatherMain!
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Center(
                                                child: Text(
                                                  DateFormat('EEEE dd •')
                                                      .add_jm()
                                                      .format(
                                                          state.weather.date!),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left :10.0, right: 10),

                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Sunrise',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              DateFormat()
                                                                  .add_jm()
                                                                  .format(state
                                                                      .weather
                                                                      .sunrise!),
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                                                                          padding: const EdgeInsets.only(left :15.0, right: 20),
                                                
                                                      child: Row(
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'Sunset',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                DateFormat()
                                                                    .add_jm()
                                                                    .format(state
                                                                        .weather
                                                                        .sunset!),
                                                                style:
                                                                    const TextStyle(
                                                                  color:
                                                                      Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Divider(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Padding(
                                              padding: const EdgeInsets.only(left :8.0, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Max Temp',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              '${state.weather.tempMax!.celsius!.round()} °C',
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left :8.0, right: 10),
                                                      child: Row(
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'Min Temp',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                '${state.weather.tempMin!.celsius!.round()} °C',
                                                                style:
                                                                    const TextStyle(
                                                                  color:
                                                                      Colors.white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Divider(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20.0),
                                                child: AlertBox(),
                                              ),
                                              const SizedBox(height: 30),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.map,
                                                            size: 30,
                                                            color:
                                                                Colors.white),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MapPage()));
                                                        },
                                                      ),
                                                      const Text(
                                                        'Map',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.crisis_alert,
                                                            size: 30,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ShakeLocationPage()));
                                                        },
                                                      ),
                                                      const Text(
                                                        'SOS',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Column(
                                                  //   children: [
                                                  //     IconButton(
                                                  //       icon: const Icon(
                                                  //           Icons.call,
                                                  //           size: 30,
                                                  //           color:
                                                  //               Colors.white),
                                                  //       onPressed: () {
                                                  //         Navigator.push(
                                                  //             context,
                                                  //             MaterialPageRoute(
                                                  //                 builder:
                                                  //                     (context) =>
                                                  //                         HelplineScreen()));
                                                  //       },
                                                  //     ),
                                                  //     const Text(
                                                  //       'Helpline',
                                                  //       style: TextStyle(
                                                  //         color: Colors.white,
                                                  //         fontWeight:
                                                  //             FontWeight.bold,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.info,
                                                            size: 30,
                                                            color:
                                                                Colors.white),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DisasterManagementPage()));
                                                        },
                                                      ),
                                                      const Text(
                                                        'Awareness',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // const SizedBox(height: 30),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              //   children: [
                                              //     Column(
                                              //       children: [
                                              //         IconButton(
                                              //           icon: const Icon(Icons.person,
                                              //               size: 40, color: Colors.white),
                                              //           onPressed: () {
                                              //             Navigator.push(
                                              //               context,
                                              //               MaterialPageRoute(
                                              //                   builder: (context) =>
                                              //                       const VolunteerScreen()),
                                              //             );
                                              //           },
                                              //         ),
                                              //         const Text(
                                              //           'Volunteer',
                                              //           style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Column(
                                              //       children: [
                                              //         IconButton(
                                              //           icon: const Icon(Icons.handyman,
                                              //               size: 40, color: Colors.white),
                                              //           onPressed: () {},
                                              //         ),
                                              //         const Text(
                                              //           'Resource Management',
                                              //           style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Column(
                                              //       children: [
                                              //         IconButton(
                                              //           icon: const Icon(Icons.call_made,
                                              //               size: 40, color: Colors.white),
                                              //           onPressed: () {},
                                              //         ),
                                              //         const Text(
                                              //           'Translator',
                                              //           style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              // const SizedBox(height: 30),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              //   children: [
                                              //     Column(
                                              //       children: [
                                              //         IconButton(
                                              //           icon: const Icon(Icons.info,
                                              //               size: 40, color: Colors.white),
                                              //           onPressed: () {
                                              //             Navigator.push(
                                              //                 context,
                                              //                 MaterialPageRoute(
                                              //                     builder: (context) =>
                                              //                          DisasterManagementPage()));
                                              //           },
                                              //         ),
                                              //         const Text(
                                              //           'Info',
                                              //           style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Column(
                                              //       children: [
                                              //         IconButton(
                                              //           icon: const Icon(Icons.add_alert,
                                              //               size: 40, color: Colors.white),
                                              //           onPressed: () {
                                              //              Navigator.push(
                                              //                 context,
                                              //                 MaterialPageRoute(
                                              //                     builder: (context) =>
                                              //                         const AppNotificationsScreen()));

                                              //           },
                                              //         ),
                                              //         const Text(
                                              //           'Alerts',
                                              //           style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     Column(
                                              //       children: [
                                              //         IconButton(
                                              //           icon: const Icon(Icons.person,
                                              //               size: 40, color: Colors.white),
                                              //           onPressed: () {},
                                              //         ),
                                              //         const Text(
                                              //           ' Profile',
                                              //           style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
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
                    ));
              } else {
                return const PageModel();
              }
            }));
  }
}
