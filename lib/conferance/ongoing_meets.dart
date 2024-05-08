import 'dart:ui';

import 'package:disaster_admin/conferance/vedioconf.dart';
import 'package:flutter/material.dart';

class ongoingscreen extends StatelessWidget {
  const ongoingscreen({super.key});

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
          'Ongoing Calls',
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
                              builder: (context) =>
                                  const VideoConferencePage(conferenceID: 'Call 1')),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height:
                            MediaQuery.of(context).size.width / 3, // Square box
                        decoration: BoxDecoration(
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
                            Icon(Icons.video_call,
                                color: Colors.white), // Example icon
                            SizedBox(
                                height: 8), // Spacing between icon and text
                            Text('Call 1',
                                style: TextStyle(
                                    color: Colors.white)), // Example text
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const VideoConferencePage(conferenceID: 'Call 2')),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
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
                            Icon(Icons.video_call_rounded, color: Colors.white),
                            SizedBox(height: 8),
                            Text('Call 2',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
