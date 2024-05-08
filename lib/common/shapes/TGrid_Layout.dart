import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/productcardvertical_controller.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {

   TGridLayout({super.key, required this.itemCount, this.mainAxisExtent =288, required this.itemBuilder});

final int itemCount;
final double? mainAxisExtent;
final Widget Function(BuildContext,int) itemBuilder;
  final ProductcardverticalController controller =
      Get.put(ProductcardverticalController());

  @override
  Widget build(BuildContext context) {
    
    return  GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: TSizes.gridViewSpacing,
                crossAxisSpacing: TSizes.gridViewSpacing,
                mainAxisExtent: mainAxisExtent),
            itemBuilder: (_, index) => itemBuilder(context,index),
            itemCount: itemCount,
            shrinkWrap: true,
          );
  }
}