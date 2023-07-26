import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/controller/recomended_products_controller.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> loadResourse() async {
    await Get.find<PopularProducsController>().getPopularProductList();
    await Get.find<RecomendedProducsController>().getRecomendedProductList();
    Get.find<CartController>().startGetDataFromSharedPref();
  }

  @override
  void initState() {
    super.initState();
    loadResourse();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(const Duration(seconds: 3), () {
      Get.offNamed(RouteHelper.getInitial());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/images/puplic/deedees_logo.jpg",
                width: Diamensions.splashImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo_part_2.png",
              width: Diamensions.splashImg,
            ),
          )
        ],
      ),
    );
  }
}
