import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/common/productcartvertical.dart';
import 'package:disaster_admin/screens/disaster/helpline_screen.dart';
import 'package:disaster_admin/utils/constants/enums.dart';
import 'package:disaster_admin/volunteer/volunteer_list.dart';
import 'package:disaster_admin/volunteer/volunteer_reg.dart';
import 'package:flutter/material.dart';

class VolunteerScreen extends StatelessWidget {
  const VolunteerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const TAppBar(
        title: Text('Volunteer List'),
        showbackarrow: false,
      
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
                    color: Color.fromARGB(255, 43, 3, 240),
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
                    color: Color.fromARGB(255, 96, 66, 247),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 47, 17, 96),
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
                    color: Color.fromARGB(255, 39, 21, 128),
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
                    color: Color.fromARGB(255, 55, 32, 173),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.0),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 47, 17, 96),
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
                              builder: (context) => const VolunteerReg()),
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
                            Icon(Icons.add,
                                color: Colors.white), // Example icon
                            SizedBox(
                                height: 8), // Spacing between icon and text
                            Text('Registration',
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
                                builder: (context) => HelplineScreen()));
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
                            Icon(Icons.call, color: Colors.white),
                            SizedBox(height: 8),
                            Text('Helplines',
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
                    20 +
                    MediaQuery.of(context).size.width / 3 +
                    20, // Adjust position based on the size of previous widgets
                left: 0,
                right: 0,
                child: TBRandTitleWithVerificationICon(title: 'Medicine Team', iconColor: Colors.green, brandTextSize: TextSizes.large,)),
              Positioned(
                top: 1.2 * kToolbarHeight +MediaQuery.of(context).size.width / 3.4, // Adjust position based on the size of previous widgets
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 200, // Adjust height as needed
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('volunteer')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot = snapshot.data;
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;

                        List<Map> items = documents
                            .map((e) => {
                                  'id': e.id,
                                  'name': e['name'],
                                  'number': e['number'],
                                  'district': e['district'],
                                })
                            .toList();

                        items.sort((item1, item2) =>
                            item1['district'].compareTo(item2['district']));

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            Map disaster = items[i];
                            return Volunteer(disaster['id']);
                          },
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
               Positioned(
                 top: 1.2 * kToolbarHeight +
                    20 +
                    MediaQuery.of(context).size.width / 1.37 +
                    20, // Adjust position based on the size of previous widgets
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TBRandTitleWithVerificationICon(title: 'Rescue Team', iconColor: Colors.green, brandTextSize: TextSizes.large,),
                )),
              Positioned(
                top: 1.2 * kToolbarHeight +MediaQuery.of(context).size.width / 1.4, // Adjust position based on the size of previous widgets
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 200, // Adjust height as needed
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('volunteer')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot = snapshot.data;
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;

                        List<Map> items = documents
                            .map((e) => {
                                  'id': e.id,
                                  'name': e['name'],
                                  'number': e['number'],
                                  'district': e['district'],
                                })
                            .toList();

                        items.sort((item1, item2) =>
                            item1['district'].compareTo(item2['district']));

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            Map disaster = items[i+1];
                            return Volunteer(disaster['id']);
                          },
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
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
        title: const Text('Enter Code'),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolunteerList()),
    );
  } else {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Incorrect code')),
    );
  }
}
