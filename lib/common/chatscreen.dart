import 'package:flutter/material.dart';
import 'package:disaster_management/common/appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.reciverUserEmail, required this.reciverUserName});
final String reciverUserEmail;
final String reciverUserName;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: TAppBar(
        title: Text(widget.reciverUserName),
        showbackarrow: true,
      ),
   
    );

  }
}