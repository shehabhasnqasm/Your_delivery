import 'package:flutter/material.dart';
import 'package:food_delivary/data/repository/cart_repo.dart';
import 'package:food_delivary/model/cart_model.dart';
import 'package:food_delivary/model/product_model.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  //
  final Map<int, CartModel> _sharedStorageItems = {};

  void startGetDataFromSharedPref() {
    List<CartModel> sharedCartList = [];
    sharedCartList = cartRepo.getSharedCartList();
    if (sharedCartList.isNotEmpty) {
      _sharedStorageItems.clear();
      for (int i = 0; i < sharedCartList.length; i++) {
        _sharedStorageItems.putIfAbsent(
            sharedCartList[i].id!, () => sharedCartList[i]);
      }
      _items = _sharedStorageItems;
    }
    update();
  }

//-----------------------------------------------------------
  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

//-----------------------------------------------------------
  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity ?? 0;
        }
      });
    }
    return quantity;
  }

//-----------------------------------------------------------
  void addItem(ProductModel product, int number) {
    print("items length: ${_items.length}");
    if (_items.containsKey(product.id)) {
      if (number > 0) {
        _items.update(product.id!, (value) {
          //print("product quantity: ${value.quantity}");
          return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: number,
            isExit: true,
            time: DateTime.now().toString(),
            product: value.product,
          );
        });
        _items.forEach((key, value) {
          if (key == product.id) {
            print("value updated key: $key");
            print("value updated id: ${value.id}");
            print("value updated product.id: ${product.id}");
            print("value updated quantity: ${value.quantity}");
          }
        });
      } else {
        _items.remove(product.id);
      }
    } else {
      if (number > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: number,
            isExit: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
        _items.forEach((key, value) {
          if (key == product.id) {
            print("value added number: $number");
            // print("value added key: ${key}");
            // print("value added product.id: ${product.id}");
            // print("value added value.id: ${value.id}");
            // print("value added value.quantity: ${value.quantity}");
            // print("value added value.name: ${value.name}");
          }
        });
      } else {
        Get.snackbar(
            "Item count", "You should at least add an item in the cart!",
            backgroundColor: AppCourse.mainColor, colorText: Colors.white);
      }
    }

    cartRepo.addToSharedCartList(getItems);
    update();
  }

//-----------------------------------------------------------
  int get numberOfCartProducts {
    return _items.length;
  }

//-----------------------------------------------------------
  int get totalItems {
    int quantityItemsOfAllCartProducts = 0;
    _items.forEach((key, value) {
      quantityItemsOfAllCartProducts += value.quantity!;
    });
    return quantityItemsOfAllCartProducts;
  }

//-----------------------------------------------------------
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

//-----------------------------------------------------------
  clear() {
    _items.clear();
    cartRepo.clear();
    update();
  }

//__________________ increase item or decrease item in cart page_____________

  void plusItem(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id!,
          (value) => CartModel(
                id: value.id,
                name: value.name,
                price: value.price,
                img: value.img,
                quantity: value.quantity! + 1,
                isExit: true,
                time: DateTime.now().toString(),
                product: value.product,
              ));
    }
    cartRepo.addToSharedCartList(getItems);
    update();
  }

//________________________________________
  void minusItem(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    if (quantity > 1) {
      _items.update(
          product.id!,
          (value) => CartModel(
                id: value.id,
                name: value.name,
                price: value.price,
                img: value.img,
                quantity: value.quantity! - 1,
                isExit: true,
                time: DateTime.now().toString(),
                product: value.product,
              ));
    } else if (quantity == 1) {
      // return;
      // _items.update(
      //     product.id!,
      //     (value) => CartModel(
      //           id: value.id,
      //           name: value.name,
      //           price: value.price,
      //           img: value.img,
      //           quantity: value.quantity!,
      //           isExit: true,
      //           time: DateTime.now().toString(),
      //           product: value.product,
      //         ));
    } else {
      _items.remove(product.id);
    }
    cartRepo.addToSharedCartList(getItems);
    update();
  }
//______________________________________________

  int get totalAmount {
    var totalAmount = 0;
    _items.forEach((key, value) {
      totalAmount += value.price! * value.quantity!;
    });
    return totalAmount;
  }

//-----------------------------------------------------------
  removeProduct(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items.remove(product.id);
    }
    cartRepo.addToSharedCartList(getItems);
    update();
  }

  //____________________________________________________________-
}
