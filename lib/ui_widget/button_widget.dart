import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/const.dart';

class ButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;

  const ButtonWidget({super.key, this.width, this.height, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: Const.buttonText,
        ),
      ),
    );
  }
}
