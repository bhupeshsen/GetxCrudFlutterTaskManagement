import 'dart:convert';

import 'package:get/get.dart';
import 'package:medvarsity_task/helper/shared-pref.dart';
import 'package:medvarsity_task/model/users.dart';
import 'package:medvarsity_task/view/auth/user-authentication.dart';
import 'package:medvarsity_task/view/dashboard/home.dart';

class SplashController extends GetxController{
  SharedPref sharedPref =SharedPref();

  Users users=Users();
  var appLocale = 'ja';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Future.delayed(Duration(milliseconds: 300), () {
      checkUseLogin();
    });

  }

  void checkUseLogin() async{
    dynamic sessionData = await sharedPref.read('userData', false);
    if(sessionData!=null){
      dynamic  jsonData=json.decode(sessionData);
      users=Users.fromJson(jsonData);
      print("data"+jsonData['status'].toString());
      if(users.status=true){
        Get.offAll(Home());
      }else{
        Get.offAll(UserAuth());
      }

    }else{
      Get.offAll(UserAuth());
    }
    update();
  }

}