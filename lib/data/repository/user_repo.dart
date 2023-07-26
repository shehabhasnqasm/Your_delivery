import 'package:food_delivary/data/api/api_client.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.userInfoUri);
  }
}
