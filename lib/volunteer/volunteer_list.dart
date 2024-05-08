import 'dart:core';
import 'package:disaster_admin/screens/disaster/page_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerList extends StatelessWidget {
  VolunteerList({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('volunteer');

  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        pagemodel1(context),
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Volunteers List',
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
          body: Container(
            decoration: const BoxDecoration(),
            child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Some error occurred ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                  List<Map> items = documents
                      .map((e) => {
                            'id': e.id,
                            'name': e['name'],
                            'number': e['number'],
                            'district': e['district'],
                            // 'district':,
                          })
                      .toList();

                  return Container(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        final sortedDis = items
                          ..sort((item1, item2) =>
                              item1['district'].compareTo(item2['district']));
                        Map disaster = sortedDis[i];
                        // Map thisItem = items[i];
                        return Volunteer(disaster['id']);
                      },
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Volunteer extends StatelessWidget {
  Volunteer(this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('volunteer').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;
  late Future<DocumentSnapshot> _futureData;
  late Map data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            return Container(
                width: 400,
                // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                // margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: InkWell(
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
                                              Icons.person,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 3.0),
                                    child: Text('${data['name']}',
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 195, 17, 4))),
                                  ),
                                  Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 4.0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3.0, vertical: 3.0),
                                          child: Text(
                                            '${data['number']}',
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 71, 70, 70),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                            
                                  // SizedBox(height: 5.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Text(
                                              '${data['district']}  ',
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),                                              const SizedBox(width: 5.0),

                                            const Icon(
                                              Icons.track_changes_outlined,
                                              color: Color.fromARGB(
                                                  255, 75, 77, 76),
                                            ),
                                            Text(
                                              '   ${data['address']}',
                                              style: const TextStyle(
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
                ));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
