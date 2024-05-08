import 'package:flutter/material.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/device/device_utility.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget  implements PreferredSizeWidget{
  const TTabBar({super.key, required this.tabs});


final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark? TColors.black: TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        labelColor: dark? TColors.white: TColors.primary,
        unselectedLabelColor: TColors.darkerGrey,
        indicatorColor:  TColors.primary,
       
      )
    );
  }
  
 @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
