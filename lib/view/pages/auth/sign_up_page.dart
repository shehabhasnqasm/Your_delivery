import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/model/response_model.dart';
import 'package:food_delivary/model/sign_up_model.dart';
import 'package:food_delivary/view/pages/auth/login_page.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/app_text_field.dart';
import 'package:food_delivary/view/widgets/base/custom_loader.dart';
import 'package:food_delivary/view/widgets/base/show_custom_snakbar.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emialController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var sigupImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    registration(AuthController authController) {
      //var authController = Get.find<AuthController>();

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emialController.text.trim();
      String password = passwordController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("type in your phone number", title: "phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("type in your emil", title: "email");
      } else if (!GetUtils.isEmail(email)) {
        // or use  if(email.isEmail) instead of if (!GetUtils.isEmail(email))
        showCustomSnackBar("type in invalid email", title: "invalid email");
      } else if (password.isEmpty) {
        showCustomSnackBar("type in empty password", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("type in password < 6 ", title: "password");
      } else {
        showCustomSnackBar("great !!!", title: "perfect");
        SignUpBodyModel signUpBody = SignUpBodyModel(
            name: name, phone: phone, email: email, password: password);
        print(signUpBody.toString());

        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            // Get.toNamed(RouteHelper.getCartPage());

            // Get.offNamed(RouteHelper.getInitial());
            showCustomSnackBar("my token:${status.message}");
            // print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar("error token :${status.message}");
          }
        });
      }
    }

    return Scaffold(body: GetBuilder<AuthController>(builder: (authController) {
      return authController.isLoading
          ? const CustomLoader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: Diamensions.screenHeight * 0.05),
                  //app logo
                  SizedBox(
                    height: Diamensions.screenHeight * 0.25,
                    child: const Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage("assets/images/puplic/deedees_logo.jpg"),
                      ),
                    ),
                  ),
                  //email
                  AppTextFiled(
                      textEditingController: emialController,
                      hintText: "Email",
                      icon: Icons.email),
                  SizedBox(height: Diamensions.height20),
                  //password
                  AppTextFiled(
                      textEditingController: passwordController,
                      hintText: "Password",
                      icon: Icons.password_sharp,
                      isObscure: true),
                  SizedBox(height: Diamensions.height20),
                  //Name
                  AppTextFiled(
                      textEditingController: nameController,
                      hintText: "Name",
                      icon: Icons.person),
                  SizedBox(height: Diamensions.height20),
                  //Phone
                  AppTextFiled(
                      textEditingController: phoneController,
                      hintText: "Phone",
                      icon: Icons.phone),
                  SizedBox(height: Diamensions.height20),
                  //Sig Up
                  GestureDetector(
                    onTap: () async {
                      registration(authController);
                    },
                    child: Container(
                      width: Diamensions.screenWidth / 2,
                      height: Diamensions.screenHeight / 13,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Diamensions.radius30),
                        color: AppCourse.mainColor,
                      ),
                      child: Center(
                          child: BigText(
                              text: "Sign Up",
                              size: Diamensions.font20 + Diamensions.font20 / 2,
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: Diamensions.height20),
                  //Have an account alredy?
                  RichText(
                    text: TextSpan(
                      text: "Have an account already?",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(
                              RouteHelper
                                  .getLogInPage(), //Get.to(() => const LoginPage(),
                            ),
                      // Get.back(),
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Diamensions.font20),
                    ),
                  ),
                  //
                  SizedBox(height: Diamensions.screenHeight * 0.05),
                  //sigup options
                  RichText(
                    text: TextSpan(
                      text: "Sign up using one of the following methods?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Diamensions.font16),
                    ),
                  ),
                  Wrap(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: Diamensions.radius30,
                                backgroundImage: AssetImage(
                                    "assets/images/${sigupImages[index]}"),
                              ),
                            )),
                  ),
                ],
              ),
            );
    }));
  }
}
