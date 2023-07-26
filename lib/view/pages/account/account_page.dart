import 'package:flutter/material.dart';
import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/controller/user_controller.dart';
import 'package:food_delivary/view/pages/home/home_page.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/account_widget.dart';
import 'package:food_delivary/view/widgets/app_icon.dart';
import 'package:food_delivary/view/widgets/base/custom_loader.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLogin = Get.find<AuthController>().userLoggedIn();
    if (userLogin) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          title: BigText(
            text: "profile",
            size: 24,
            color: Colors.white,
          ),
          //centerTitle: true,
          backgroundColor: AppCourse.mainColor,
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return userLogin
              ? (userController.isLoaded
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Diamensions.height20),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppCourse.mainColor,
                            iconColor: Colors.white,
                            iconSize:
                                Diamensions.height45 + Diamensions.height30,
                            size: Diamensions.height15 * 10,
                          ),
                          SizedBox(
                            height: Diamensions.height30,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: AppCourse.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Diamensions.height10 * 5 / 2,
                                    size: Diamensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.name),
                                  // bigText: BigText(text: userController.userModel.phone),
                                ),
                                SizedBox(height: Diamensions.height20),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    backgroundColor: AppCourse.yelowColor,
                                    iconColor: Colors.white,
                                    iconSize: Diamensions.height10 * 5 / 2,
                                    size: Diamensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.phone),
                                  // bigText: BigText(text: userController.userModel.phone),
                                ),
                                SizedBox(height: Diamensions.height20),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email_outlined,
                                    backgroundColor: AppCourse.yelowColor,
                                    iconColor: Colors.white,
                                    iconSize: Diamensions.height10 * 5 / 2,
                                    size: Diamensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.email),
                                  // bigText: BigText(text: userController.userModel.phone),
                                ),
                                SizedBox(height: Diamensions.height20),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.location_city,
                                    backgroundColor: AppCourse.yelowColor,
                                    iconColor: Colors.white,
                                    iconSize: Diamensions.height10 * 5 / 2,
                                    size: Diamensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.orderCount
                                          .toString()),
                                  // bigText: BigText(text: userController.userModel.phone),
                                ),
                                SizedBox(height: Diamensions.height20),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.message_outlined,
                                    backgroundColor: Colors.red,
                                    iconColor: Colors.white,
                                    iconSize: Diamensions.height10 * 5 / 2,
                                    size: Diamensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: "Message"),
                                  // bigText: BigText(text: userController.userModel.phone),
                                ),
                                SizedBox(height: Diamensions.height20),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()),
                                        (route) => false);
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout_outlined,
                                      backgroundColor: Colors.red,
                                      iconColor: Colors.white,
                                      iconSize: Diamensions.height10 * 5 / 2,
                                      size: Diamensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: "Log out"),
                                    // bigText: BigText(text: userController.userModel.phone),
                                  ),
                                ),
                                SizedBox(height: Diamensions.height20),
                              ],
                            ),
                          )),
                        ],
                      ),
                    )
                  : const CustomLoader())
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Diamensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Diamensions.width20,
                              right: Diamensions.width20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Diamensions.radius20),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/signintocontinue.png"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getLogInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Diamensions.height20 * 5,
                            margin: EdgeInsets.only(
                                left: Diamensions.width20,
                                right: Diamensions.width20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Diamensions.radius20),
                              color: AppCourse.mainColor,
                            ),
                            child: Center(
                                child: BigText(
                                    text: "Sign in ",
                                    color: Colors.white,
                                    size: Diamensions.font26)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }));
  }
}
