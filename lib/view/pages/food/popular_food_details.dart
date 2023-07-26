import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/app_column.dart';
import 'package:food_delivary/view/widgets/app_icon.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:food_delivary/view/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetailes extends StatefulWidget {
  final int pageId;
  final String page;
  const PopularFoodDetailes(
      {super.key, required this.pageId, required this.page});

  @override
  State<PopularFoodDetailes> createState() => _PopularFoodDetailesState();
}

class _PopularFoodDetailesState extends State<PopularFoodDetailes> {
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProducsController>().popularProducList[widget.pageId];

    // Get.put<CartController>();
    Get.find<PopularProducsController>().init(
      Get.find<CartController>(),
      product: product,
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // show background image
            Positioned(
                left: 0.0,
                right: 0.0,
                child: Container(
                  width: double.infinity,
                  height: Diamensions.popularFoodImageSize,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(AppConstants.baseUrl +
                            AppConstants.uploadUrl +
                            product.img!),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) => Image.asset(
                            "assets/images/food14.png",
                            fit: BoxFit.cover),
                        // AssetImage("assets/images/food0.png")
                      )),
                )),
            //show icons in the top screen
            Positioned(
                top: Diamensions.height45,
                left: Diamensions.height20,
                right: Diamensions.height20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const AppIcon(
                          icon: Icons.arrow_back_ios,
                          backgroundColor: AppCourse.mainColor,
                          iconColor: Colors.white,
                        )),
                    GetBuilder<PopularProducsController>(builder: (controller) {
                      return widget.page == 'cartPage'
                          ? GestureDetector(
                              onTap: null,
                              child: Stack(
                                children: [
                                  controller.totalItems > 0
                                      ? Positioned(
                                          child: Badge(
                                          alignment: Alignment.topRight,
                                          toAnimate: true,
                                          shape: BadgeShape.circle,
                                          position: BadgePosition.topEnd(
                                              top: -7, end: 0),
                                          badgeColor: AppCourse.signColor,
                                          // borderRadius: BorderRadius.only(
                                          //     bottomRight: Radius.circular(8)),
                                          badgeContent: Text(
                                              controller.totalItems.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          child: const AppIcon(
                                              icon:
                                                  Icons.shopping_cart_outlined),
                                        ))
                                      : const AppIcon(
                                          icon: Icons.shopping_cart_outlined),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (controller.totalItems > 0) {
                                  //Get.toNamed(RouteHelper.getCartPage());
                                  Get.toNamed(RouteHelper.getCartPage())
                                      ?.then((value) {
                                    setState(() {});
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  controller.totalItems > 0
                                      ? Positioned(
                                          child: Badge(
                                          alignment: Alignment.topRight,
                                          toAnimate: true,
                                          shape: BadgeShape.circle,
                                          position: BadgePosition.topEnd(
                                              top: -7, end: 0),
                                          badgeColor: AppCourse.mainColor,
                                          // borderRadius: BorderRadius.only(
                                          //     bottomRight: Radius.circular(8)),
                                          badgeContent: Text(
                                              controller.totalItems.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          child: const AppIcon(
                                              icon:
                                                  Icons.shopping_cart_outlined),
                                        ))
                                      : const AppIcon(
                                          icon: Icons.shopping_cart_outlined),
                                ],
                              ),
                            );
                    }),
                  ],
                )),
            // show information detaile
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              top: Diamensions.popularFoodImageSize - 30,
              child: Container(
                padding: EdgeInsets.only(
                    left: Diamensions.width20,
                    right: Diamensions.width20,
                    top: Diamensions.height15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Diamensions.radius30),
                        topRight: Radius.circular(Diamensions.radius30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      roductModel: product,
                    ),
                    SizedBox(
                      height: Diamensions.height10,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Diamensions.height10,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ExpandableTextWidget(
                        text: product.description!,
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
        //______________ bottom _____________
        bottomNavigationBar: GetBuilder<PopularProducsController>(
          builder: (popularProductController) {
            return Container(
              //height: 100,
              padding: EdgeInsets.only(
                  top: Diamensions.height15,
                  bottom: Diamensions.height20,
                  right: Diamensions.width20,
                  left: Diamensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Diamensions.radius20 * 2),
                      topLeft: Radius.circular(Diamensions.radius20 * 2)),
                  color: AppCourse.buttomBackgroundColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: popularProductController.quantity == 0
                              ? null
                              : () {
                                  popularProductController
                                      .decreassItem(product);
                                },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppCourse.mainColor),
                            child: Icon(
                              Icons.remove,
                              color: popularProductController.quantity > 0
                                  ? Colors.white
                                  : AppCourse.signColor,
                              size: Diamensions.height30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Diamensions.width10,
                        ),
                        CircleAvatar(
                          backgroundColor:
                              popularProductController.isSameQuantity
                                  ? AppCourse.yelowColor
                                  : Colors.transparent,
                          child: BigText(
                            text: popularProductController.quantity.toString(),
                          ),
                        ),
                        SizedBox(
                          width: Diamensions.width10,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: AppCourse.mainColor,
                          onTap: () {
                            popularProductController.increasItem(product);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppCourse.mainColor),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: Diamensions.height30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Diamensions.width10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        popularProductController.addItem(product);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: Diamensions.height20,
                              bottom: Diamensions.height20,
                              right: Diamensions.height20,
                              left: Diamensions.height20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Diamensions.radius20),
                              color: AppCourse.mainColor),
                          child: BigText(
                            text: "\$ ${product.price} add to cart",
                            textOverflow: TextOverflow.ellipsis,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
