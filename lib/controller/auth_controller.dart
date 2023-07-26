import 'package:food_delivary/data/repository/auth_repo.dart';
import 'package:food_delivary/model/response_model.dart';
import 'package:food_delivary/model/sign_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
//_________________  registration new user _____________________
  Future<ResponseModel> registration(SignUpBodyModel signUpModel) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await authRepo.registration(signUpModel);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      var token = response.body['token'];
      print("token is : $token");
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

//_________________login_____________________
  Future<ResponseModel> login(String email, String password) async {
    var to = authRepo.getUserToken();
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await authRepo.login(email, password);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      var token = response.body['token'];
      //print("token from backend : $token");
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
//___________________________

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  void clearUserData() {
    authRepo.clearSharedUserData();
    update();
  }

  getUserToken() {
    return authRepo.getUserToken();
  }
}
