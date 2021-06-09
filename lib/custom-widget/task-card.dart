import 'package:flutter/material.dart';
import 'package:medvarsity_task/custom-widget/containers.dart';
import 'package:medvarsity_task/model/Task.dart';
import 'package:medvarsity_task/theme/theme-one.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final ValueChanged<Task> onDelete;
  final ValueChanged<Task> onEdit;
  TaskCard({this.task,this.onDelete,this.onEdit});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      type: "Rectangle",
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              task.statusValue,
              style: TextStyle(
                  color: Color(int.parse(task.statusColor)),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                  //                   <--- left side
                  color: Color(int.parse(task.statusColor)),
                  width: 5.0,
                )),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(task.tittle,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(task.comment, style: TextStyle(color: Colors.grey,fontSize: 14,))
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.alarm,
                    color: Colors.black54,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${task.startDate} - ${task.endDate}',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'edit${task.taskId}',
                child: Icon(Icons.edit_outlined, color: accentColor),
                backgroundColor: Colors.white,
                elevation: 4,
                mini: true,
                onPressed: () {
                  onEdit(task);
                },
              ),
              FloatingActionButton(
                heroTag: 'delete${task.taskId}',
                child: Icon(Icons.delete, color: accentColor),
                backgroundColor: Colors.white,
                elevation: 4,
                mini: true,
                onPressed: () {
                  onDelete(task);
                },
              )

            ],
          )

        ],
      ),
    );
  }
}
