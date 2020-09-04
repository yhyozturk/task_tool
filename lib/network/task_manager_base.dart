import 'package:task_tool/models/task_model.dart';

abstract class TaskManagerBase {
  handleCreateTask(TaskModel taskModel);
  getTasks(String whichTypeOfTasks);
  updateTask(TaskModel taskModel);
  deleteTask(int taskID);
  updateTaskIsFavorite(TaskModel taskModel);
  updateTaskIsDoneOrNot(TaskModel taskModel);
}
