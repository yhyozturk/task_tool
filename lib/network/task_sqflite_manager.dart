import 'package:task_tool/data_access/sqflite_helper.dart';
import 'package:task_tool/models/taskModel.dart';
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
}
