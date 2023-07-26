import 'dart:convert';

import 'package:food_delivary/model/cart_model.dart';
import 'package:food_delivary/model/sign_up_model.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

//////////////////////////////////////////////////////////////////////
  List<String> carts = [];

  void addToSharedCartList(List<CartModel> cartList) {
    carts = [];
    for (var element in cartList) {
      continue;
    }
    sharedPreferences.setStringList(AppConstants.cartList, carts);
    //print(sharedPreferences.getStringList(AppConstants.cartList));
  }

//////////////////////////////////////////////////////////////////////
  List<CartModel> getSharedCartList() {
    List<String> cartStrings = [];
    List<CartModel> cartListModel = [];

    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      cartStrings = sharedPreferences.getStringList(AppConstants.cartList)!;

      if (cartStrings.isNotEmpty) {
        for (var element in cartStrings) {
          continue;
        }
      }
    }
    return cartListModel;
  }

  ////////////////////////////////////////////////////////////////////

  clear() {
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      sharedPreferences.remove(AppConstants.cartList);
    }
  }

  ////////////////////////////////////////////////////////////////////

}
