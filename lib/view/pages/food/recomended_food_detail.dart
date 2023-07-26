import 'package:badges/badges.dart';
import "package:flutter/material.dart";
import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/controller/recomended_products_controller.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/app_icon.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:food_delivary/view/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../../utils/routes/router_helper.dart';

class RecomendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecomendedFoodDetail(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecomendedProducsController>().recomendedProducList[pageId];
    Get.find<PopularProducsController>().init(
      Get.find<CartController>(),
      product: product,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            // appbar icons
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const AppIcon(
                      icon: Icons.clear,
                      backgroundColor: AppCourse.mainColor,
                      iconColor: Colors.white,
                    )),
                GetBuilder<PopularProducsController>(builder: (controller) {
                  return page == 'cartPage'
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
                                      position:
                                          BadgePosition.topEnd(top: -7, end: 0),
                                      badgeColor: AppCourse.signColor,
                                      // borderRadius: BorderRadius.only(
                                      //     bottomRight: Radius.circular(8)),
                                      badgeContent: Text(
                                          controller.totalItems.toString(),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      child: const AppIcon(
                                          icon: Icons.shopping_cart_outlined),
                                    ))
                                  : const AppIcon(
                                      icon: Icons.shopping_cart_outlined),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (controller.totalItems > 0) {
                              Get.toNamed(RouteHelper.getCartPage());
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
                                      position:
                                          BadgePosition.topEnd(top: -7, end: 0),
                                      badgeColor: AppCourse.mainColor,
                                      // borderRadius: BorderRadius.only(
                                      //     bottomRight: Radius.circular(8)),
                                      badgeContent: Text(
                                          controller.totalItems.toString(),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      child: const AppIcon(
                                          icon: Icons.shopping_cart_outlined),
                                    ))
                                  : const AppIcon(
                                      icon: Icons.shopping_cart_outlined),
                            ],
                          ),
                        );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Diamensions.radius20),
                    topRight: Radius.circular(Diamensions.radius20),
                  ),
                ),
                child: Center(
                    child:
                        BigText(text: product.name!, size: Diamensions.font26)),
              ),
            ),

            pinned: true,
            backgroundColor: AppCourse.yelowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.baseUrl + AppConstants.uploadUrl + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Diamensions.width20, right: Diamensions.width20),
                  child: ExpandableTextWidget(text: product.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      //________________ bottom ___________
      bottomNavigationBar: GetBuilder<PopularProducsController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Diamensions.width20 * 2.5,
                    right: Diamensions.width20 * 2.5,
                    top: Diamensions.height10,
                    bottom: Diamensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        //borderRadius: BorderRadius.circular(20),
                        // splashColor: controller.quantity == 0
                        //     ? null
                        //     : AppCourse.yelowColor,
                        onTap: () {
                          controller.quantity == 0
                              ? null
                              : controller.decreassItem(product);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppCourse.mainColor,
                          ),
                          child: Icon(
                            Icons.remove,
                            color: controller.quantity > 0
                                ? Colors.white
                                : AppCourse.signColor,
                            size: Diamensions.height30,
                          ),
                        )),
                    Container(
                      child: Row(
                        children: [
                          BigText(
                            text:
                                "\$ ${controller.totalPriceProductItems.toStringAsFixed(1)} X ",
                            color: AppCourse.mainBlackColor,
                          ),
                          CircleAvatar(
                            backgroundColor: controller.isSameQuantity
                                ? AppCourse.yelowColor
                                : Colors.transparent,
                            child: BigText(
                              text: "${controller.quantity} ",
                              color: controller.isSameQuantity
                                  ? Colors.white
                                  : AppCourse.mainBlackColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      // borderRadius: BorderRadius.circular(20),
                      // splashColor: AppCourse.mainColor,
                      onTap: () {
                        controller.increasItem(product);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppCourse.mainColor,
                        ),
                        //color: AppCourse.mainColor,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: Diamensions.height30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Diamensions.bottomHeightBar,
                padding: EdgeInsets.only(
                    top: Diamensions.height30,
                    bottom: Diamensions.height30,
                    right: Diamensions.width20,
                    left: Diamensions.width20),
                decoration: BoxDecoration(
                  color: AppCourse.buttomBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Diamensions.radius20 * 2),
                    topRight: Radius.circular(Diamensions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // favorite icon
                    Container(
                      padding: EdgeInsets.only(
                          top: Diamensions.height20,
                          bottom: Diamensions.height20,
                          left: Diamensions.width20,
                          right: Diamensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Diamensions.radius20),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.favorite,
                          color: AppCourse.mainColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
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
                          color: AppCourse.mainColor,
                        ),
                        child: BigText(
                            text: "\$ ${product.price} | Add to cart",
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
