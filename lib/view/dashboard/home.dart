import 'package:medvarsity_task/controller/home-controller.dart';
import 'package:medvarsity_task/custom-widget/bottom-nav.dart';
import 'package:medvarsity_task/theme/theme-one.dart';
import 'package:medvarsity_task/view/dashboard/task-list.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medvarsity_task/view/dashboard/user-profile.dart';

import 'add-task.dart';
import 'dashboard.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  static final routeName = '/home';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [

        ],
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: Text('Are you sure want to logout '),
                  actions: [
                    TextButton(
                      child: Text('No'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        controller.logout();
                      },
                    )
                  ],
                );
              },
            ),
          },
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.bottomChange(index);
          },
          children: <Widget>[
            Dashboard(),
            AddTask(),
            TaskList(),
            UserProfile(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          color: backgroundColor,
          width: size.width,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
//        border:  Border.all(color: Colors.orange),
                color: accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ]),
            child: BottomNavyBar(
              backgroundColor: accentColor,
              showElevation: true,
              selectedIndex: controller.rxIndex.value,
              onItemSelected: (index) {
                controller.bottomChange(index);
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                    activeColor: Colors.white,
                    title: Text(
                      'Home',
                      style: TextStyle(color: accentColor),
                    ),
                    icon: Image.asset(
                      'assets/images/dashboard1.png',
                      height: 25,
                      color:
                          controller.rxIndex.value == 0 ? accentColor : white,
                    )),
                BottomNavyBarItem(
                    activeColor: Colors.white,
                    title: Text(
                      'Add Task',
                      style: TextStyle(color: accentColor),
                    ),
                    icon: Image.asset(
                      'assets/images/plus.png',
                      height: 25,
                      color:
                          controller.rxIndex.value == 1 ? accentColor : white,
                    )),
                BottomNavyBarItem(
                    activeColor: Colors.white,
                    title: Text(
                      'Task List',
                      style: TextStyle(color: accentColor),
                    ),
                    icon: Image.asset(
                      'assets/images/clipboard1.png',
                      height: 25,
                      color:
                          controller.rxIndex.value == 2 ? accentColor : white,
                    )),
                BottomNavyBarItem(
                    activeColor: Colors.white,
                    title: Text(
                      'Profile',
                      style: TextStyle(color: accentColor),
                    ),
                    icon: Image.asset(
                      'assets/images/user.png',
                      height: 25,
                      color:
                      controller.rxIndex.value == 3 ? accentColor : white,
                    ))

              ],
            ),
          ),
        );
      }),
    );
  }
}
