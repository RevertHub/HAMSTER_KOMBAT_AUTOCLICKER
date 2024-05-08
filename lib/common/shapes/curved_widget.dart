import 'package:flutter/material.dart';

class TCustomCurvedEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, lastCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondfirstcurve = Offset(0, size.height - 20);
    final secondlastcurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondfirstcurve.dx, secondfirstcurve.dy,
        secondlastcurve.dx, secondlastcurve.dy);

    final thirdFirstcurve = Offset(size.width, size.height - 20);
    final thirdLastcurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstcurve.dx, thirdFirstcurve.dy,
        thirdLastcurve.dx, thirdLastcurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
