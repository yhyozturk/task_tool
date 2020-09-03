import 'package:task_tool/models/taskModel.dart';

abstract class TaskManagerBase {
  handleCreateTask(TaskModel taskModel);
  getTasks(String whichTypeOfTasks);
}
