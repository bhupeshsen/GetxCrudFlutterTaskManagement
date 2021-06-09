import 'dart:convert';

import 'package:get/get.dart';
import 'package:medvarsity_task/helper/shared-pref.dart';
import 'package:medvarsity_task/model/users.dart';

class ProfileController extends GetxController{
      Users users = Users() ;
  static SharedPref sharedPref;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileFetch();
  }

  void profileFetch() async{
    sharedPref =SharedPref();
    dynamic sessionData = await sharedPref.read('userData', false);
    if(sessionData!=null){
      dynamic  jsonData=json.decode(sessionData);
      users=Users.fromJson(jsonData);
    }
  }
}