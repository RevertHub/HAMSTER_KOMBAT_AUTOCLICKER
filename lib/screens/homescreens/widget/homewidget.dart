import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:disaster_admin/common/shapes/circularshape.dart';
import 'package:disaster_admin/common/shapes/curved_widget.dart';
import 'package:disaster_admin/screens/homescreens/widget/category_open.dart';
import 'package:disaster_admin/screens/homescreens/widget/home_controller.dart';
import 'package:disaster_admin/utils/constants/colors.dart';
import 'package:disaster_admin/utils/constants/image_strings.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';
import 'package:disaster_admin/utils/helpers/helper_functions.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child, this.name ='',
  });
  final Widget child;
  final String  name;
  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      name: name,
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            child,
            Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.1),
                )),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                )),
                child,
          ],
        ),
      ),
    );
  }
}

class TCurvedEdgeWidget extends StatelessWidget {
  const TCurvedEdgeWidget({
    this.name = '',
    super.key,
    this.child,
  });
 final String name;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TCustomCurvedEdge(), child: child);
  }
}

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle = 'View All',
    this.onPressed,
    this.buttonColor,
  });
  final Color? textColor;
  final bool showActionButton;
final Color? buttonColor;
  final String title, buttonTitle;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: buttonColor ?? (dark ? TColors.white : TColors.dark),)))
      ],
    );
  }
}

class VerticaLImageText extends StatelessWidget {
  const VerticaLImageText({
    super.key,
    required this.image,
    required this.title,
    this.textcolor = TColors.white,
    this.backgroundColor,
    this.onTap,
  });
  final String image, title;
  final Color textcolor;
  final Color? backgroundColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              padding: const EdgeInsets.all(TSizes.md),
              decoration: BoxDecoration(
                  color:
                      backgroundColor ?? (dark ? TColors.black : TColors.white),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  color: (dark ? TColors.white : TColors.dark),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(
                width: 55,
                child: Center(
                  child: Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium!.apply(
                            color: textcolor,
                          )),
                ))
          ],
        ),
      ),
    );
  }
}

class THomeCategory extends StatelessWidget {
  const THomeCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List <String> category = ['Plants', 'Seeds', 'pots', 'Fertilizers' , 'Tools']; 
    final List <String> categoryimage = [TImages.plant, TImages.seeds,  TImages.pots,  TImages.fertilizers,  TImages.tools ,];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, index) {
          return  VerticaLImageText(
            image: categoryimage[index],
            title: category[index],
            onTap: ()=> Get.to(()=> CategoryOpen(category: category[index]),),
          );
        },
      ),
    );
  }
}

class CategoryBlock extends StatelessWidget {
  const CategoryBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List <String> category = ['Plants', 'Flowers', 'Seeds', 'Pots', 'Fertilizers' , 'Tools'];
        final List <String> categoryimage = [TImages.plant, TImages.seeds,  TImages.pots,  TImages.fertilizers,  TImages.tools ,];

    final dark = THelperFunctions.isDarkMode(context);

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (_, index) {
          return GestureDetector(
    //  / onTap: ()=> Get.to(()=> const SubCategoryScreen()),
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              padding: const EdgeInsets.all(TSizes.md),
              decoration: BoxDecoration(
                  color:
                      dark ? TColors.black : TColors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Image(
                  image:  AssetImage(categoryimage[index]),
                  fit: BoxFit.cover,
                  color: (dark ? TColors.white : TColors.dark),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(
                width: 55,
                child: Text(category[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color:  TColors.white,
                        )))
          ],
        ),
      ),
    );
        },
      ),
    );
  }
}

class TRoundedImage extends StatelessWidget {
  const TRoundedImage(
      {super.key,
      this.width,
      this.height,
      required this.imageUrl,
      this.applyImageRadius = false,
      this.border,
      this.backgroundColor ,
      this.fit = BoxFit.contain,
      this.padding,
      this.onPressed,
      this.isNetworkImage = false,
      this.borderRadius = TSizes.md});

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isNetworkImage;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(TSizes.md)),
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(TSizes.md)
                : BorderRadius.zero,
            child: Image(
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider,
              fit: fit,
            )),
      ),
    );
  }
}

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
  });
  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.changePageIndicator(index)),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  TCircularContainer(
                    width: 20,
                    height: 4,
                    backgroundColor: controller.carousalCurrentIndex.value == i
                        ? TColors.primary
                        : Colors.grey,
                    margin: 10,
                  )
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
     this.radius =TSizes.borderRadiusLg,
    this.child,
    this.showBorder = false,
    this.borderColor = TColors.borderPrimary,
    this.padding,
    this.margin,
    this.backgroundColor = TColors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container  (
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder
              ? Border.all(color: borderColor, width: 1)
              :null),
      child: child,
    );
  }
}
