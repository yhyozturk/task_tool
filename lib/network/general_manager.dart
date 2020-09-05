import 'package:task_tool/data_access/sqflite_helper.dart';
import 'package:task_tool/models/db_choose_model.dart';

class GeneralManager {
  //Veritabanı erişimini presantation layer da yapmak yerine network katmanında yapıyoruz.
  /*Proje daha geniş kapsamlı olduğunda gerekli kontroller ve değişiklikler farklı platformlardan gelebileceği için,
     gerekli kontrol ve değişimleri burada yapacaktık*/
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
