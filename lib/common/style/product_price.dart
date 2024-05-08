import 'package:flutter/material.dart';

class TProductPRice extends StatelessWidget {
  const TProductPRice({
    super.key,  this.currencySign = '₹', required this.price,  this.maxLines =1,  this.islarge = false,  this.lineThrough= false,
  });
final String currencySign;
final int price;
final int maxLines;
final bool islarge;
final bool lineThrough;
  @override
  Widget build(BuildContext context) {
    return Text(
    '$currencySign $price',
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    style: islarge? Theme.of(context).textTheme.headlineMedium!.apply(decoration: lineThrough?TextDecoration.lineThrough :null): Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough?TextDecoration.lineThrough :null),
                          );
  }
}
