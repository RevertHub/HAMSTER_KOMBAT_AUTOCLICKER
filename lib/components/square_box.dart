import 'package:flutter/material.dart';

class SquareBox extends StatelessWidget {
  final String imagepath;
  final Function()? onTap;
  const SquareBox({super.key, required this.imagepath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        child: Image.asset(
          imagepath,
          height: 50,
        ),
      ),
    );
  }
}
