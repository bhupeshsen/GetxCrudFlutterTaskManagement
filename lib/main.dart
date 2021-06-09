import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medvarsity_task/theme/theme-one.dart';
import 'package:medvarsity_task/view/auth/Splash-screen.dart';
import 'package:medvarsity_task/view/auth/login.dart';
import 'package:medvarsity_task/view/dashboard/edit-task.dart';
import 'package:medvarsity_task/view/dashboard/home.dart';

import 'view/auth/user-authentication.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: "MEDVARSITY",
      initialRoute: "/",
      routes: {
        '/':(context)=> SplashScreen(),
        UserLogin.routeName :(context)=>UserLogin(),
        Home.routeName :(context)=>Home(),
        UserAuth.routeName :(context)=>UserAuth(),
        EditTask.routeName :(context)=>EditTask(),

      },
      theme: ThemeData(
        primaryColor: colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

    );
  }

}
