import 'package:task_tool/data_access/sqflite_helper.dart';
import 'package:task_tool/models/task_model.dart';
import 'package:task_tool/network/task_manager_base.dart';

class TaskSqFliteManager extends TaskManagerBase {
  @override
  handleCreateTask(TaskModel taskModel) async {
    await SqfliteHelper().createTask(taskModel);
  }

  @override
  Future<List<TaskModel>> getTasks(String whichTypeOfTasks) async {
    return await SqfliteHelper().getTasks(whichTypeOfTasks);
  }

  @override
  updateTask(TaskModel taskModel) async {
    await SqfliteHelper().updateTask(taskModel);
  }

  @override
  deleteTask(int taskID) async {
    await SqfliteHelper().deleteTask(taskID);
  }

  @override
  updateTaskIsFavorite(TaskModel taskModel) async {
    await SqfliteHelper().updateTasktToFavorite(taskModel);
  }

  deleteEpochLimitTasks(String whichTypeOfTasks) async {
    await SqfliteHelper().deleteEpochLimitTasks(whichTypeOfTasks);
  }

  @override
  updateTaskIsDoneOrNot(TaskModel taskModel) async {
    await SqfliteHelper().updateTaskToDoneOrNot(taskModel);
  }
}
