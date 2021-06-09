import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medvarsity_task/controller/register-controller.dart';

import 'package:medvarsity_task/custom-widget/containers.dart';
import 'package:medvarsity_task/custom-widget/image-picker.dart';
import 'package:medvarsity_task/custom-widget/rounded_button.dart';
import 'package:medvarsity_task/theme/theme-one.dart';
import 'package:medvarsity_task/view/auth/login.dart';

class UserRegister extends StatelessWidget {
  static final routeName = '/userLogin';
  RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 250,
                width: size.width,
                margin: EdgeInsets.only(top: 50, left: 15, right: 15),
                child: Lottie.asset('assets/taskadd.json')),
            Obx((){return controller.indicatorLoader.value ? Center(
                child: Column(
                  children: [
                    SizedBox(

                      height:50,
                      width:50,
                      child: CircularProgressIndicator(
                          valueColor:
                          new AlwaysStoppedAnimation<
                              Color>(Colors.white),
                          backgroundColor: colorPrimary),
                    ),
                    Text("Please Wait..",style: TextStyle(color: colorPrimary,fontWeight: FontWeight.w800),)
                  ],
                ) ) :SizedBox();}),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Obx(() {
                      return controller.photoPath.value.length > 0
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SnImagePicker(
                                      onSourceChanged: (source) {
                                        controller.addPhoto(source);
                                        // Dismiss Bottom Sheet
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                              child: Center(
                                  child: Image.file(
                                      File(controller.photoPath.value),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover)))
                          : Center(
                              child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SnImagePicker(
                                          onSourceChanged: (source) {
                                            controller.addPhoto(source);
                                            // Dismiss Bottom Sheet
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.person_add_alt_1_rounded,
                                    size: 70,
                                    color: colorPrimary,
                                  )));
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return CustomContainer(
                        padding: EdgeInsets.all(0),
                        child: TextFormField(
                          initialValue: controller.name.value ?? '',
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              counter: Offstage(),
                              contentPadding: const EdgeInsets.all(15.0),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: new BorderSide(
                                      color: const Color(0xFFE0E0E0),
                                      width: 0.1)),
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Enter Name',
                              labelText: 'Enter Name'),
                          onChanged: (data) {
                            controller.name.value = data;
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return CustomContainer(
                        padding: EdgeInsets.all(0),
                        child: TextFormField(

                          initialValue: controller.mobile.value ?? '',
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              counter: Offstage(),
                              contentPadding: const EdgeInsets.all(15.0),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: new BorderSide(
                                      color: const Color(0xFFE0E0E0),
                                      width: 0.1)),
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.send_to_mobile),
                              hintText: 'Phone Number',
                              labelText: 'Phone Number'),
                          onChanged: (value) {
                            controller.mobile.value = value;
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return CustomContainer(
                        padding: EdgeInsets.all(0),
                        child: TextFormField(
                          obscureText:
                              controller.passwordHideShow.value == "hide"
                                  ? true
                                  : false,
                          initialValue: controller.password.value ?? '',
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              counter: Offstage(),
                              contentPadding: const EdgeInsets.all(15.0),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: new BorderSide(
                                      color: const Color(0xFFE0E0E0),
                                      width: 0.1)),
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    controller.passwordHideShow.value == "hide"
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: colorPrimary),
                                padding: EdgeInsets.only(right: 10, left: 5),
                                onPressed: () => {
                                  controller
                                      .toggle(controller.passwordHideShow.value)
                                },
                              ),
                              hintText: 'Password',
                              labelText: 'Password'),
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return CustomContainer(
                        padding: EdgeInsets.all(0),
                        child: TextFormField(
                          obscureText:
                              controller.passwordHideShow.value == "hide"
                                  ? true
                                  : false,
                          initialValue: controller.confirmPassword.value ?? '',
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              counter: Offstage(),
                              contentPadding: const EdgeInsets.all(15.0),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: new BorderSide(
                                      color: const Color(0xFFE0E0E0),
                                      width: 0.1)),
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    controller.cnfPasswordHideShow.value ==
                                            "hide"
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: colorPrimary),
                                padding: EdgeInsets.only(right: 10, left: 5),
                                onPressed: () => {
                                  controller.toggle(
                                      controller.cnfPasswordHideShow.value)
                                },
                              ),
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password'),
                          onChanged: (value) {
                            controller.confirmPassword.value = value;
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                      text: "Register",
                      color: colorPrimary,
                      textColor: Colors.white,
                      press: () {
                        controller.validation();
                      },
                    ),

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child:Wrap(
                        children: [
                         Text('Already have an account ? ',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6.merge(
                                    TextStyle(
                                        fontSize: 13,
                                        color: Colors.black))),

                          GestureDetector(
                            onTap: (){
                              Get.to(UserLogin());
                            },
                            child: Text('Login',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6.merge(
                                    TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                          )
                        ],
                      ),
                    )

                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
