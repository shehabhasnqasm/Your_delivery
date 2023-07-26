import 'package:flutter/material.dart';
import 'package:food_delivary/utils/diamensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40, //40
    this.iconSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size == 40 ? Diamensions.height40 : size,
      height: size == 40 ? Diamensions.height40 : size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            size == 40 ? Diamensions.height40 / 2 : size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize == 16 ? Diamensions.iconSize16 : iconSize,
      ),
    );
  }
}
