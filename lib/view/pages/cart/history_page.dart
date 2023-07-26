import 'package:flutter/material.dart';
import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/controller/history_controller.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:food_delivary/view/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/diamensions.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthController>().userLoggedIn()) {
      Get.find<HistoryController>().getCartHistoryData();
    } else {
      Get.find<HistoryController>().clearHistoryList();
    }
    Widget timeWidget(String timeDate) {
      //print("$timeDate"); //2023-01-05 03:09:51.112110
      String date =
          DateFormat("yyyy/M/d 'at' h:mm a").format(DateTime.parse(timeDate));

      return BigText(text: date);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: Diamensions.height45),
              // color: AppCourse.mainColor,
              width: double.maxFinite,
              height: Diamensions.height10 * 10,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BigText(
                      text: "Cart History",
                    ),
                  ),
                ],
              )),
          GetBuilder<HistoryController>(builder: (historyController) {
            return historyController.idLoaded
                ? historyController.resultData.isNotEmpty
                    ? Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Diamensions.height20,
                              left: Diamensions.width10,
                              right: Diamensions.width10),
                          child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  // shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: historyController.getkeys.length,
                                  //itemCount: 30,
                                  itemBuilder: ((context, i) {
                                    var key = historyController.getkeys[i];
                                    var count = historyController
                                        .countItemsOrdersList[i];

                                    return Container(
                                      // height: Diamensions.height20 * 6,
                                      color: Colors.orange.shade100,
                                      margin: EdgeInsets.only(
                                          bottom: Diamensions.height20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          timeWidget(key.toString()),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(
                                                direction: Axis.horizontal,
                                                children: List.generate(count,
                                                    (index) {
                                                  return index <= 2
                                                      ? Container(
                                                          height: Diamensions
                                                                  .height20 *
                                                              4,
                                                          width: Diamensions
                                                                  .height20 *
                                                              4,
                                                          margin: EdgeInsets.only(
                                                              right: Diamensions
                                                                      .width10 /
                                                                  2),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Diamensions
                                                                            .radius15 /
                                                                        2),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                AppConstants
                                                                        .baseUrl +
                                                                    AppConstants
                                                                        .uploadUrl +
                                                                    historyController
                                                                        .itemsOrdersList[
                                                                            i][
                                                                            index]
                                                                        .img!,
                                                              ),
                                                              fit: BoxFit.cover,
                                                              onError: (exception,
                                                                      stackTrace) =>
                                                                  Image.asset(
                                                                "assets/images/image0.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container();
                                                }),
                                              ),
                                              Container(
                                                // height:
                                                //     Diamensions.height20 * 5,

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SmallText(
                                                        text: "Total",
                                                        color: AppCourse
                                                            .titleColor),
                                                    BigText(
                                                      text:
                                                          "${historyController.countItemsOrdersList[i].toString()} Items", //historyController.countItemsOrdersList[i]
                                                      // text: "4 Items",
                                                      color:
                                                          AppCourse.titleColor,
                                                      size: Diamensions.font20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(RouteHelper
                                                            .gethistoryPageDetail(
                                                                i));
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                Diamensions
                                                                    .width10,
                                                            vertical: Diamensions
                                                                    .height10 /
                                                                2),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Diamensions
                                                                      .radius15),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppCourse
                                                                  .mainColor),
                                                        ),
                                                        child: SmallText(
                                                            text: "one more",
                                                            color: AppCourse
                                                                .mainColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }))),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      )
                : const Center(
                    child: CircularProgressIndicator(
                      color: AppCourse.mainColor,
                    ),
                  );
          })
        ],
      ),
    );
  }
}
