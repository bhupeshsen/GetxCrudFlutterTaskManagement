import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medvarsity_task/helper/util.dart';
import 'package:medvarsity_task/service/task.dart';
import 'package:medvarsity_task/service/user.dart';

class AddTaskController extends GetxController{
  final formKey = GlobalKey<FormState>().obs;
  RxString tittle = ''.obs;
  RxString comment = ''.obs;
  RxString startDate = ''.obs;
  RxBool indicatorLoader = false.obs;
  RxString endDate = ''.obs;
  TextEditingController startDateCtrl;
  TextEditingController endDateCtrl;
  TextEditingController tittleCtrl;
  TextEditingController commentCtrl;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startDateCtrl = TextEditingController(text: '');
    endDateCtrl = TextEditingController(text: '');
    tittleCtrl = TextEditingController(text: '');
    commentCtrl = TextEditingController(text: '');

  }


   validation() async{
     if (tittleCtrl.text.length == 0) {
       showSnackBar("Error", "Please enter tittle", Colors.redAccent);
       return false;
     }
     if (commentCtrl.text.length == 0) {
       showSnackBar("Error", "Please enter comment", Colors.redAccent);
       return false;
     }
     if (startDateCtrl.text.length == 0) {
       showSnackBar("Error", "Please select start end", Colors.redAccent);
       return false;
     }
     if (endDateCtrl.text.length == 0) {
       showSnackBar("Error", "Please select end date", Colors.redAccent);
       return false;
     }
    addTask();
  }


  Future addTask() async {
    indicatorLoader.value = true;
    Map<String, dynamic> map = {
      "tittle": tittleCtrl.text,
      "comment": commentCtrl.text,
      "start_date": startDateCtrl.text,
      "end_date": endDateCtrl.text
    };
    print("bhbh"+map.toString());
    dynamic userData = await TaskService.addTask(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {

tittleCtrl.clear();
commentCtrl.clear();
endDateCtrl.clear();
startDateCtrl.clear();
        indicatorLoader.value = false;
        showSnackBar("Success", data['message'], Colors.green);

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