
import 'package:flutter/material.dart';
import 'package:disaster_admin/utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
 const  TCircularContainer({
    super.key, this.width =400, this.height =400, this.radius =400, this.padding=0, this.child, this.backgroundColor=TColors.textWhite, this.margin=0 
  });
final double? width;
final double? height;
final double radius;
final double padding;
final Widget? child;
final Color? backgroundColor;
final double margin;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:   EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor

      ),
      child: child,
    );
  }
}