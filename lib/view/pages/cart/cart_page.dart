import 'package:flutter/material.dart';
import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/controller/history_controller.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/controller/recomended_products_controller.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:food_delivary/view/widgets/base/show_custom_snakbar.dart';
import 'package:food_delivary/view/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../../utils/routes/router_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/diamensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void refreshData() {
    /////
    // for refresh -the updated values that happened in cart page- to appear in
    // PopularFoodDetaile page (e.g: items count ,..)
    Get.find<PopularProducsController>().init(
      Get.find<CartController>(),
    );
    Get.find<PopularProducsController>().refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Diamensions.height20 * 3,
            left: Diamensions.width20,
            right: Diamensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ////////////// /*
                GestureDetector(
                  onTap: () {
                    //Navigator.canPop(context) ? Navigator.pop(context) : null;
                    Get.back();
                  },
                  child: AppIcon(
                      icon: Icons.arrow_back_ios_new,
                      iconColor: Colors.white,
                      backgroundColor: AppCourse.mainColor,
                      iconSize: Diamensions.iconSize24),
                ),
                // or
                // Container(
                //     decoration: ShapeDecoration(
                //         color: AppCourse.mainColor, shape: CircleBorder()),
                //     child: const BackButton(
                //       color: Colors.white,
                //     )),
                // */ ////////////////
                SizedBox(width: Diamensions.width20 * 5),
                GestureDetector(
                    onTap: () {
                      //Get.toNamed(RouteHelper.getInitial());
                      // Get.offNamed(RouteHelper.getInitial());
                      Get.offNamedUntil(
                          RouteHelper.getInitial(), (route) => false);

                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const HomePage()),
                      //     (route) => false);
                    },
                    child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppCourse.mainColor,
                        iconSize: Diamensions.iconSize24)),
                AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppCourse.mainColor,
                    iconSize: Diamensions.iconSize24),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            var hcardList = cartController.getItems;
            return hcardList.isNotEmpty
                ? Positioned(
                    top: Diamensions.height20 * 5,
                    left: Diamensions.width20,
                    right: Diamensions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Diamensions.height15),
                      // color: Colors.red,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: hcardList.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProducsController>()
                                          .popularProducList
                                          .indexOf(hcardList[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, "cartPage"));
                                  } else {
                                    var recomendedIndex =
                                        Get.find<RecomendedProducsController>()
                                            .recomendedProducList
                                            .indexOf(hcardList[index].product!);
                                    if (recomendedIndex >= 0) {
                                      Get.toNamed(RouteHelper.getRecomendedFood(
                                          recomendedIndex, "cartPage"));
                                    } else {
                                      int indexInPopular =
                                          Get.find<PopularProducsController>()
                                              .getIndex(
                                                  hcardList[index].id ?? -1);

                                      if (indexInPopular >= 0) {
                                        Get.toNamed(RouteHelper.getPopularFood(
                                            indexInPopular, "cartPage"));
                                      } else {
                                        int indexInRecomended = Get.find<
                                                RecomendedProducsController>()
                                            .getIndex(
                                                hcardList[index].id ?? -1);

                                        if (indexInRecomended >= 0) {
                                          Get.toNamed(
                                              RouteHelper.getRecomendedFood(
                                                  indexInRecomended,
                                                  "cartPage"));
                                        } else {
                                          Get.snackbar("History product",
                                              "Product review is not availble for history product!",
                                              backgroundColor:
                                                  AppCourse.mainColor,
                                              colorText: Colors.white);
                                        }
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: Diamensions.height15),
                                  width: double.maxFinite,
                                  height: Diamensions.height20 * 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            Diamensions.radius20),
                                        bottomRight: Radius.circular(
                                            Diamensions.radius20)),
                                    color: AppCourse.buttomBackgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Diamensions.height20 * 5,
                                        height: Diamensions.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Diamensions.height10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Diamensions.radius20),
                                          // image: const DecorationImage(
                                          //     image: AssetImage(
                                          //         "assets/images/food0.png"),
                                          //     fit: BoxFit.cover)
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                AppConstants.baseUrl +
                                                    AppConstants.uploadUrl +
                                                    cartController
                                                        .getItems[index].img!),
                                            fit: BoxFit.cover,
                                            onError: (exception, stackTrace) =>
                                                Image.asset(
                                              "assets/images/food0.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Diamensions.width10),
                                      Expanded(
                                        child: SizedBox(
                                          height: Diamensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: BigText(
                                                      text: hcardList[index]
                                                          .name!,
                                                      color: Colors.black,
                                                      textOverflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cartController
                                                          .removeProduct(
                                                              hcardList[index]
                                                                  .product!);
                                                      refreshData();
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 1, right: 3),
                                                      padding: EdgeInsets.all(
                                                          Diamensions.height10 /
                                                              2),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .orange.shade100
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: const Icon(
                                                          Icons.close_sharp,
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                      text:
                                                          "\$ ${hcardList[index].price! * hcardList[index].quantity!}",
                                                      color: Colors.red),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Diamensions
                                                            .height10,
                                                        bottom: Diamensions
                                                            .height10,
                                                        left:
                                                            Diamensions.width10,
                                                        right: Diamensions
                                                            .width10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Diamensions
                                                                  .radius20),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            // cartController.addItem(_cartList[index].product!, -1);
                                                            cartController.minusItem(
                                                                hcardList[index]
                                                                    .product!);
                                                            refreshData();
                                                          },
                                                          child: const Icon(
                                                              Icons.remove,
                                                              color: AppCourse
                                                                  .pareColor),
                                                        ),
                                                        SizedBox(
                                                            width: Diamensions
                                                                    .width10 /
                                                                2),
                                                        BigText(
                                                            text: hcardList[
                                                                    index]
                                                                .quantity
                                                                .toString()), //popularProduct.ionCartItems.toString(), color: AppCourse.mainBlackColor),
                                                        SizedBox(
                                                            width: Diamensions
                                                                    .width10 /
                                                                2),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.plusItem(
                                                                hcardList[index]
                                                                    .product!);
                                                            refreshData();
                                                          },
                                                          child: const Icon(
                                                              Icons.add,
                                                              color: AppCourse
                                                                  .pareColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Image.asset(
                          "assets/images/puplic/no_meals.png",
                          // imgPath,
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: double.maxFinite,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "No orders yet !",
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  );
          }),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
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
          child: cartController.getItems.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      child: Row(
                        children: [
                          SizedBox(width: Diamensions.width10 / 2),
                          BigText(
                              text:
                                  "\$ ${cartController.totalAmount.toString()}",
                              color: AppCourse.mainBlackColor),
                          SizedBox(width: Diamensions.width10 / 2),
                        ],
                      ),
                    ),
                    GetBuilder<HistoryController>(builder: (historyController) {
                      return GestureDetector(
                        onTap: () async {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            int quantityOfInsertedItems =
                                await historyController.insertdata(
                                    AppConstants.tableName,
                                    cartController.getItems);

                            if (quantityOfInsertedItems ==
                                cartController.getItems.length) {
                              Get.snackbar("success insert",
                                  "good , inserted all cart items",
                                  backgroundColor: AppCourse.mainColor,
                                  colorText: Colors.white);
                              cartController.clear();
                              refreshData();
                            } else if (quantityOfInsertedItems > 0) {
                              Get.snackbar(
                                  "sorry",
                                  '''  inserted only $quantityOfInsertedItems item ; from total ${cartController.getItems.length}
                               items ''',
                                  backgroundColor: AppCourse.mainColor,
                                  colorText: Colors.white);
                            } else {
                              Get.snackbar("sorry", " filure to insert items ",
                                  backgroundColor: AppCourse.mainColor,
                                  colorText: Colors.white);
                            }
                          } else {
                            showCustomSnackBar("Must log in !", title: "Sorry");
                            Get.toNamed(RouteHelper.getLogInPage());
                          }
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
                          child:
                              BigText(text: "| Check out", color: Colors.white),
                        ),
                      );
                    }),
                  ],
                )
              : Container(),
        );
      }),
    );
  }
}
