import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medvarsity_task/controller/login-controller.dart';
import 'package:medvarsity_task/custom-widget/containers.dart';
import 'package:medvarsity_task/custom-widget/rounded_button.dart';
import 'package:medvarsity_task/theme/theme-one.dart';
import 'package:medvarsity_task/view/auth/register.dart';
import 'package:medvarsity_task/view/dashboard/home.dart';

class UserLogin extends StatelessWidget {
  static final routeName = '/userLogin';
  LoginController controller = Get.put(LoginController());

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
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return CustomContainer(
                        padding: EdgeInsets.all(0),
                        child: TextFormField(
                          maxLength: 10,
                          initialValue: controller.mobile.value ?? '',
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              counter: Offstage(),
                              contentPadding: const EdgeInsets.all(15.0),
                              errorText: controller.mobileNameErrorText.value,
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
                            controller.mobileChange(value);
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
                          maxLength: 8,
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
                              errorText: controller.passwordErrorText.value,
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
                              hintText: 'Enter Password',
                              labelText: 'Enter Password'),
                          onChanged: (value) {
                            controller.passwordChange(value);
                          },
                        ),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                      text: "Login",
                      color: colorPrimary,
                      textColor: Colors.white,
                      press: () {
                        if (controller.submitBtnCheck.value) {
                          controller.userLogin();
                        }
                      },
                    ),

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child:Wrap(
                        children: [
                           Text('Don`t have an Account ? ',
                                style: Theme.of(context).textTheme.headline6.merge(
                                    TextStyle(
                                        fontSize: 13,
                                        color: Colors.black))),

                          GestureDetector(
                            onTap: (){
                              Get.to(UserRegister());
                            },
                            child: Text('Sign Up',
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
