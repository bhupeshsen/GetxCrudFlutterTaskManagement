import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medvarsity_task/helper/constant.dart';
import 'package:medvarsity_task/helper/shared-pref.dart';
import 'package:medvarsity_task/model/users.dart';

class TaskService{
  static Users  users;
  static SharedPref sharedPref;
  static var dio = new Dio();
  static Future<dynamic> getHome() async {

    sharedPref =SharedPref();
    dynamic sessionData = await sharedPref.read('userData', false);
    if(sessionData!=null){
      dynamic  jsonData=json.decode(sessionData);
      users=Users.fromJson(jsonData);
    }
    var DID="1234";
    var sk=users.sk;
    Map<String, dynamic> map = {
      "user_id": users.userId,
    };
    FormData body = FormData.fromMap(map);
    dio.options.headers =  {"Accept": "application/json","SK": sk,"DID": DID};
    Response<String> response = await dio.post('$USER_API/get-home-data',data: body);
    if (response.statusCode == 200) {
      dio.options.headers['content-Type'] = 'application/json';
      return response;
    } else {
      return null;
    }
  }


  static Future<dynamic> getAllList(map) async {

    sharedPref =SharedPref();
    dynamic sessionData = await sharedPref.read('userData', false);
    if(sessionData!=null){
      dynamic  jsonData=json.decode(sessionData);
      users=Users.fromJson(jsonData);
    }
    var DID="1234";
    var sk=users.sk;

    FormData body = FormData.fromMap(map);
    dio.options.headers =  {"Accept": "application/json","SK": sk,"DID": DID};
    Response<String> response = await dio.post('$USER_API/get-task',data: body);
    if (response.statusCode == 200) {
      dio.options.headers['content-Type'] = 'application/json';
      return response;
    } else {
      return null;
    }
  }


  static Future<dynamic> addTask(map) async {

    sharedPref =SharedPref();
    dynamic sessionData = await sharedPref.read('userData', false);
    if(sessionData!=null){
      dynamic  jsonData=json.decode(sessionData);
      users=Users.fromJson(jsonData);
    }
    var DID="1234";
    var sk=users.sk;
    FormData body = FormData.fromMap(map);
    dio.options.headers =  {"Accept": "application/json","SK":sk,"DID": DID};
    Response<String> response = await dio.post('$USER_API/add-task', data: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      //show error message
      return null;
    }
  }


  static Future<dynamic> editTask(map) async {

    sharedPref =SharedPref();
    dynamic sessionData = await sharedPref.read('userData', false);
    if(sessionData!=null){
      dynamic  jsonData=json.decode(sessionData);
      users=Users.fromJson(jsonData);
    }
    var DID="1234";
    var sk=users.sk;
    FormData body = FormData.fromMap(map);
    dio.options.headers =  {"Accept": "application/json","SK":sk,"DID": DID};
    Response<String> response = await dio.post('$USER_API/edit-task', data: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      //show error message
      return null;
    }
  }


  static Future<dynamic> deleteTask(map) async {

    sharedPref =SharedPref();
    dynamic sessionData = await sharedPref.read('userData', false);
    if(sessionData!=null){
      dynamic  jsonData=json.decode(sessionData);
      users=Users.fromJson(jsonData);
    }
    var DID="1234";
    var sk=users.sk;
    FormData body = FormData.fromMap(map);
    dio.options.headers =  {"Accept": "application/json","SK":sk,"DID": DID};
    Response<String> response = await dio.post('$USER_API/delete-task', data: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      //show error message
      return null;
    }
  }

}