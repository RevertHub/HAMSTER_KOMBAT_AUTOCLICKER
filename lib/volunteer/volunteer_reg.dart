import 'package:disaster_admin/screens/disaster/page_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VolunteerReg extends StatefulWidget {
  const VolunteerReg({Key? key}) : super(key: key);

  @override
  State<VolunteerReg> createState() => _VolunteerRegState();
}

class _VolunteerRegState extends State<VolunteerReg> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCnumber = TextEditingController();
  final TextEditingController _controllerState = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerInterests = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('volunteer');

  final User? user = FirebaseAuth.instance.currentUser;

  void clearText() {
    _controllerName.clear();
    _controllerCnumber.clear();
    _controllerState.clear();
    _controllerDistrict.clear();
    _controllerAddress.clear();
    _controllerInterests.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        pagemodel1(context),
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Volunteers Registration',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: SingleChildScrollView(
                child: Form(
              key: key,
              child: Column(children: [
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.fromLTRB(4, 10, 4, 4),
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    controller: _controllerName,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: const Color.fromARGB(255, 3, 0, 195),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 2.0, top: 14.0),
                      hintText: 'Enter Your Name ',
                      focusColor: const Color.fromARGB(255, 109, 189, 106),
                      //  border: OutlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[300],
                      //  focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 237, 235, 235)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  margin: const EdgeInsets.all(1.0),
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    controller: _controllerCnumber,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconColor: const Color.fromARGB(255, 3, 0, 195),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 2.0, top: 14.0),
                      hintText: 'Enter Your Contact No ',
                      focusColor: const Color.fromARGB(255, 109, 189, 106),
                      //  border: OutlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[300],
                      //  focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 237, 235, 235)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Contact No';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  margin: const EdgeInsets.all(1.0),
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    controller: _controllerState,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                      ),
                      prefixIconColor: const Color.fromARGB(255, 3, 0, 195),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 2.0, top: 14.0),
                      hintText: 'Enter State ',
                      focusColor: const Color.fromARGB(255, 109, 189, 106),
                      //  border: OutlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[300],
                      //  focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 237, 235, 235)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter state';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  margin: const EdgeInsets.all(1.0),
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    controller: _controllerDistrict,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                      ),
                      prefixIconColor: const Color.fromARGB(255, 3, 0, 195),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 2.0, top: 14.0),
                      hintText: 'Enter District ',
                      focusColor: const Color.fromARGB(255, 109, 189, 106),
                      //  border: OutlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[300],
                      //  focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 237, 235, 235)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter district';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  margin: const EdgeInsets.all(1.0),
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    controller: _controllerAddress,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.location_on,
                      ),
                      prefixIconColor: const Color.fromARGB(255, 3, 0, 195),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 2.0, top: 14.0),
                      hintText: 'Enter your Address ',
                      focusColor: const Color.fromARGB(255, 109, 189, 106),
                      //  border: OutlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[300],
                      //  focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 237, 235, 235)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  margin: const EdgeInsets.all(1.0),
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
                    controller: _controllerInterests,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.handshake_sharp),
                      prefixIconColor: const Color.fromARGB(255, 3, 0, 195),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 2.0, top: 14.0),
                      hintText: 'Your interests to work in ',
                      focusColor: const Color.fromARGB(255, 109, 189, 106),
                      //  border: OutlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[300],
                      //  focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(25.7)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 237, 235, 235)),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 76, 104, 175),
                        borderRadius: BorderRadius.circular(30)),
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Submit',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      onTap: () async {
                        if (key.currentState!.validate()) {
                          String vName = _controllerName.text;
                          String vNumber = _controllerCnumber.text;
                          String vState = _controllerState.text;
                          String vDistrict = _controllerDistrict.text;
                          String vAddress = _controllerAddress.text;
                          String vInterests = _controllerInterests.text;

                          Map<String, String> dataToSend = {
                            'name': vName,
                            'number': vNumber,
                            'state': vState,
                            'district': vDistrict,
                            'address': vAddress,
                            'interests': vInterests,
                          };
                          _reference.add(dataToSend);
                          //   clearText();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Volunteer Registered Successfully')));
                        }
                      },
                    ))
              ]),
            )),
          ),
        ),
      ],
    );
  }
}
