import 'package:flutter/material.dart';
import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:get/get.dart';

import '../../../utils/diamensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "I am orintting laoding state ${Get.find<AuthController>().isLoading}");
    return Center(
      child: Container(
        height: Diamensions.height20 * 5,
        width: Diamensions.height20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Diamensions.height20 * 5 / 2),
          color: AppCourse.mainColor,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
