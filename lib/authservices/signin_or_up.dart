import 'package:disaster_admin/authservices/siginin_screen.dart';
import 'package:disaster_admin/authservices/signup_screen.dart';
import 'package:flutter/material.dart';

class SignInOrUp extends StatefulWidget {
  const SignInOrUp({super.key});

  @override
  State<SignInOrUp> createState() => _SignInOrUpState();
}

class _SignInOrUpState extends State<SignInOrUp> {
//sign in first always
  bool showSigninPage = true;

  //signin/up
  void togglePages() {
    setState(() {
      showSigninPage = !showSigninPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSigninPage) {
      return LoginScreen(onTap: togglePages);
    } else {
      return SignUp(
        onTap: togglePages,
      );
    }
  }
}
