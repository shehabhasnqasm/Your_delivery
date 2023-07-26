import 'package:food_delivary/view/pages/auth/login_page.dart';
import 'package:food_delivary/view/pages/auth/sign_up_page.dart';
import 'package:food_delivary/view/pages/cart/cart_page.dart';
import 'package:food_delivary/view/pages/cart/history_page.dart';
import 'package:food_delivary/view/pages/cart/history_page_detail.dart';
import 'package:food_delivary/view/pages/food/popular_food_details.dart';
import 'package:food_delivary/view/pages/food/recomended_food_detail.dart';
import 'package:food_delivary/view/pages/home/home_page.dart';
import 'package:food_delivary/view/pages/splash/splash_page.dart';

import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splashPage = "/splash-page";
  static const String popularFood = "/popular-food";
  static const String recomendedFood = "/recomended-food";
  static const String cartPage = "/cart-page";
  static const String historyPage =
      "/history-page"; //HistoryPage // HistoryPageDetail
  static const String historyPageDetail = "/history-page-detail";
  static const String signUpPage = "/sign-up-page";
  static const String logInPage = "/log-in-page";

  static getInitial() => initial;
  static getSplashPage() => splashPage;
  static getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static getRecomendedFood(int pageId, String recoPage) =>
      '$recomendedFood?pageId=$pageId&recoPage=$recoPage';
  static getCartPage() => cartPage;
  static gethistoryPage() => historyPage;
  static gethistoryPageDetail(int indexOfOrder) =>
      '$historyPageDetail?indexOrder=$indexOfOrder';
  static getSignUpPage() => signUpPage;
  static getLogInPage() => logInPage;

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () => const SplashPage(),
        transition: Transition.fade),
    GetPage(
        name: initial,
        page: () => const HomePage(),
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetailes(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fade),
    GetPage(
        name: recomendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var recoPage = Get.parameters['recoPage'];
          return RecomendedFoodDetail(
            pageId: int.parse(pageId!),
            page: recoPage!,
          );
        },
        transition: Transition.fade),
    GetPage(
        name: cartPage,
        page: () => const CartPage(),
        transition: Transition.fade),
    GetPage(
        name: historyPage,
        page: () => const HistoryPage(),
        transition: Transition.fade),
    GetPage(
        name: historyPageDetail,
        page: () {
          var indexOrder = Get.parameters['indexOrder'];
          return HistoryPageDetail(
            indexOrder: int.parse(indexOrder!),
          );
        },
        transition: Transition.fade),
    GetPage(
        name: signUpPage,
        page: () => const SignUpPage(),
        transition: Transition.fade),
    GetPage(
        name: logInPage,
        page: () => const LoginPage(),
        transition: Transition.fade),
  ];
}
