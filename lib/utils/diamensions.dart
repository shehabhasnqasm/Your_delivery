import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Diamensions {
  /*
 Get.context!.height == MediaQuery.of(context).size.height
 
 // static double screenHeight = Get.context!.height;
// static double screenWidth = Get.context!.width;
 
  */

  //screenHeight == 797.7142857142857
  static double screenHeight = Get.context!.height;

  //screenWidth == 411.42857142857144
  static double screenWidth = Get.context!.width;

  // screen height is = => 797.7142857142857 ;
  static double pageView = screenHeight / 2.49; // 320 ;; 2.49 == 797.7 / 320
  static double pageViewContainer = screenHeight / 3.62; // 220
  static double pageViewTextContainer = screenHeight / 6.65; // 120

  // dynamic height =>  padding and margin
  static double height10 = screenHeight / 79.7; //  => 10
  static double height15 = screenHeight / 53.18; //  => 15
  static double height20 = screenHeight / 39.88; // => 20
  static double height30 = screenHeight / 26.59; //  => 30
  static double height40 = screenHeight / 19.9; //  => 40
  static double height45 = screenHeight / 17.72; //  => 45

  //dinamic weight => padding and margin
  static double width10 = screenHeight / 79.7; // => 10
  static double width15 = screenHeight / 53.18; // => 15
  static double width20 = screenHeight / 39.88; // => 20
  static double width30 = screenHeight / 26.59; // => 30

  // fonts
  static double font16 = screenHeight / 49.86; // => 16
  static double font20 = screenHeight / 39.88; // => 20
  static double font26 = screenHeight / 30.7; // => 26

  //radius
  static double radius15 = screenHeight / 53.18; // => 15
  static double radius20 = screenHeight / 39.88; // => 20
  static double radius30 = screenHeight / 26.59; // => 30

  // icons size
  static double iconSize24 = screenHeight / 33.24; // => 24
  static double iconSize16 = screenHeight / 49.86; // => 16

  //list view size (screenWidth == 411.4)
  static double listViewImageSize = screenWidth / 3.42; // => 120
  static double listViewTextConatinerSize = screenWidth / 4.1; // =>  100

  // popular food
  static double popularFoodImageSize = screenHeight / 2.28; // = > 350

  // bottom height
  static double bottomHeightBar = screenHeight / 6.65; // = > 120

  //splash srenn dimensions
  static double splashImg = screenHeight / 3.2; // = > 250

  //_______________________

}
