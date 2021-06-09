import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medvarsity_task/controller/add-task-controller.dart';
import 'package:medvarsity_task/custom-widget/containers.dart';
import 'package:medvarsity_task/helper/functions.dart';
import 'package:medvarsity_task/theme/theme-one.dart';

class AddTask extends StatelessWidget {
  final AddTaskController controller = Get.put(AddTaskController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  "Add Task",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
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
                child: TextFormField(
                  controller: controller.tittleCtrl,
                  maxLines: 1,
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
                  onChanged: (value) {
                    controller.tittle.value = value;
                    //  controller.tittleCtrl.text=value;
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
                  controller: controller.commentCtrl,
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
                  onChanged: (value) {
                    controller.comment.value = value;
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
                          lastDate: DateTime(2090),
                        ).then((value) {
                          controller.startDateCtrl.text = convertDateTimeTwo(value);
                          controller.startDate.value = value.toString();
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
                        // initialValue: usersDetails.dob == null ? '' : usersDetails.dob,
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
                          lastDate: DateTime(2090),
                        ).then((value) {
                          controller.endDateCtrl.text = convertDateTimeTwo(value);
                          controller.endDate.value = value.toString();
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
                    child: Text('Add Task',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
