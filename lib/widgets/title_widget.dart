import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'RareList',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.brown.shade800,
        fontSize: 74,
        fontWeight: FontWeight.w200,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}
