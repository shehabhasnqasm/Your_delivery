import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/controller/history_controller.dart';
import 'package:food_delivary/controller/popular_products_controller.dart';
import 'package:food_delivary/controller/recomended_products_controller.dart';
import 'package:food_delivary/controller/user_controller.dart';
import 'package:food_delivary/data/api/api_client.dart';
import 'package:food_delivary/data/repository/auth_repo.dart';
import 'package:food_delivary/data/repository/cart_repo.dart';
import 'package:food_delivary/data/repository/history_repo.dart';
import 'package:food_delivary/data/repository/popular_products_repo.dart';
import 'package:food_delivary/data/repository/recomended_products_repo.dart';
import 'package:food_delivary/data/repository/user_repo.dart';
import 'package:food_delivary/data/sqflit_db/sqflite_db.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // apiClient
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // sqflite
  Get.lazyPut(() => SqfliteDB());

  // repo
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecomendedProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => HistoryRepo(sqfliteDB: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProducsController(popularProductsRepo: Get.find()));
  Get.lazyPut(
      () => RecomendedProducsController(recomendedProductsRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => HistoryController(historyRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
}


////________________________________________________________
// or use there way  ; set parameter to initialBinding:DependencyInjection() ;  ( in GetMaterialApp in main.dart file )
// class DependencyInjection extends Bindings {
//   @override
//   void dependencies() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     Get.lazyPut(() => sharedPreferences);

//     // apiClient
//     Get.lazyPut(() => ApiClient(
//         appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

//     // sqflite
//     Get.lazyPut(() => SqfliteDB());

//     // repo
//     Get.lazyPut(
//         () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
//     Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
//     Get.lazyPut(() => RecomendedProductsRepo(apiClient: Get.find()));
//     Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
//     Get.lazyPut(() => HistoryRepo(sqfliteDB: Get.find()));
//     Get.lazyPut(() => UserRepo(apiClient: Get.find()));

//     //controller
//     Get.lazyPut(() => AuthController(authRepo: Get.find()));
//     Get.lazyPut(
//         () => PopularProducsController(popularProductsRepo: Get.find()));
//     Get.lazyPut(
//         () => RecomendedProducsController(recomendedProductsRepo: Get.find()));
//     Get.lazyPut(() => CartController(cartRepo: Get.find()));
//     Get.lazyPut(() => HistoryController(historyRepo: Get.find()));
//     Get.lazyPut(() => UserController(userRepo: Get.find()));
//   }
// }
