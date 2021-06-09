import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medvarsity_task/custom-widget/rounded_button.dart';
import 'package:medvarsity_task/theme/theme-one.dart';
import 'package:medvarsity_task/view/auth/login.dart';
import 'package:medvarsity_task/view/auth/register.dart';

class UserAuth extends StatelessWidget {
  static final routeName = '/userAuth';
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(

          children: [
            Container(
              height: size.height,
              child: Column(
                children: [
                  SizedBox(height: 60,),

                  SizedBox(height: size.height * 0.05),
                  Container(
                      margin: EdgeInsets.all(40),

                      child: Lottie.asset('assets/taskadd.json')),
                  SizedBox(height: size.height * 0.04),

                  RoundedButton(
                    color: colorPrimary,
                    text: "LOGIN",
                    press: () {
                        Get.to(UserLogin());
                    },
                  ),
                  RoundedButton(
                    text: "SIGN UP",
                    color: Colors.white,
                    textColor: Colors.black,
                    press: () {
                      Get.to(UserRegister());
                    },
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: -10,
                right: -(size.width / 6),
                child: Container(
                  height: size.width / 3,
                  width: size.width / 3,
                  decoration:
                  BoxDecoration(color: accentColor, shape: BoxShape.circle),
                )),
            Positioned(
                bottom: -(size.width / 6),
                right: 10,
                child: Container(
                  height: size.width / 3,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                      color: colorPrimary, shape: BoxShape.circle),
                )),
            Positioned(
                top: -10,
                left: -(size.width / 6),
                child: Container(
                  height: size.width / 3,
                  width: size.width / 3,
                  decoration:
                  BoxDecoration(color: accentColor, shape: BoxShape.circle),
                )),
            Positioned(
                top: -(size.width / 6),
                left: 10,
                child: Container(
                  height: size.width / 3,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                      color: colorPrimary, shape: BoxShape.circle),
                )),
          ],
        ),
      ),
    );
  }
}
