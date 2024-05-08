import 'package:disaster_admin/components/log_button.dart';
import 'package:disaster_admin/components/log_textfield.dart';
import 'package:disaster_admin/screens/disaster/page_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function()? onTap;
  const SignUp({
    super.key,
    required this.onTap,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //controllers
  final emailController = TextEditingController();

  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  //signin
  void signUserUp() async {
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
      if (passwordcontroller.text == confirmpasswordcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordcontroller.text);
      } else {
        //error password
        signinErrorMessage("Password don't match!!!");
      }
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
                          height: 45,
                          width: 45,
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
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //password
                    LogTextField(
                      controller: confirmpasswordcontroller,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    //signin
                    LogButton(
                      text: "Sign Up",
                      onTap: signUserUp,
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
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Login ',
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
