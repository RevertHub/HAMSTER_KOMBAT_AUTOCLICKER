import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaster_admin/conferance/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('User not found'));
        }

        // Retrieve username from the document snapshot
        String username = snapshot.data!.get('FirstName');

        return SafeArea(
          child: ZegoUIKitPrebuiltVideoConference(
            appID:
                appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign:
                appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: FirebaseAuth.instance.currentUser!.uid,
            userName: username, // Use the retrieved username here
            conferenceID: conferenceID,
            config: ZegoUIKitPrebuiltVideoConferenceConfig(),
          ),
        );
      },
    );
  }
}
