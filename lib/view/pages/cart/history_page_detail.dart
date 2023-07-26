import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivary/controller/history_controller.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/app_icon.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:food_delivary/view/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:food_delivary/utils/app_constants.dart';

class HistoryPageDetail extends StatelessWidget {
  final int indexOrder;
  const HistoryPageDetail({super.key, required this.indexOrder});

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

                //SizedBox(width: Diamensions.width20 * 5),
                GestureDetector(
                    onTap: () {
                      Get.offNamedUntil(
                          RouteHelper.getInitial(), (route) => false);
                    },
                    child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppCourse.mainColor,
                        iconSize: Diamensions.iconSize24)),
              ],
            ),
          ),
          GetBuilder<HistoryController>(builder: (historyController) {
            var productsTheOrder =
                historyController.itemsOrdersList[indexOrder];

            return productsTheOrder.isNotEmpty
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
                            itemCount: productsTheOrder.length,
                            itemBuilder: (_, index) {
                              // print(
                              //     "productsTheOrder[index].name!:${productsTheOrder[index].name!}");
                              return InkWell(
                                onTap: null,
                                child: Container(
                                  width: double.infinity,
                                  height: Diamensions.height20 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Diamensions.height15),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 2),
                                  decoration: BoxDecoration(
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
                                          color: Colors.purple,
                                          borderRadius: BorderRadius.circular(
                                              Diamensions.radius20),
                                        ),
                                        child: CachedNetworkImage(
                                            imageUrl: AppConstants.baseUrl +
                                                AppConstants.uploadUrl +
                                                productsTheOrder[index].img!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                                  child: SpinKitCubeGrid(
                                                    color: Colors.green,
                                                    size: 50.0,
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    // const Icon(Icons.error),
                                                    Image.asset(
                                                      "assets/images/image12.png",
                                                      fit: BoxFit.cover,
                                                    )),
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
                                              BigText(
                                                  text:
                                                      "${productsTheOrder[index].name!} ",
                                                  color: Colors.black54),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                      text:
                                                          "\$ ${productsTheOrder[index].price! * productsTheOrder[index].quantity!}",
                                                      color: Colors.redAccent),
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
                                                          onTap: null,
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: Diamensions
                                                                    .width10 /
                                                                2),
                                                        BigText(
                                                            text: productsTheOrder[
                                                                    index]
                                                                .quantity
                                                                .toString()), //popularProduct.ionCartItems.toString(), color: AppCourse.mainBlackColor),
                                                        SizedBox(
                                                            width: Diamensions
                                                                    .width10 /
                                                                2),
                                                        GestureDetector(
                                                          onTap: null,
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor,
                                                          ),
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
                : const Center(child: Text("data")
                    //  SpinKitCubeGrid(
                    //   color: Colors.green,
                    //   size: 50.0,
                    // ),
                    );
          }),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<HistoryController>(builder: (historyController) {
        var totalAmount = 0;
        var items = historyController.itemsOrdersList[indexOrder];
        if (items.isNotEmpty) {
          for (int i = 0; i < items.length; i++) {
            totalAmount += items[i].price! * items[i].quantity!;
          }
        }

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
          child: historyController.itemsOrdersList[indexOrder].isNotEmpty
              ? Container(
                  padding: EdgeInsets.only(
                      top: Diamensions.height20,
                      bottom: Diamensions.height20,
                      left: Diamensions.width20,
                      right: Diamensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Diamensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Diamensions.width10 / 2),
                      BigText(
                          text: "\$ ${totalAmount.toString()}",
                          color: AppCourse.mainBlackColor),
                      SizedBox(width: Diamensions.width10 / 2),
                    ],
                  ),
                )
              : Container(),
        );
      }),
    );
  }
}
