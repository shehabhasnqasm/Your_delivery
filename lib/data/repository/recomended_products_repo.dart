import 'package:food_delivary/data/api/api_client.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';

class RecomendedProductsRepo extends GetxService {
  late ApiClient apiClient;
  RecomendedProductsRepo({required this.apiClient});

  Future<Response> getRecomendedProductList() async {
    return await apiClient.getData(AppConstants.recomendedProductUrl);
  }
}
