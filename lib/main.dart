import 'package:flutter/material.dart';
import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/controller/history_controller.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/controller/recomended_products_controller.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';

import 'package:get/get.dart';
import 'package:food_delivary/utils/depindency/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>();
    Get.find<HistoryController>();
    return GetBuilder<PopularProducsController>(
      builder: (_) {
        return GetBuilder<RecomendedProducsController>(builder: (_) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //home: const MainFoodPage(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
            //initialBinding: DependencyInjection(),
          );
        });
      },
    );
  }
}
