import 'package:flutter/material.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/app_icon.dart';
import 'package:food_delivary/view/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Diamensions.width20,
          top: Diamensions.width20,
          bottom: Diamensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Diamensions.width20),
          bigText,
        ],
      ),
    );
  }
}
