import 'package:flutter/material.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const IconAndTextWidget(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Diamensions.iconSize24,
        ),
        const SizedBox(width: 5),
        SmallText(text: text)
      ],
    );
  }
}
