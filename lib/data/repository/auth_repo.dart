import 'package:food_delivary/data/api/api_client.dart';
import 'package:food_delivary/model/sign_up_model.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
//-----------------------------------------------------------
  Future<Response> registration(SignUpBodyModel signUpModel) async {
    return await apiClient.postData(
        AppConstants.registrationUri, signUpModel.toMap());
  }

//-----------------------------------------------------------
  Future<bool> saveUserToken(String userToken) {
    apiClient.token = userToken;
    apiClient.updateHeader(userToken);
    return sharedPreferences.setString(AppConstants.token, userToken);
  }

  //-----------------------------------------------------------
  bool userLoggedIn() {
    //sharedPreferences.remove(AppConstants.token);
    return sharedPreferences.containsKey(AppConstants.token);
  }

//-----------------------------------------------------------
  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.loginUri, {"email": email, "password": password});
  }

//-----------------------------------------------------------
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "None";
  }

//-----------------------------------------------------------
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.phone, number);
      await sharedPreferences.setString(AppConstants.password, password);
    } catch (e) {
      throw Exception(e);
    }
  }

//-----------------------------------------------------------
  void clearSharedUserData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.phone);
    sharedPreferences.remove(AppConstants.password);
    apiClient.token = '';
    apiClient.updateHeader('');
  }
  //-----------------------------------------------------------
}
