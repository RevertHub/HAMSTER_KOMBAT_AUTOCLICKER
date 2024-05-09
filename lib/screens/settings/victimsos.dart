import 'package:disaster_admin/screens/disaster/sosmap.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VictimSOSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Victim SOS'),
      ),
      body: UserLocationsList(),
    );
  }
}

class UserLocationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('Alert_locations').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        // Extracting user IDs, latitude, and longitude from Alert_locations collection
        final List<DocumentSnapshot> alerts = snapshot.data!.docs;
        return ListView.builder(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            final userId = alert.id;
            final latitude = alert['latitude'];
            final longitude = alert['longitude'];
            // Querying users collection to get username using user ID
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userId)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(); // Placeholder widget while waiting for data
                }
                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }
                final username = userSnapshot.data!.get('FirstName');
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SosmapPage(
                                clatitude: latitude,
                                clongitude: longitude,
                                markerTitle: username)));
                  },
                  child: ListTile(
                    title: Text(username),
                    subtitle:
                        Text('Latitude: $latitude, Longitude: $longitude'),
                    // You can add more functionality here like navigating to user's profile on tap
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
