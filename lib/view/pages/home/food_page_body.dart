import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/controller/recomended_products_controller.dart';
import 'package:food_delivary/model/product_model.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/view/widgets/app_column.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:food_delivary/view/widgets/small_text.dart';

import '../../../utils/diamensions.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Diamensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Diamensions.height20),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(left: Diamensions.width30),
          child: BigText(
            text: "Popular",
          ),
        ),
        SizedBox(height: Diamensions.height20),
        //show page veiw sliders for popular products
        GetBuilder<PopularProducsController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  //color: Colors.red,
                  height: Diamensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProducList.length,
                      itemBuilder: (context, position) {
                        return _pageItem(position,
                            popularProducts.popularProducList[position]);
                      }),
                )
              : const CircularProgressIndicator(
                  color: AppCourse.mainColor,
                );
        }),
        // show dots indicator
        GetBuilder<PopularProducsController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProducList.isEmpty
                ? 1
                : popularProducts.popularProducList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppCourse.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              color: Colors.grey, // Inactive color
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Diamensions.height20)),
            ),
          );
        }),
        SizedBox(height: Diamensions.height30),
        // show recommended text
        Container(
          margin: EdgeInsets.only(left: Diamensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  width: Diamensions.screenWidth * 0.40,
                  child: BigText(text: "All meals")),
              SizedBox(width: Diamensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Diamensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 1),
                child: SmallText(text: "Food pairing"),
              ),
            ],
          ),
        ),
        // show list of all  meals
        GetBuilder<RecomendedProducsController>(builder: (recomendedProducts) {
          return recomendedProducts.isLoaded
              ? ListView.builder(
                  itemCount: recomendedProducts.recomendedProducList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    bool isLost = true;

                    String? img =
                        recomendedProducts.recomendedProducList[index].img;
                    if (img == null) {
                      isLost = true;
                    } else {
                      if (img.isEmpty) {
                        isLost = true;
                      } else {
                        isLost = false;
                      }
                    }
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecomendedFood(index, "home"));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: EdgeInsets.only(
                            left: Diamensions.width20,
                            right: Diamensions.width20,
                            bottom: Diamensions.height10),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: AppCourse.mainColor.withOpacity(0.6),
                            blurRadius: 5.0,
                            offset: const Offset(0, 1),
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5, 0),
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(5, 0),
                          )
                        ]),
                        child: Row(
                          children: [
                            //images container
                            Container(
                                height: Diamensions.listViewImageSize,
                                width: Diamensions.listViewImageSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Diamensions.radius20),
                                  color: Colors.white38,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Diamensions.radius20),
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.baseUrl +
                                        AppConstants.uploadUrl +
                                        img!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                      color: AppCourse.mainColor,
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                )),

                            //text container
                            Expanded(
                              child: Container(
                                height: Diamensions.listViewTextConatinerSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Diamensions.radius20),
                                    bottomRight:
                                        Radius.circular(Diamensions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Diamensions.width10,
                                      right: Diamensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recomendedProducts
                                              .recomendedProducList[index]
                                              .name!),
                                      SizedBox(height: Diamensions.height10),
                                      SmallText(text: "arabic meals "),
                                      SizedBox(height: Diamensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Wrap(
                                                children: List.generate(
                                                    recomendedProducts
                                                            .recomendedProducList[
                                                                index]
                                                            .stars ??
                                                        5, (index) {
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors
                                                        .amber, //AppCourse.mainColor,
                                                    size: 15,
                                                  );
                                                }),
                                              ),
                                              SizedBox(
                                                  width: Diamensions.width10),
                                              SmallText(
                                                  text:
                                                      "${recomendedProducts.recomendedProducList[index].stars}/5"),
                                            ],
                                          ),
                                          Card(
                                              color: AppCourse.mainColor,
                                              margin: EdgeInsets.only(
                                                  left: Diamensions.width10,
                                                  right: Diamensions.width10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SmallText(
                                                  text:
                                                      "${recomendedProducts.recomendedProducList[index].price} \$",
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const CircularProgressIndicator(
                  color: AppCourse.mainColor,
                );
        }),
      ],
    );
  }

  Widget _pageItem(int index, ProductModel popularProduct) {
    // to animate PageView items
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index, "home"));
          }, child: GetBuilder<PopularProducsController>(
            builder: (popularProductController) {
              String? img =
                  popularProductController.popularProducList[index].img;

              return Container(
                height: Diamensions.pageViewContainer,
                width: double.maxFinite,
                margin: EdgeInsets.only(
                    left: Diamensions.width10, right: Diamensions.width10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Diamensions.radius30),
                  color: index.isEven ? Colors.purple : Colors.blue,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Diamensions.radius20),
                  child: CachedNetworkImage(
                    imageUrl:
                        AppConstants.baseUrl + AppConstants.uploadUrl + img!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                      color: AppCourse.mainColor,
                    )),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/image12.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  left: Diamensions.width30,
                  right: Diamensions.width30,
                  bottom: Diamensions.height30),
              // height: Diamensions.pageViewTextContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Diamensions.radius30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),

              child: Container(
                padding: EdgeInsets.only(
                    left: Diamensions.width15,
                    right: Diamensions.width15,
                    top: Diamensions.height15),
                child: AppColumn(
                  roductModel: popularProduct,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Card(
                color: AppCourse.yelowColor.withOpacity(0.7),
                margin: EdgeInsets.only(
                    left: Diamensions.width10, right: Diamensions.width10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${popularProduct.price}\$",
                    style: const TextStyle(color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
