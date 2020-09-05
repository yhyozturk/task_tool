import 'package:task_tool/models/task_model.dart';


/*
  Network katmanında olmasını planladığım firebase manager ve sqflite manager aynı metotlara sahip olacakları için bir abstract class altında birleştirilmeli
*/ 
abstract class TaskManagerBase {
  handleCreateTask(TaskModel taskModel);
  getTasks(String whichTypeOfTasks);
  updateTask(TaskModel taskModel);
  deleteTask(int taskID);
  updateTaskIsFavorite(TaskModel taskModel);
  updateTaskIsDoneOrNot(TaskModel taskModel);
}
