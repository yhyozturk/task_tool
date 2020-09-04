class TaskModel {
  String type;
  int taskID;
  String taskTitle;
  String taskContent;
  String recDate;
  String infinite;
  int sinceEpoch;
  String isFavorite;
  String isDone;

  TaskModel({
    this.type,
    this.taskID,
    this.taskTitle,
    this.taskContent,
    this.recDate,
    this.infinite,
    this.sinceEpoch,
    this.isFavorite,
    this.isDone,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    taskID = json['taskID'];
    taskTitle = json['taskTitle'];
    taskContent = json['taskContent'];
    recDate = json['recDate'];
    infinite = json['infinite'];
    sinceEpoch = json['sinceEpoch'];
    isFavorite = json['isFavorite'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['taskID'] = this.taskID;
    data['taskTitle'] = this.taskTitle;
    data['taskContent'] = this.taskContent;
    data['recDate'] = this.recDate;
    data['infinite'] = this.infinite;
    data['sinceEpoch'] = this.sinceEpoch;
    data['isFavorite'] = this.isFavorite;
    data['isDone'] = this.isDone;
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
    this.infinite = tempMap["taskInfinite"];
    this.sinceEpoch = tempMap["taskSinceEpoch"];
    this.isFavorite = tempMap["taskIsFavorite"];
    this.isDone = tempMap["taskIsDone"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["taskType"] = this.type.toString();
    map["taskTitle"] = this.taskTitle.toString();
    map["taskContent"] = this.taskContent.toString();
    map["taskRecDate"] = this.recDate.toString();
    map["taskInfinite"] = this.infinite.toString();
    map["taskSinceEpoch"] = this.sinceEpoch;
    map["taskIsFavorite"] = this.isFavorite;
    map["taskIsDone"] = this.isDone;
    return map;
  }
}
