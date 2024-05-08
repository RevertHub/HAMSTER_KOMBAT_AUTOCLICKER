import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelplineScreen extends StatelessWidget {
  final List<Map<String, String>> helplines = [
    {"name": "Emergency", "number": "911"},
    {"name": "Health Services", "number": "123-456-7890"},
    {"name": "Police", "number": "987-654-3210"},
    // Add more helplines as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helpline Numbers'),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),

      ),
      body: ListView.builder(
        itemCount: helplines.length,
        itemBuilder: (context, index) {
          final helpline = helplines[index];
          return ListTile(
            title: Text(helpline['name']!),
            subtitle: Text(helpline['number']!),
            onTap: () => _launchCall(helpline['number']!),
          );
        },
      ),
    );
  }

  _launchCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: HelplineScreen(),
  ));
}
