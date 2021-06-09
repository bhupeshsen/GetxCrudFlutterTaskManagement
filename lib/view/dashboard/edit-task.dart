import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medvarsity_task/controller/add-task-controller.dart';
import 'package:medvarsity_task/controller/task-list-controller.dart';
import 'package:medvarsity_task/custom-widget/containers.dart';
import 'package:medvarsity_task/helper/constant.dart';
import 'package:medvarsity_task/helper/functions.dart';
import 'package:medvarsity_task/theme/theme-one.dart';

class EditTask extends StatelessWidget {
  static final routeName = '/editTask';
  final TaskListController controller =  Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Edit Task"),
        backgroundColor: white,

      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child:  Form(
            key: controller.formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
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
                  height: 10,
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
                    value:controller.task.statusValue,
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
                    initialValue: controller.task.tittle ,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
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
                      controller.task.tittle =value;
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
                    initialValue:   controller.task.comment ?? '',
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
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
                      controller.task.comment =value;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child:   CustomContainer(
                        type: "Rectangle",
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(0),
                        child: TextFormField(
                          // initialValue: usersDetails.dob == null ? '' : usersDetails.dob,
                          controller:  controller.startDateCtrl,
                          readOnly: true,
                    decoration: new InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.all(15.0),
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: const Color(0xFFE0E0E0), width: 0.1)),
                          fillColor: Colors.white,
                          hintText: 'Start Time',
                          labelText: 'Start Time'),

                          onTap: () => showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2090),
                          ).then((value) {
                            controller.startDateCtrl.text = convertDate(value);
                            controller.task.startDate = value.toString();
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
                      child:   CustomContainer(
                        type: "Rectangle",
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(0),
                        child: TextFormField(
                          // initialValue: usersDetails.dob == null ? '' : usersDetails.dob,
                          controller:  controller.endDateCtrl,
                          readOnly: true,
                          decoration: new InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.all(15.0),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: new BorderSide(
                                      color: const Color(0xFFE0E0E0), width: 0.1)),
                              fillColor: Colors.white,
                              hintText: 'Start Time',
                              labelText: 'Start Time'),
                          onTap: () => showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2090),
                          ).then((value) {
                            controller.endDateCtrl.text = convertDate(value);
                            controller.task.endDate = value.toString();
                          }),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select your end date  ';
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

                        controller.editTask(controller.task,controller.taskPos),
                      },
                      color: accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child:
                      Text('Add Task', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
