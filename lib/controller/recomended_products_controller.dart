import 'package:food_delivary/model/product_model.dart';
import 'package:get/get.dart';

import '../data/repository/recomended_products_repo.dart';

class RecomendedProducsController extends GetxController {
  final RecomendedProductsRepo recomendedProductsRepo;
  RecomendedProducsController({required this.recomendedProductsRepo});
  List<ProductModel> _recomendedProducList = [];
  List<ProductModel> get recomendedProducList => _recomendedProducList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecomendedProductList() async {
    try {
      Response response =
          await recomendedProductsRepo.getRecomendedProductList();
      if (response.statusCode == 200) {
        print("recomended products get");
        _recomendedProducList = [];
        // var toMap = jsonDecode(response.body.toString());
        Product product =
            Product.fromJson(response.body as Map<String, dynamic>);
        _recomendedProducList.addAll(product.products);
        _isLoaded = true;
        update(); //is same setState()
      } else {
        print("recomended not get products");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//-----------------------------------------------------------
  int getIndex(int id) {
    if (_recomendedProducList.isNotEmpty) {
      return _recomendedProducList.indexWhere((element) => element.id == id);
    }
    return -1;
  }
  //-----------------------------------------------------------
}
