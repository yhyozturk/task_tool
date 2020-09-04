import 'package:task_tool/data_access/sqflite_helper.dart';
import 'package:task_tool/models/db_choose_model.dart';

class GeneralManager {
  Future<DBChooseModel> getDBChoose() async {
    return await SqfliteHelper().getDBChoose();
  }

  insertDBChoose(DBChooseModel dbc) async {
    await SqfliteHelper().insertDBChoose(dbc);
  }

  updateDBChoose(DBChooseModel dbc) async {
    await SqfliteHelper().updateDBChoose(dbc);
  }
}
