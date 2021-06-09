import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:medvarsity_task/helper/shared-pref.dart';
import 'package:medvarsity_task/helper/util.dart';
import 'package:medvarsity_task/service/user.dart';
import 'package:medvarsity_task/view/dashboard/home.dart';

class LoginController extends GetxController {

  SharedPref sharedPref = SharedPref();
  RxString passwordHideShow = "hide".obs;
  RxString mobile = ''.obs;
  RxString password = ''.obs;
  RxBool submitBtnCheck = false.obs;
  RxBool indicatorLoader = false.obs;

  // this two variable use for error checking we can also use from widget for validation
  RxString mobileNameErrorText = RxString(null);
  RxString passwordErrorText = RxString(null);

  @override
  void onInit() {
    super.onInit();
  }

  // for hide showing the password
  void toggle(String val) {
    if (passwordHideShow.value == "hide") {
      passwordHideShow.value = "show";
    } else {
      passwordHideShow.value = "hide";
    }
  }



  // for checking the mobile and password length
  bool validations(String type,
      {int minPassLen = 3, int maxLen = 10, int maxPassLen = 8}) {
    passwordErrorText.value = null; // reset validation
    mobileNameErrorText.value = null;
    indicatorLoader.value = false;
    submitBtnCheck.value = false; // disable submit while validating
    if (mobile.value.length < maxLen && type == "mobile") {
      mobileNameErrorText.value = 'Please enter valid mobile no';
      return false;
    } else if (password.value.length > maxPassLen && type  == "password") {
      passwordErrorText.value = 'Maximum password length should be 8';
      return false;
    } else if (password.value.length < minPassLen && type == "password") {
      passwordErrorText.value = 'Maximum password length should be 5';
      return false;
    }
    return true;
  }



  // this function is use for check all validation then it enable the login button
  void checkValidations(String type) async {
    if (validations(type) &&
        password.value.length >= 5 &&
        mobile.value.length >= 10) {
      submitBtnCheck.value = true;
    }
  }

  // it get password value then check validation
  void passwordChange(String val) {
    password.value = val;
    checkValidations("password");
  }

  // it get user name  value then check validation
  void mobileChange(String val) {
    mobile.value = val;
    checkValidations("mobile");
  }


  // this function is use authentication form server
  Future userLogin() async {
    indicatorLoader.value = true;
    Map<String, dynamic> map = {
      "number": mobile.value,
      "password": password.value,
    };
    dynamic userData = await UserApiServices.getUserLogin(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {
        indicatorLoader.value = false;
        sharedPref.save("userData", userData.data, false);
        showSnackBar("Success", data['message'], Colors.green);
       Get.offAll(Home());
      } else {
        indicatorLoader.value = false;
        showSnackBar("Error", data['message'], Colors.redAccent);
      }
    } else {
      indicatorLoader.value = false;
      showSnackBar("Error", data['message'], Colors.redAccent);
    }
  }
}
