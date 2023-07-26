import 'package:food_delivary/data/repository/user_repo.dart';
import 'package:food_delivary/model/response_model.dart';
import 'package:food_delivary/model/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  late UserModel _userModel;
  UserModel get userModel => _userModel;
//-----------------------------------------------------------
  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    //print("test" + response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "Successfully");
      _isLoaded = true;
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
  //-----------------------------------------------------------
}
