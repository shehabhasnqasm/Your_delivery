import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/view/pages/auth/sign_up_page.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/view/widgets/base/custom_loader.dart';
import 'package:food_delivary/view/widgets/base/show_custom_snakbar.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../../utils/diamensions.dart';
import '../../widgets/app_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emialController = TextEditingController();
    var passwordController = TextEditingController();

    var sigupImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void login(AuthController authController) {
      // var authController = Get.find<AuthController>();

      String email = emialController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        showCustomSnackBar("type in your emil", title: "email");
      } else if (!GetUtils.isEmail(email)) {
        // or use  if(email.isEmail)
        showCustomSnackBar("type in invalid email", title: "invalid email");
      } else if (password.isEmpty) {
        showCustomSnackBar("type in empty password", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("type in password < 6 ", title: "password");
      } else {
        showCustomSnackBar("great !!!", title: "perfect");

        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.snackbar("title", "message",
                titleText: BigText(
                  text: "Success",
                  color: Colors.white,
                ),
                messageText: const Text(
                  "sucessfuly log in",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppCourse.mainColor,
                colorText: Colors.white);
            // Get.toNamed(RouteHelper.getInitial());
            Get.offNamed(RouteHelper.getInitial());

            // print("Success login");
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
                  Container(
                    height: Diamensions.screenHeight * 0.25,
                    child: const Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage("assets/images/logo_part_1.png"),
                      ),
                    ),
                  ),
                  //Hello
                  Container(
                    margin: EdgeInsets.only(left: Diamensions.width20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello",
                            style: TextStyle(
                                fontSize: Diamensions.font20 * 3 +
                                    Diamensions.font20 / 2,
                                fontWeight: FontWeight.bold)),
                        Text("Sign into your account",
                            style: TextStyle(
                                fontSize: Diamensions.font20,
                                color: Colors.grey[500])),
                      ],
                    ),
                  ),
                  SizedBox(height: Diamensions.screenHeight * 0.05),
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
                      icon: Icons.password,
                      isObscure: true),
                  SizedBox(height: Diamensions.height20),

                  SizedBox(height: Diamensions.height10),
                  //Have an account alredy?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: Container()),
                      RichText(
                        text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Diamensions.font20),
                        ),
                      ),
                      SizedBox(width: Diamensions.width20),
                    ],
                  ),
                  //
                  SizedBox(height: Diamensions.screenHeight * 0.05),
                  //sigin
                  GestureDetector(
                    onTap: () async {
                      login(authController);
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
                              text: "Sign In",
                              size: Diamensions.font20 + Diamensions.font20 / 2,
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: Diamensions.screenHeight * 0.05),

                  RichText(
                    text: TextSpan(
                      text: "Don't an account?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Diamensions.font20),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.offNamed(RouteHelper
                                .getSignUpPage()) //Get.to(() => const SignUpPage(),
                          ,
                          text: " Create?",
                          style: TextStyle(
                              color: AppCourse.mainBlackColor,
                              fontSize: Diamensions.font20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    }));
  }
}
