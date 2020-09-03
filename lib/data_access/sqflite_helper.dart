import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tool/models/taskModel.dart';

class SqfliteHelper {
  static SqfliteHelper _sqfliteHelper;
  static Database _database;

  SqfliteHelper._internal();

  String _taskTable = "tblTask";
  String _columnTaskType = "taskType";
  String _columnTaskID = "taskID";
  String _columnTaskTitle = "taskTitle";
  String _columnTaskContent = "taskContent";
  String _columnTaskRecDate = "taskRecDate";
  String _columnTaskEveryDay = "taskEveryDay";
  String _columnTaskSinceEpoch = "taskSinceEpoch";

  factory SqfliteHelper() {
    if (_sqfliteHelper == null) {
      _sqfliteHelper = SqfliteHelper._internal();

      return _sqfliteHelper;
    } else {
      return _sqfliteHelper;
    }
  }

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "task_tool_v0.0.1.db");

    var dbInfo = await openDatabase(path, version: 1, onCreate: _createDB);

    return dbInfo;
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_taskTable ($_columnTaskID INTEGER PRIMARY KEY, $_columnTaskType TEXT," +
          " $_columnTaskTitle TEXT, $_columnTaskContent TEXT, $_columnTaskRecDate TEXT," +
          " $_columnTaskEveryDay TEXT, $_columnTaskSinceEpoch INTEGER )",
    );
  }

  Future<List<TaskModel>> getTasks(String whichTypeOfTasks) async {
    var db = await _getDatabase();
    var result = await db.rawQuery(
        "SELECT * FROM $_taskTable WHERE $_columnTaskType= '$whichTypeOfTasks'");
    List<TaskModel> allTasks = List<TaskModel>();
    if (result.length > 0) {
      for (var item in result) {
        allTasks.add(TaskModel.fromMap(item));
      }
    } else {
      allTasks = null;
    }
    return allTasks;
  }

  Future<int> createTask(TaskModel task) async {
    var db = await _getDatabase();
    var result = await db.insert(_taskTable, task.toMap());

    return result;
  }
}
