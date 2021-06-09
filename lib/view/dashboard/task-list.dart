import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medvarsity_task/controller/task-list-controller.dart';
import 'package:medvarsity_task/custom-widget/horizontal-calendar.dart';
import 'package:medvarsity_task/custom-widget/task-card.dart';

import 'package:medvarsity_task/theme/theme-one.dart';

import 'edit-task.dart';

class TaskList extends StatelessWidget {
  static final routeName = '/taskList';
  final TaskListController controller = Get.put(TaskListController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            child: HorizontalCalendar(
              date: DateTime.now().add(Duration(days: 1)),
              textColor: Colors.black45,
              backgroundColor: backgroundColor,
              selectedColor: accentColor,
              onDateSelected: (date) => {
                controller.clickDate(date.toString()),
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(right: 10),
              child: ButtonTheme(
                height: 35,
                child: RaisedButton(
                  onPressed: () => {
                    controller.allTask(),
                  },
                  color: accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child:
                      Text('All Task', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        
          GetBuilder<TaskListController>(
              initState: (data) => controller.getAllTaskLisFirstTime(),
              builder: (controller) {
                return Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return ListView.builder(
                        controller: controller.scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.taskList.length,
                        itemBuilder: (context, index) {
                          if (index == controller.taskList.length - 1 &&
                              controller.isMoreDataAvailable.value == true) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return TaskCard(task: controller.taskList[index],onDelete: (task){
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('Are you sure want to delete '),
                                  actions: [
                                    TextButton(
                                      child: Text('No'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        controller.task=controller.taskList[index];
                                        controller.deleteTask(task, index);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },onEdit: (task){
                            controller.taskPos=index;
                          controller.task=controller.taskList[index];
                            controller.setData();
                            Get.to(EditTask());
                          },);
                        },
                      );
                  }),
                );
              }),
        ],
      ),
    );
  }
}
