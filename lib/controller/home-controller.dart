import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medvarsity_task/helper/shared-pref.dart';
import 'package:medvarsity_task/model/Task.dart';
import 'package:medvarsity_task/service/task.dart';
import 'package:medvarsity_task/view/auth/Splash-screen.dart';
import 'package:medvarsity_task/view/auth/login.dart';
class HomeController extends GetxController{

  var isLoading = true.obs;
  SharedPref sharedPref=SharedPref();
  RxInt rxIndex= 0.obs;
  PageController  pageController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageController.dispose();
  }

  void bottomChange(index){
    pageController.jumpToPage(index);
    rxIndex.value = index;
  }

  Future logout() async{
    sharedPref.clear();
    Get.offAll(UserLogin());

  }
}