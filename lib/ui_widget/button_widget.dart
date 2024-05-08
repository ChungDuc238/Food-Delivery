import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/const.dart';

class ButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? bg;

  const ButtonWidget({super.key, this.width, this.height, required this.text, this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bg ?? Colors.green,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: Const.buttonText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
