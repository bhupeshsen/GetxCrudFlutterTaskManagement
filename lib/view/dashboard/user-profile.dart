import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medvarsity_task/controller/profile-controller.dart';
import 'package:medvarsity_task/custom-widget/containers.dart';
import 'package:medvarsity_task/helper/constant.dart';
import 'package:medvarsity_task/theme/theme-one.dart';

class UserProfile extends StatelessWidget {
  final ProfileController controller=Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 50,),
              Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: new NetworkImage('$USER_IMAGE${controller.users.photo}'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(
                          Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(
                          color: kShadowColor,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ])),
              SizedBox(height: 30,),
              CustomContainer(
                width: size.width,
                  type: "Rectangle",
                  margin: EdgeInsets.only(left: 25,right: 25),
                  padding: EdgeInsets.all(15),child: Text(controller.users.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),

              SizedBox(height: 10,),
              CustomContainer(
                  width: size.width,
                  type: "Rectangle",
                  margin: EdgeInsets.only(left: 25,right: 25),
                  padding: EdgeInsets.all(15),child: Text(controller.users.number,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
