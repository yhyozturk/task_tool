class DBChooseModel {
  int lokalID;
  String name;

  DBChooseModel({this.lokalID, this.name});

  DBChooseModel.fromJson(Map<String, dynamic> json) {
    lokalID = json['lokalID'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lokalID'] = this.lokalID;
    data['name'] = this.name;
    return data;
  }

  //Lokal veritabanı map<> olarak sonuç verdiği ve insert ederken ise map<> olarak istediği için .fromMap ve toMap metotları yazılmıştır.
  DBChooseModel.fromMap(Map<String, dynamic> tempMap) {
    this.lokalID = tempMap["dbcLokalID"];
    this.name = tempMap["dbcName"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["dbcName"] = this.name.toString();

    return map;
  }
}
