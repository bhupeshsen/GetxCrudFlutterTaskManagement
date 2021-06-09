import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:medvarsity_task/helper/constant.dart';
import 'package:medvarsity_task/helper/shared-pref.dart';
import 'package:medvarsity_task/model/users.dart';

class UserApiServices {
  static var dio = new Dio();
  static Users  users;
  static SharedPref sharedPref;

  // here getUserLogin function is use for user login from server
  // here i am passing param in map number:'',password:''
  static Future<dynamic> getUserLogin(map) async {
    FormData body = FormData.fromMap(map);
    dio.options.headers =  {"Accept": "application/json","SK": "","DID": "1234"};
    Response<String> response = await dio.post('$USER_API/login', data: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      //show error message
      return null;
    }
  }







  static Future<dynamic> mobileNumberCheck(map) async {
    Dio dio = new Dio();


    FormData body = FormData.fromMap(map);
    Response<String>   response = await dio.post('$USER_API/get-otp', data: body);
    print("data"+response.data.toString());
    if (response.statusCode == 200) {
      return response;
    } else {
      //show error message
      return null;
    }
  }
  //
  static Future<dynamic> otpVerify(map) async {
    Dio dio = new Dio();


    FormData body = FormData.fromMap(map);
    Response<String>   response = await dio.post('$USER_API/match-otp', data: body);
    print("data"+response.data.toString());
    if (response.statusCode == 200) {
      return response;
    } else {
      //show error message
      return null;
    }
  }

  // here getUserSessionData function is use for getting data from SharedPreferences
  // SharedPreferences is class for storing local data in session
  static Future<Users> getUserSessionData() async {
    SharedPref sharedPref = SharedPref();
    dynamic data = await sharedPref.read('userData', false);
    dynamic jsonData = json.decode(data);
    Users users = Users.fromJson(jsonData);
    return users;
  }



  static Future<dynamic> userRegister(map) async {
    var DID="1234";
    FormData body = FormData.fromMap(map);
    dio.options.headers =  {"Accept": "application/json","SK":"","DID": DID};
    Response<String> response = await dio.post('$USER_API/user-register', data: body);
    if (response.statusCode == 200) {
      return response;
    } else {
      //show error message
      return null;
    }
  }

}
