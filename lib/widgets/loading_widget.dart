import 'package:flutter/material.dart';
import 'package:flutter_wishlist_app/helpers.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: appColor,
        ),
      ),
    );
  }
}
