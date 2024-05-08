import 'package:flutter/material.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

class TshimmerEffect extends StatelessWidget {
  const TshimmerEffect({super.key, required this.height, required this.width,  this.radius =15, this.color,});

final double height,width,radius;
final Color? color;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor:  dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color:color??(dark ? TColors.darkerGrey : TColors.white),
          borderRadius: BorderRadius.circular(radius)
        ),
      )
    );
  }
}