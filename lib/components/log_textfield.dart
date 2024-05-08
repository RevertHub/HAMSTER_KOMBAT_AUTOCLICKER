import 'package:flutter/material.dart';

class LogTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const LogTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(31, 15, 15, 15)),
          ),
          fillColor: const Color.fromARGB(255, 233, 232, 232),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 152, 151, 151)),
        ),
      ),
    );
  }
}
