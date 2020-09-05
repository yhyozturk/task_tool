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

  //Bu alanlar, ilgili methodları yazarken veritabanı ve kolon isimlerinde yapılabilecek hata oranını azaltmak için yazıldı.
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

  //Telefon dosyaları arasında oluşturulmul bir veri tabanı varsa tekrar oluşturulması engellendi
  factory SqfliteHelper() {
    if (_sqfliteHelper == null) {
      _sqfliteHelper = SqfliteHelper._internal();

      return _sqfliteHelper;
    } else {
      return _sqfliteHelper;
    }
  }

  // Singleton kullanılarak her _getDatabase() kullanıldığında aynı db dönmesi sağlandı.
  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  //Lokal veritabanını oluşturan metot
  _initializeDatabase() async {

    Directory directory = await getApplicationDocumentsDirectory(); //Uygulamanın dosya yolu alınıyor
    String path = join(directory.path, "task_tool_v0.0.7.db");  // .db uzantılı olması şartıyla benzersiz bir isim veriliyor

    var dbInfo = await openDatabase(path, version: 1, onCreate: _createDB); //Verilen bilgilerle db'yi döndüren metot

    return dbInfo;
  }

  // Oluşturulacak tabloların sql cümleleri derleniyor
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

  //Ayarlar sekmeksinde uygulamanın çalışma şeklini seçerken önceki seçime ulaşmamızı sağlayan metot
  Future<DBChooseModel> getDBChoose() async {
    var db = await _getDatabase();
    var result = await db.rawQuery("SELECT * FROM $_dbChooseTable");
    if (result.length > 0) {
      return DBChooseModel.fromMap(result[0]);
    } else {
      return null;
    }
  }

  //Ayarlardan db seçimini ilk defa yaptığımızda çalışan metot
  Future<int> insertDBChoose(DBChooseModel dbc) async {
    var db = await _getDatabase();
    var result = await db.insert(_dbChooseTable, dbc.toMap());

    return result;
  }

  //Ayarlardan db seçimini değiştirdiğimizde gerekli güncellemeyi yapan metot
  Future<int> updateDBChoose(DBChooseModel dbc) async {
    var db = await _getDatabase();
    var result = await db.update(_dbChooseTable, dbc.toMap());

    return result;
  }

  //Verilen görev tipine göre veritabanında yer alan bütün görevler listesine ulaşmamızı sağlayan metot
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

  //Gelen modelde yer alan bilgilerle veritabanına  görev insert eden metot
  Future<int> createTask(TaskModel task) async {
    var db = await _getDatabase();
    var result = await db.insert(_taskTable, task.toMap());

    return result;
  }

  //Gelen modelde yer alan bilgilere göre veritabanındaki kolonları güncelleyen metot
  Future<int> updateTask(TaskModel taskModel) async {
    var db = await _getDatabase();
    var result = await db.rawUpdate(
      "UPDATE $_taskTable SET $_columnTaskTitle='${taskModel.taskTitle}',$_columnTaskContent='${taskModel.taskContent}' WHERE $_columnTaskID = ${taskModel.taskID}",
    );

    return result;
  }

  //Sadece görev tamamlandı ve tamamlanmadı güncellemesi için yazılmış metot
  Future<int> updateTaskToDoneOrNot(TaskModel taskModel) async {
    var db = await _getDatabase();
    var result = await db.rawUpdate(
      "UPDATE $_taskTable SET $_columnTaskIsDone='${taskModel.isDone}'" +
          " WHERE $_columnTaskID=${taskModel.taskID}",
    );

    return result;
  }

  //Sadece görevi önemli/yıldızlı olarak işaretlemek ve çıkarmak için yazılmış bir metot
  Future<int> updateTasktToFavorite(TaskModel taskModel) async {
    var db = await _getDatabase();
    var result = await db.rawUpdate(
      "UPDATE $_taskTable SET $_columnTaskIsFavorite='${taskModel.isFavorite}' WHERE $_columnTaskID=${taskModel.taskID}",
    );

    return result;
  }

  //Daha önce kayıt edilmiş görevler görüntülenmek için ana menüden ilgili butona tıklandığında;
  //eğer görev oluşturulurken kalıcı olarak işaretlenmediyse, günü geçen görevleri silen metot
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

  //Kullanıcının isteği üzerine belirlediği görevi veritabanından silen metot
  Future<int> deleteTask(int taskID) async {
    var db = await _getDatabase();
    var result = await db
        .rawDelete("DELETE FROM $_taskTable WHERE $_columnTaskID=$taskID");

    return result;
  }
}
