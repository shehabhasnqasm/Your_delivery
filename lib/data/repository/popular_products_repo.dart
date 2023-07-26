import 'package:food_delivary/data/api/api_client.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductsRepo extends GetxService {
  late ApiClient apiClient;
  PopularProductsRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.popularProductUrl);
  }
}
