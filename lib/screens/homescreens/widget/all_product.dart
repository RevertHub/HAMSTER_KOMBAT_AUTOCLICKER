import 'package:flutter/material.dart';
import 'package:disaster_admin/common/appbar.dart';
import 'package:disaster_admin/utils/constants/sizes.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title: Text(
          'Popular Product',
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        ),)
    );
  }
}