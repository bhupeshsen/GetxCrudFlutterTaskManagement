class Task {
  String statusColor;
  String statusValue;
  String taskId;
  String tittle;
  String comment;
  String startDate;
  String endDate;
  String status;
  String userId;

  Task(
      {this.statusColor,
        this.statusValue,
        this.taskId,
        this.tittle,
        this.comment,
        this.startDate,
        this.endDate,
        this.status,
        this.userId});

  Task.fromJson(Map<String, dynamic> json) {
    statusColor = json['status_color'];
    statusValue = json['status_value'];
    taskId = json['task_id'];
    tittle = json['tittle'];
    comment = json['comment'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_color'] = this.statusColor;
    data['status_value'] = this.statusValue;
    data['task_id'] = this.taskId;
    data['tittle'] = this.tittle;
    data['comment'] = this.comment;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    return data;
  }
}
