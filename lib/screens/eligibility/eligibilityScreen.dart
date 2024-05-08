import 'package:disaster_admin/screens/homescreens/widget/homewidget.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';
import 'package:disaster_admin/widget/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EligibilityScreen extends StatefulWidget {
  const EligibilityScreen({Key? key}) : super(key: key);

  @override
  _EligibilityScreenState createState() => _EligibilityScreenState();
}

class _EligibilityScreenState extends State<EligibilityScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String uid;

  void _navigateToHomeScreen() {
    Navigator.of(context).pop(); // Close the EligibilityScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            const NavigationbarScreen(), // Navigate to HomeScreen
      ),
    );
  }

  List<String> questions = [
    "Is Your Weight Over 50kg And Age Between 18-60?",
    "Are you suffering from any chronic disease like diabetes, cancer, etc.?",
    "Have you undergone tatoo in last 6 months?",
    "Have you Donated Blood in last 3 months?",
  ];
  int currentQuestionIndex = 0;
  List<String?> answers = [];

  @override
  void initState() {
    super.initState();
    getUserUid();
  }

  void getUserUid() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: TColors.primary,
      body: TPrimaryHeaderContainer(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'Assets2/mages/content/circle.png',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 180),
                  child: Text(
                    '${currentQuestionIndex + 1}/4',
                    style: TextStyle(
                      color: dark ? Colors.white : TColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4,
                      left: MediaQuery.of(context).size.width / 8.5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: dark ? TColors.white : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    height: 400,
                    width: 298,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            questions[currentQuestionIndex],
                            style: TextStyle(
                              color: dark
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : TColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _answerQuestion("Yes"),
                              icon: const Icon(Icons.check),
                              label: const Text("Yes"),
                              style: ElevatedButton.styleFrom(
                                overlayColor: Colors.greenAccent.shade100,
                                fixedSize: const Size(250, 40),
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton.icon(
                              onPressed: () => _answerQuestion("No"),
                              icon: const Icon(Icons.close),
                              label: const Text("No"),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 40),
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _answerQuestion(String answer) {
    setState(() {
      answers.add(answer);
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        bool isEligible = answers.length == 4 &&
            answers[0] == 'Yes' &&
            answers.sublist(1).every((ans) => ans == 'No');
        updateEligibility(isEligible ? 'true' : 'false');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: TColors.white,
              title: const Text("Survery Completed",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              content: Text(
                isEligible
                    ? "Congratulations! You are eligible to donate blood."
                    : "Sorry, you are not eligible to donate blood.",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _navigateToHomeScreen(); // Call _navigateToHomeScreen
                  },
                  child: const Text("OK",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                      )),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> updateEligibility(String eligibility) async {
    try {
      await _firestore.collection('Users').doc(uid).update({
        'Eligible': eligibility,
      });
    } catch (e) {
      print('Error updating eligibility: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error updating eligibility. Please try again later.'),
      ));
    }
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EligibilityScreen(),
  ));
}
