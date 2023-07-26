import 'package:flutter/material.dart';
import 'package:food_delivary/utils/diamensions.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  TextOverflow textOverflow;
  BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.textOverflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Diamensions.font20 : size,
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
