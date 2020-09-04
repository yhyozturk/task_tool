import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tool/models/db_choose_model.dart';
import 'package:task_tool/models/task_model.dart';

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
  String _columnTaskInfinite = "taskInfinite";
  String _columnTaskSinceEpoch = "taskSinceEpoch";
  String _columnTaskIsFavorite = "taskIsFavorite";
  String _columnTaskIsDone = "taskIsDone";

  String _dbChooseTable = "tblDBChoose";
  String _columnLokalID = "dbcLokalID";
  String _columnDBName = "dbcName";

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
    String path = join(directory.path, "task_tool_v0.0.7.db");

    var dbInfo = await openDatabase(path, version: 1, onCreate: _createDB);

    return dbInfo;
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_taskTable ($_columnTaskID INTEGER PRIMARY KEY, $_columnTaskType TEXT," +
          " $_columnTaskTitle TEXT, $_columnTaskContent TEXT, $_columnTaskRecDate TEXT," +
          " $_columnTaskInfinite TEXT, $_columnTaskSinceEpoch INTEGER, $_columnTaskIsFavorite TEXT," +
          " $_columnTaskIsDone TEXT )",
    );
    await db.execute(
      "CREATE TABLE $_dbChooseTable ($_columnLokalID INTEGER PRIMARY KEY, " +
          "$_columnDBName TEXT )",
    );
  }

  Future<DBChooseModel> getDBChoose() async {
    var db = await _getDatabase();
    var result = await db.rawQuery("SELECT * FROM $_dbChooseTable");
    if (result.length > 0) {
      return DBChooseModel.fromMap(result[0]);
    } else {
      return null;
    }
  }

  Future<int> insertDBChoose(DBChooseModel dbc) async {
    var db = await _getDatabase();
    var result = await db.insert(_dbChooseTable, dbc.toMap());

    return result;
  }

  Future<int> updateDBChoose(DBChooseModel dbc) async {
    var db = await _getDatabase();
    var result = await db.update(_dbChooseTable, dbc.toMap());

    return result;
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

  Future<int> updateTask(TaskModel taskModel) async {
    var db = await _getDatabase();
    var result = await db.rawUpdate(
      "UPDATE $_taskTable SET $_columnTaskTitle='${taskModel.taskTitle}',$_columnTaskContent='${taskModel.taskContent}' WHERE $_columnTaskID = ${taskModel.taskID}",
    );

    return result;
  }

  Future<int> updateTaskToDoneOrNot(TaskModel taskModel) async {
    var db = await _getDatabase();
    var result = await db.rawUpdate(
      "UPDATE $_taskTable SET $_columnTaskIsDone='${taskModel.isDone}'" +
          " WHERE $_columnTaskID=${taskModel.taskID}",
    );

    return result;
  }

  Future<int> updateTasktToFavorite(TaskModel taskModel) async {
    var db = await _getDatabase();
    var result = await db.rawUpdate(
      "UPDATE $_taskTable SET $_columnTaskIsFavorite='${taskModel.isFavorite}' WHERE $_columnTaskID=${taskModel.taskID}",
    );

    return result;
  }

  Future<int> deleteEpochLimitTasks(String whichTypeOfTasks) async {
    var db = await _getDatabase();
    int epochLimit = 0;
    switch (whichTypeOfTasks) {
      case "Daily":
        epochLimit =
            DateTime.now().add(Duration(days: -1)).millisecondsSinceEpoch.abs();
        break;
      case "Weekly":
        epochLimit =
            DateTime.now().add(Duration(days: -7)).millisecondsSinceEpoch.abs();
        break;
      case "Mounthly":
        epochLimit = DateTime.now()
            .add(Duration(days: -30))
            .millisecondsSinceEpoch
            .abs();
        break;
      default:
        break;
    }
    var result = await db.rawDelete(
      "DELETE FROM $_taskTable WHERE $_columnTaskSinceEpoch < $epochLimit " +
          "AND $_columnTaskType='$whichTypeOfTasks' AND $_columnTaskInfinite='Timely'",
    );
    debugPrint(
        "epoch delete resuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuult: " +
            result.toString());
    return result;
  }

  Future<int> deleteTask(int taskID) async {
    var db = await _getDatabase();
    var result = await db
        .rawDelete("DELETE FROM $_taskTable WHERE $_columnTaskID=$taskID");

    return result;
  }
}
