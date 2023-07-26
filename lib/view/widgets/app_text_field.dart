import 'package:flutter/material.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';

class AppTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  AppTextFiled(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.icon,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Diamensions.height20, right: Diamensions.height20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Diamensions.radius15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: const Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure ? true : false,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppCourse.yelowColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Diamensions.radius15),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Diamensions.radius15),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Diamensions.radius15),
          ),
        ),
      ),
    );
  }
}
