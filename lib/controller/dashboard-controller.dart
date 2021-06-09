import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medvarsity_task/helper/functions.dart';
import 'package:medvarsity_task/helper/util.dart';
import 'package:medvarsity_task/model/Task.dart';
import 'package:medvarsity_task/service/task.dart';
class DashboardController extends GetxController{

  final formKey = GlobalKey<FormState>().obs;

  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  TextEditingController startDateCtrl;
  TextEditingController endDateCtrl;
  TextEditingController tittleCtrl;
  RxBool indicatorLoader = false.obs;
  TextEditingController commentCtrl;

  RxString totalTask = ''.obs;
  RxString selectStatus = ''.obs;
  RxString completeTask = ''.obs;
  RxString newTask = ''.obs;
  RxString selectDate = ''.obs;


  var isLoading = true.obs;
  RxString pendingTask = ''.obs;
  Task task= Task();
  int taskPos = 0;
  var recentTaskList = List<Task>.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startDateCtrl = TextEditingController(text: '');
    endDateCtrl = TextEditingController(text: '');
    tittleCtrl = TextEditingController(text: '');
    commentCtrl = TextEditingController(text: '');

    getHomeData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }

void setData(){
  tittleCtrl.text=task.tittle;
  commentCtrl.text=task.comment;
  startDateCtrl.text=task.startDate;
  endDateCtrl.text=task.endDate;


}
  void getHomeData() async{
    try {
      recentTaskList.clear();
      recentTaskList = List<Task>.empty(growable: true).obs;
      isLoading(true);

      dynamic resultData = await TaskService.getHome();
      dynamic responseJson = json.decode(resultData.data);
      //here we set the tournaments array in to list
      totalTask.value=responseJson['dashboard']['total'] == null ? '0' :responseJson['dashboard']['total'] ;
      newTask.value=responseJson['dashboard']['New'];
      pendingTask.value=responseJson['dashboard']['Pending'];
      completeTask.value=responseJson['dashboard']['Complete'];

      List listData=responseJson['recentTaskList'];
      var list=listData.map((m) => new Task.fromJson(m)).toList();
      if (list != null) {
        recentTaskList.value = list;

      }
    } finally {
      isLoading(false);
    }
  }



  Future editTask() async {
    indicatorLoader.value=true;
    Map<String, dynamic> map = {
      "tittle":task.tittle,
      "comment":task.comment,
      "start_date":task.startDate,
      "end_date":task.endDate,
      "task_id":task.taskId,
      "status":task.status,
    };
    print("mapp"+map.toString());
    dynamic userData = await TaskService.editTask(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {
        getHomeData();
        indicatorLoader.value=false;
        Get.back();
        showSnackBar("Success", data['message'], Colors.green);
      } else {
        indicatorLoader.value=false;
        showSnackBar("Error", data['message'], Colors.redAccent);
      }
    } else {
      indicatorLoader.value=false;
      showSnackBar("Error", data['message'], Colors.redAccent);
    }
  }


  Future deleteTask(Task task,int pos) async {

    Map<String, dynamic> map = {
      "task_id":task.taskId,

    };
    print("mapp"+map.toString());
    dynamic userData = await TaskService.deleteTask(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {
        getHomeData();
        update();
        Get.back();
        showSnackBar("Success", data['message'], Colors.green);
      } else {
        showSnackBar("Error", data['message'], Colors.redAccent);
      }
    } else {
      showSnackBar("Error", data['message'], Colors.redAccent);
    }
  }

  validation() async{
    if (!formKey.value.currentState.validate()) {
      return false;
    }
    editTask();
  }
}