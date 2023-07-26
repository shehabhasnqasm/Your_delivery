import 'package:flutter/material.dart';
import 'package:food_delivary/controller/auth_controller.dart';
import 'package:food_delivary/controller/user_controller.dart';
import 'package:food_delivary/view/pages/auth/sign_up_page.dart';
import 'package:food_delivary/view/pages/home/home_page.dart';
import 'package:food_delivary/utils/routes/router_helper.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/account_widget.dart';
import 'package:food_delivary/view/widgets/app_icon.dart';
import 'package:food_delivary/view/widgets/base/custom_loader.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLogin = Get.find<AuthController>().userLoggedIn();
    if (userLogin) {
      Get.find<UserController>().getUserInfo();
    }
    return Drawer(
        //key: key,
        // child: AccountPage(),
        child: GetBuilder<UserController>(builder: (userController) {
      return userLogin
          ? (userController.isLoaded
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      DrawerHeader(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          // radius: Diamensions.height40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppCourse.mainColor),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: Diamensions.height45 + Diamensions.height30,
                            ),
                          ),
                        ),
                      ),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'User Information',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      userListTile(
                        'Name',
                        userController.userModel.name,
                        context,
                        Icons.person,
                      ),
                      userListTile('Phone number',
                          userController.userModel.phone, context, Icons.phone),
                      userListTile('Email', userController.userModel.email,
                          context, Icons.email),

                      SizedBox(height: Diamensions.height20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'User Bag',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )),
                      ),

                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),

                      InkWell(
                        onTap: () {
                          Get.to(
                            const SignUpPage(),
                          );
                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.account_box,
                            backgroundColor: Colors.red,
                            iconColor: Colors.white,
                            iconSize: Diamensions.height10 * 5 / 2,
                            size: Diamensions.height10 * 5,
                          ),
                          bigText: BigText(text: "Account"),
                          // bigText: BigText(text: userController.userModel.phone),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: AccountWidget(
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
                      ),
                      SizedBox(height: Diamensions.height20),
                      //const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
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
                          image:
                              AssetImage("assets/images/signintocontinue.png"),
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

  Widget userListTile(
      String title, String subTitle, BuildContext context, IconData icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            subTitle,
            style: const TextStyle(fontSize: 16),
          ),
          leading: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppCourse.yelowColor),
              child: Icon(
                icon,
                color: AppCourse.mainColor,
              )),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
