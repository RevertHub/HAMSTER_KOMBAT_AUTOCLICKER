import 'dart:ui';

import 'package:disaster_admin/conferance/ongoing_meets.dart';
import 'package:flutter/material.dart';

class MeetScreen extends StatefulWidget {
  const MeetScreen({super.key});

  @override
  State<MeetScreen> createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Communication Screen',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                    color: Color.fromARGB(255, 72, 64, 111),
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
                    color: Color.fromARGB(255, 104, 91, 171),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 94, 41, 177),
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
              Positioned(
                top: 1.2 * kToolbarHeight + 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ongoingscreen()));
                      },
                      child: Container(
                        
                        width: MediaQuery.of(context).size.width / 3,
                        height:
                            MediaQuery.of(context).size.width / 3, // Square box
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color:
                              Colors.blue.withOpacity(0.2), // Transparent blue
                          border: Border.all(
                              color: const Color.fromARGB(26, 90, 89, 89),
                              width: 2), // White border
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.meeting_room,
                                color: Colors.white), // Example icon
                            SizedBox(
                                height: 8), // Spacing between icon and text
                            Text('Join a meet',
                                style: TextStyle(
                                    color: Colors.white)), // Example text
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCodeInputDialog(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color:

                              Colors.red.withOpacity(0.2), // Transparent blue
                          border: Border.all(
                              color: const Color.fromARGB(26, 90, 89, 89),
                              width: 2), // White border
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(height: 8),
                            Text('Create a meet',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 1.2 * kToolbarHeight +
                    
                    MediaQuery.of(context).size.width / 3.9 +
                    20, // Adjust position based on the size of previous widgets
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 450, // Adjust height as needed
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      // Horizontal list items...
                     InkWell(
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: .0, vertical: .0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                              Icons.call,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 3.0),
                                    child: const Text('Rescue Team S1',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 195, 17, 4))),
                                  ),
                                  
                                    ],
                                  ),
                            
                                  // SizedBox(height: 5.0),
                                  Container(
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              'Kozhikode  ',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),                                              SizedBox(width: 5.0),

                                            Icon(
                                              Icons.track_changes_outlined,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Text(
                                              '  Koyilandy',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12.0),
                              // Container(
                              //     child: Row(
                              //   children: [
                              //     const Icon(Icons.location_on,
                              //         color: Color.fromARGB(255, 75, 77, 76)),
                              //     const SizedBox(width: 5.0),
                              //     Text('${data['district']}',
                              //         style: const TextStyle(
                              //           fontSize: 15.0,
                              //           fontWeight: FontWeight.bold,
                              //           // color: Color.fromARGB(153, 23, 1, 1),
                              //         )),
                              //   ],
                              // ))
                            ],
                          ))),
                ),
                const SizedBox(
                                                height: 8,
                                              ),
                   InkWell(
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: .0, vertical: .0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                              Icons.call,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 3.0),
                                    child: const Text('Rescue Team S2',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 195, 17, 4))),
                                  ),
                                 
                                    ],
                                  ),
                            
                                  // SizedBox(height: 5.0),
                                  Container(
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              'Kozhikode  ',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),                                              SizedBox(width: 5.0),

                                            Icon(
                                              Icons.track_changes_outlined,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Text(
                                              ' Ulliyeri',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12.0),
                              // Container(
                              //     child: Row(
                              //   children: [
                              //     const Icon(Icons.location_on,
                              //         color: Color.fromARGB(255, 75, 77, 76)),
                              //     const SizedBox(width: 5.0),
                              //     Text('${data['district']}',
                              //         style: const TextStyle(
                              //           fontSize: 15.0,
                              //           fontWeight: FontWeight.bold,
                              //           // color: Color.fromARGB(153, 23, 1, 1),
                              //         )),
                              //   ],
                              // ))
                            ],
                          ))),
                ),const SizedBox(
                                                height: 8,
                                              ),
                 InkWell(
                  child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: .0, vertical: .0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                              Icons.call,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 3.0),
                                    child: const Text('Rescue Team S3',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 195, 17, 4))),
                                  ),
                                 
                                    ],
                                  ),
                            
                                  // SizedBox(height: 5.0),
                                  Container(
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              'Kozhikode  ',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),                                              SizedBox(width: 5.0),

                                            Icon(
                                              Icons.track_changes_outlined,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Text(
                                              ' Balussery',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12.0),
                              // Container(
                              //     child: Row(
                              //   children: [
                              //     const Icon(Icons.location_on,
                              //         color: Color.fromARGB(255, 75, 77, 76)),
                              //     const SizedBox(width: 5.0),
                              //     Text('${data['district']}',
                              //         style: const TextStyle(
                              //           fontSize: 15.0,
                              //           fontWeight: FontWeight.bold,
                              //           // color: Color.fromARGB(153, 23, 1, 1),
                              //         )),
                              //   ],
                              // ))
                            ],
                          ))),
                ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showCodeInputDialog(BuildContext context) async {
  String enteredCode = '';
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Code to verify'),
        content: TextField(
          obscureText: true,
          decoration: const InputDecoration(hintText: 'Enter code'),
          onChanged: (value) {
            enteredCode = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              codeconfirm(enteredCode, context);
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );

  // Check if the entered code is correct
}

void codeconfirm(String enteredCode, context) {
  if (enteredCode == '1234') {
    // Navigate to VolunteerList page
  } else {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Incorrect code')),
    );
  }
}
