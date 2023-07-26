import 'package:food_delivary/controller/cart_controller.dart';
import 'package:food_delivary/data/repository/popular_products_repo.dart';
import 'package:food_delivary/model/cart_model.dart';
import 'package:food_delivary/model/product_model.dart';
import 'package:get/get.dart';

class PopularProducsController extends GetxController {
  final PopularProductsRepo popularProductsRepo;
  PopularProducsController({required this.popularProductsRepo});
  List<ProductModel> _popularProducList = [];
  List<ProductModel> get popularProducList => _popularProducList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    try {
      Response response = await popularProductsRepo.getPopularProductList();
      if (response.statusCode == 200) {
        _popularProducList = [];
        var data = response.body;
        Product product = Product.fromJson(data);
        _popularProducList.addAll(product.products);
        _isLoaded = true;
        update(); //is same setState()
      } else {
        print("not get products");
        // print("${response.statusCode}");
        // print("${response.statusText}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//-----------------------------------------------------------
  int getIndex(int id) {
    if (_popularProducList.isNotEmpty) {
      return _popularProducList.indexWhere((element) => element.id == id);
    }
    return -1;
  }

  int _quantity = 0;
  int get quantity => _quantity;
  late CartController _cart;
  bool _isSameQuantity = false;
  bool get isSameQuantity => _isSameQuantity;
  int actualQuantity = 0;
  double _totalPriceProductItems = 0;
  double get totalPriceProductItems => _totalPriceProductItems;

  //-----------------------------------------------------------
  void init(CartController cart, {ProductModel? product}) {
    _quantity = 0;
    actualQuantity = 0;
    _isSameQuantity = false;
    _totalPriceProductItems = 0;
    _cart = cart;
    int count = _cart.totalItems;
    if (count > 0) {
      if (product != null) {
        bool exist = false;
        exist = _cart.existInCart(product);
        if (exist) {
          actualQuantity = _cart.getQuantity(product);
          _quantity = actualQuantity;
          if (_quantity == actualQuantity) {
            _isSameQuantity = true;
          } else {
            _isSameQuantity = false;
          }
          _totalPriceProductItems = (product.price! * _quantity).toDouble();
        } else {
          actualQuantity = 0;
          _quantity = 0;
          if (_quantity == actualQuantity) {
            _isSameQuantity = true;
          } else {
            _isSameQuantity = false;
          }
        }
      }
    } else {
      actualQuantity = 0;
      _quantity = 0;
      if (_quantity == actualQuantity) {
        _isSameQuantity = true;
      } else {
        _isSameQuantity = false;
      }
    }

    // update();
  }

  refreshData() {
    update();
  }

//-----------------------------------------------------------
  void increasItem(ProductModel product) {
    if (_quantity >= 0) {
      _quantity = _quantity + 1;
      if (_quantity == actualQuantity) {
        _isSameQuantity = true;
      } else {
        _isSameQuantity = false;
      }
    }
    _totalPriceProductItems = (product.price! * _quantity).toDouble();
    update();
  }

//-----------------------------------------------------------
  void decreassItem(ProductModel product) {
    if (_quantity > 0) {
      _quantity = _quantity - 1;
      if (_quantity == actualQuantity) {
        _isSameQuantity = true;
      } else {
        _isSameQuantity = false;
      }
    } else {
      _quantity = 0;
    }
    _totalPriceProductItems = (product.price! * _quantity).toDouble();
    update();
  }

//-----------------------------------------------------------
  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    bool exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      actualQuantity = _cart.getQuantity(product);
      _quantity = actualQuantity;
      if (_quantity == actualQuantity) {
        _isSameQuantity = true;
      } else {
        _isSameQuantity = false;
      }
    } else {
      actualQuantity = 0;
      _quantity = 0;
      if (_quantity == actualQuantity) {
        _isSameQuantity = true;
      } else {
        _isSameQuantity = false;
      }
    }
    _totalPriceProductItems = (product.price! * _quantity).toDouble();
    update();
  }

//-----------------------------------------------------------
  int get numberCartProducts {
    return _cart.numberOfCartProducts;
  }

//-----------------------------------------------------------
  int get totalItems {
    return _cart.totalItems;
  }

//-----------------------------------------------------------
  List<CartModel> get getItems {
    return _cart.getItems;
  }

//-----------------------------------------------------------
  int get totalAmount {
    return _cart.totalAmount;
  }

//-----------------------------------------------------------
}
