import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medvarsity_task/controller/dashboard-controller.dart';
import 'package:medvarsity_task/controller/task-list-controller.dart';
import 'package:medvarsity_task/custom-widget/containers.dart';
import 'package:medvarsity_task/custom-widget/task-card.dart';
import 'package:medvarsity_task/helper/constant.dart';
import 'package:medvarsity_task/helper/functions.dart';
import 'package:medvarsity_task/theme/theme-one.dart';
import 'package:medvarsity_task/view/dashboard/edit-task.dart';

class Dashboard extends StatelessWidget {
  static final routeName = '/dashboard';
  final DashboardController controller = Get.put(DashboardController());
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(10.0),
              child:  Row(
                children: [
                  Icon(
                    Icons.dashboard,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800,fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    type: "Rectangle",
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Obx((){return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            controller.totalTask.value ?? '0',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );}) ,
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Total",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomContainer(
                    type: "Rectangle",
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Obx((){return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            controller.completeTask.value ?? '0',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );}) ,
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Complete",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    type: "Rectangle",
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Obx((){return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            controller.pendingTask.value ?? '0',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        );}) ,
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Pending",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomContainer(
                    type: "Rectangle",
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                       Obx((){return Padding(
                         padding: const EdgeInsets.all(0.0),
                         child: Text(
                           controller.newTask.value ?? '0',
                           style: TextStyle(
                               color: Colors.black87,
                               fontWeight: FontWeight.bold,
                               fontSize: 20),
                         ),
                       );}) ,
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'New' ,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            Container(
              padding: const EdgeInsets.all(0.0),

              margin: const EdgeInsets.only(left: 10),
              child:   Row(
                children: [
                  Icon(
                    Icons.alarm,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Recent Task',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800,fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

        GetBuilder<DashboardController>(
            initState: (data) => controller.getHomeData(),
    builder: (controller) {

              return Obx(() {return Container(
                margin: EdgeInsets.only(top: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.recentTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(task:controller.recentTaskList[index],onDelete: (task){
                      controller.taskPos=index;
                      controller.task=controller.recentTaskList[index];
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
                                  controller.task=controller.recentTaskList[index];
                                  controller.deleteTask(controller.task, index);
                                },
                              )
                            ],
                          );
                        },
                      );
                    },onEdit: (task){
                      controller.taskPos=index;
                      controller.task=controller.recentTaskList[index];
                      controller.setData();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              elevation: 0,
                              title: Text("Edit Task"),
                              backgroundColor: white,

                            ),
                            backgroundColor: backgroundColor,
                            body: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Form(
                                  key: controller.formKey.value,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
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

                                      SizedBox(
                                        height: 25,
                                      ),
                                      CustomContainer(
                                        type: "Rectangle",
                                        padding: EdgeInsets.all(0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: new InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              contentPadding: const EdgeInsets.all(15.0),
                                              border: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: new BorderSide(
                                                      color: const Color(0xFFE0E0E0), width: 0.1)),
                                              fillColor: Colors.white,
                                              hintText: 'Select Status',
                                              labelText: 'Select Status'),
                                          onChanged: (String newValue) {
                                            controller.task.status= newValue=="Pending" ? "2" :newValue=="New" ? "1" : "3";

                                            //   print( controller.task.status);
                                          },
                                          value: task.statusValue,
                                          validator: (value) =>
                                          value == null ? 'Please select select' : null,
                                          items:  statusArray.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomContainer(
                                        type: "Rectangle",
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                         initialValue: task.tittle ?? '',
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              contentPadding: const EdgeInsets.all(15.0),
                                              border: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: new BorderSide(
                                                      color: const Color(0xFFE0E0E0), width: 0.1)),
                                              fillColor: Colors.white,
                                              hintText: 'Tittle',
                                              labelText: 'Tittle'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter your tittle';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            task.tittle = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomContainer(
                                        type: "Rectangle",
                                        padding: EdgeInsets.all(0),
                                        child: TextFormField(
                                          initialValue: task.comment ?? '',
                                          maxLines: 4,
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              contentPadding: const EdgeInsets.all(15.0),
                                              border: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: new BorderSide(
                                                      color: const Color(0xFFE0E0E0), width: 0.1)),
                                              fillColor: Colors.white,
                                              hintText: 'Comment',
                                              labelText: 'Comment'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter your comment';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            task.comment = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomContainer(
                                              type: "Rectangle",
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(0),
                                              child: TextFormField(
                                                // initialValue: usersDetails.dob == null ? '' : usersDetails.dob,
                                                controller: controller.startDateCtrl,
                                                readOnly: true,
                                                decoration: new InputDecoration(
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.always,
                                                    contentPadding: const EdgeInsets.all(15.0),
                                                    border: new OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: new BorderSide(
                                                            color: const Color(0xFFE0E0E0),
                                                            width: 0.1)),
                                                    fillColor: Colors.white,
                                                    hintText: 'Start Time',
                                                    labelText: 'Start Time'),
                                                onTap: () => showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now(),
                                                ).then((value) {
                                                  controller.startDateCtrl.text = convertDate(value);
                                                  controller.startDate.value = value.toString();
                                                  task.startDate=value.toString();
                                                }),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please select your start date';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomContainer(
                                              type: "Rectangle",
                                              margin: EdgeInsets.all(5),
                                              padding: EdgeInsets.all(0),
                                              child: TextFormField(

                                                controller: controller.endDateCtrl,
                                                readOnly: true,
                                                decoration: new InputDecoration(
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.always,
                                                    contentPadding: const EdgeInsets.all(15.0),
                                                    border: new OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: new BorderSide(
                                                            color: const Color(0xFFE0E0E0),
                                                            width: 0.1)),
                                                    fillColor: Colors.white,
                                                    hintText: 'End Time',
                                                    labelText: 'End Time'),
                                                onTap: () => showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now(),
                                                ).then((value) {
                                                  controller.endDateCtrl.text = convertDate(value);
                                                  controller.endDate.value = value.toString();
                                                  task.endDate=value.toString();
                                                }),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please select your end date';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: size.width,
                                        margin: EdgeInsets.only(top: 20),
                                        child: ButtonTheme(
                                          height: 48,
                                          child: RaisedButton(
                                            onPressed: () => {
controller.validation(),
                                            },
                                            color: accentColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Text('Edit Task',
                                                style: TextStyle(color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },);
                  },
                ),
              );});
    }),


          ],
        ),
      ),
    );
  }
}
