import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medvarsity_task/helper/util.dart';
import 'package:medvarsity_task/model/Task.dart';
import 'package:medvarsity_task/service/task.dart';
class TaskListController extends GetxController{
  final formKey = GlobalKey<FormState>().obs;
  TextEditingController startDateCtrl;
  TextEditingController statusCtrl;
  RxBool indicatorLoader = false.obs;
  TextEditingController endDateCtrl;
  RxString totalTask = ''.obs;
  RxString selectStatus = ''.obs;
  RxString completeTask = ''.obs;
  RxString runningTask = ''.obs;
  RxString selectDate = ''.obs;
  var isLoading = true.obs;
  var page = 1;
  RxString pendingTask = ''.obs;
  var isMoreDataAvailable = true.obs;
  var taskList = List<Task>.empty(growable: true).obs;

  Task task= Task();
  int taskPos = 0;

  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    startDateCtrl = TextEditingController(text: '');
    endDateCtrl = TextEditingController(text: '');
    statusCtrl= TextEditingController(text: '');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
  void setData(){
    statusCtrl.text=task.statusValue;
    startDateCtrl.text=task.startDate;
    endDateCtrl.text=task.endDate;


  }


  void allTask() async{
    page=1;
    selectDate.value="";
    getAllTaskLisFirstTime();
  }
  void clickDate(date) async{
    page=1;
    selectDate.value=date;
    getAllTaskLisFirstTime();
  }
  void getAllTaskLisFirstTime() async{

    taskList.clear();
    taskList = List<Task>.empty(growable: true).obs;
    page=1;
    scrollController = ScrollController();

    try {
      isLoading(true);
      Map<String, dynamic> map = {
        "page": page,
        "date": selectDate.value
      };

      dynamic resultData = await TaskService.getAllList(map);
      dynamic responseJson = json.decode(resultData.data);
      //here we set the tournaments array in to list

      List listData=responseJson['list'];

      var list=listData.map((m) => new Task.fromJson(m)).toList();
      if (list != null) {
        isMoreDataAvailable(false);
        taskList.addAll(list);
        print("date"+taskList.length.toString());
        paginateList();
      }
    } finally {
      isLoading(false);
    }
  }

  // For Pagination
  void paginateList() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        getAllTaskList();
      }
    });
  }

  void getAllTaskList() async {
    try {

      Map<String, dynamic> map = {
        "page": page,
        "date": selectDate.value
      };

      await TaskService.getAllList(map).then((resultData) {
        dynamic responseJson = json.decode(resultData.data);
        List list=responseJson['list'];

        if (list.length > 0) {
          isMoreDataAvailable(true);
        } else if(list.length==0 || list==null ){
          isMoreDataAvailable(false);
      //    showSnackBar("Message", "No more items", Colors.lightBlueAccent);
        }
        var listData=list.map((m) => new Task.fromJson(m)).toList();
        taskList.addAll(listData);

      }, onError: (err) {
        isMoreDataAvailable(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isMoreDataAvailable(false);
      showSnackBar("Exception", "No more task list", Colors.red);
    }
  }


  void getTaskListByDate() async{

    try {
      isLoading(true);
      Map<String, dynamic> map = {
        "page": page
      };
      dynamic resultData = await TaskService.getAllList(map);
      dynamic responseJson = json.decode(resultData.data);
      //here we set the tournaments array in to list

      List listData=responseJson['list'];
      var list=listData.map((m) => new Task.fromJson(m)).toList();
      if (list != null) {
        taskList.value = list;

      }
    } finally {
      isLoading(false);
    }
  }


  Future editTask(Task task,int pos) async {
    if (!formKey.value.currentState.validate()) {
      return false;
    }
    indicatorLoader.value = true;
    Map<String, dynamic> map = {
      "tittle":task.tittle,
      "comment":task.comment,
      "start_date":task.startDate,
      "end_date":task.endDate,
      "task_id":task.taskId,
      "status":task.status ,
    };
    print("mapp"+map.toString());
    dynamic userData = await TaskService.editTask(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {
        indicatorLoader.value = false;
        taskList[pos]=task;
        page=1;
        endDateCtrl.clear();
        startDateCtrl.clear();
        getAllTaskLisFirstTime();
        update();
        Get.back();
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


  Future deleteTask(Task task,int pos) async {
    indicatorLoader.value = true;
    Map<String, dynamic> map = {
      "task_id":task.taskId,

    };
    print("mapp"+map.toString());
    dynamic userData = await TaskService.deleteTask(map);
    dynamic data = json.decode(userData.data);
    if (userData != null) {
      if (data['status'] == true) {
        indicatorLoader.value = false;
     taskList.removeAt(pos);
        update();
        Get.back();
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