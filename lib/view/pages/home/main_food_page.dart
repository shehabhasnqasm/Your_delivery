import 'package:flutter/material.dart';
import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/controller/recomended_products_controller.dart';
import 'package:food_delivary/view/pages/home/drawer.dart';
import 'package:food_delivary/view/pages/home/food_page_body.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> loadResourse() async {
    await Get.find<PopularProducsController>().getPopularProductList();
    await Get.find<RecomendedProducsController>().getRecomendedProductList();
    Get.find<CartController>().startGetDataFromSharedPref();
  }

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // print("screeen sheight:${MediaQuery.of(context).size.height}");
    // print("screeen sheight:${MediaQuery.of(context).size.width}");

    return RefreshIndicator(
      backgroundColor: AppCourse.mainColor,
      color: Colors.white,
      onRefresh: loadResourse,
      child: Scaffold(
        key: key,
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            // show header
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Diamensions.height45, bottom: Diamensions.height15),
                padding: EdgeInsets.only(
                    left: Diamensions.height20, right: Diamensions.height20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        key.currentState?.openDrawer();
                      },
                      child: Center(
                        child: Container(
                          height: Diamensions.height45,
                          width: Diamensions.height45,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Diamensions.radius15),
                              color: AppCourse.mainColor),
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: Diamensions.iconSize24,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Y",
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 28),
                        ),
                        BigText(
                          text: "our Delivery",
                          color: AppCourse.mainColor,
                          size: 28,
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        height: Diamensions.height45,
                        width: Diamensions.height45,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Diamensions.radius15),
                            color: AppCourse.mainColor),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Diamensions.iconSize24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //show body
            const Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
