class TaskModel {
  String type;
  int taskID;
  String taskTitle;
  String taskContent;
  String recDate;
  String everyDay;
  int sinceEpoch;

  TaskModel({
    this.type,
    this.taskID,
    this.taskTitle,
    this.taskContent,
    this.recDate,
    this.everyDay,
    this.sinceEpoch,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    taskID = json['taskID'];
    taskTitle = json['taskTitle'];
    taskContent = json['taskContent'];
    recDate = json['recDate'];
    everyDay = json['everyDay'];
    sinceEpoch = json['sinceEpoch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['taskID'] = this.taskID;
    data['taskTitle'] = this.taskTitle;
    data['taskContent'] = this.taskContent;
    data['recDate'] = this.recDate;
    data['everyDay'] = this.everyDay;
    data['sinceEpoch'] = this.sinceEpoch;
    return data;
  }

  TaskModel.fromMap(Map<String, dynamic> tempMap) {
    this.taskID = tempMap["taskID"] != null && tempMap["taskID"] != ""
        ? tempMap["taskID"]
        : 0;
    this.type = tempMap["taskType"];
    this.taskTitle = tempMap["taskTitle"];
    this.taskContent = tempMap["taskContent"];
    this.recDate = tempMap["taskRecDate"];
    this.everyDay = tempMap["taskEveryDay"];
    this.sinceEpoch = tempMap["taskSinceEpoch"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["taskType"] = this.type.toString();
    map["taskTitle"] = this.taskTitle.toString();
    map["taskContent"] = this.taskContent.toString();
    map["taskRecDate"] = this.recDate.toString();
    map["taskEveryDay"] = this.everyDay.toString();
    map["taskSinceEpoch"] = this.sinceEpoch;
    return map;
  }
}
