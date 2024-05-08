// import 'dart:async';

// import 'package:flutter/material.dart';

// class AlertBox extends StatefulWidget {
//   @override
//   _AlertBoxState createState() => _AlertBoxState();
// }

// class _AlertBoxState extends State<AlertBox> {
//   int _currentIndex = 0;
//   final List<String> _messages = [
//     'Alert 1',
//     'Alert 2',
//     'Alert 3',
//   ];
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       setState(() {
//         _currentIndex = (_currentIndex + 1) % _messages.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(horizontal: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: AnimatedSwitcher(
//         duration: Duration(milliseconds: 500),
//         child: Text(
//           _messages[_currentIndex],
//           key: ValueKey<int>(_currentIndex),
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertBox extends StatefulWidget {
  const AlertBox({super.key});

  @override
  _AlertBoxState createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  late SharedPreferences _prefs;
  late Timer _timer;
  int _currentIndex = 0;
  List<String> _notifications = [];

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _notifications.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _notifications = _prefs.getStringList('notifications') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width - 32.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(82, 54, 51, 58),
          borderRadius: BorderRadius.circular(8.0),
          border:  Border.all(color: const Color.fromARGB(255, 244, 63, 63), width: 0.4),
          
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _notifications.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    _notifications[_currentIndex],
                    key: ValueKey<String>(_notifications[_currentIndex]),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 244, 63, 63),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',                      
                      
                    ),
                  ),
                )
              : const SizedBox(), // Return empty SizedBox if there are no notifications
        ),
      ),
    );
  }
}
