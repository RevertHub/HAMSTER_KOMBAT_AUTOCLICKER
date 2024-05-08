import 'package:disaster_admin/components/log_button.dart';
import 'package:disaster_admin/components/log_textfield.dart';
import 'package:disaster_admin/screens/disaster/page_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controllers
  final emailController = TextEditingController();

  final passwordcontroller = TextEditingController();

  //signin
  void signUserIn() async {
    //load
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //signin

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordcontroller.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      signinErrorMessage(e.code);
    }
  }

  void signinErrorMessage(String m) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 64, 186, 68),
          title: Center(
            child: Text(
              m,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        pagemodel1(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 49,
                    ),
                    //musicapp logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "Assets2/Images/l1.png",
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //Hola Amigo
                    const Text(
                      "Welcome",
                      style: TextStyle(
                        color: Color.fromARGB(255, 88, 227, 93),
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 23,
                    ),

                    //username
                    LogTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //password
                    LogTextField(
                      controller: passwordcontroller,
                      hintText: 'Secret Password',
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //forgot
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 103, 103, 103)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    //signin
                    LogButton(
                      text: "Sign In",
                      onTap: signUserIn,
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    //or op

                    const SizedBox(
                      height: 40,
                    ),

                    //signup
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Not a member Yet?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 103, 103, 103)),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
