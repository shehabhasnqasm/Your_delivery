import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  double fontHeight;
  SmallText(
      {super.key,
      // this.color = const Color(0xFFccc7c5),
      this.color = const Color.fromARGB(255, 106, 103, 102),
      required this.text,
      this.size = 12,
      this.fontHeight = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w400,
          height: fontHeight),
    );
  }
}
