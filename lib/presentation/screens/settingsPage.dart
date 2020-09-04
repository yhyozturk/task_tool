import 'package:flutter/material.dart';
import 'package:task_tool/models/db_choose_model.dart';
import 'package:task_tool/network/general_manager.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool chcOnline = false;
  bool chcLocal = true;
  DBChooseModel dbChooseModel = DBChooseModel();

  _getDBChoose() async {
    await GeneralManager().getDBChoose().then((value) {
      if (value != null) {
        if (value.name == "Firebase") {
          chcOnline = true;
          chcLocal = false;
        }
        this.setState(() {
          dbChooseModel = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDBChoose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          FlatButton(
            onPressed: () {
              if (chcOnline) {
                dbChooseModel.name = "Firebase";
              } else {
                dbChooseModel.name = "Sqflite";
              }

              if (dbChooseModel.lokalID == null) {
                GeneralManager().insertDBChoose(dbChooseModel);
              } else {
                GeneralManager().updateDBChoose(dbChooseModel);
              }
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 3),
                    child: Text(
                      "How would you like the app to work?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Online",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Checkbox(
                            value: chcOnline,
                            onChanged: (value) {
                              if (value) {
                                chcLocal = false;
                              } else {
                                chcLocal = true;
                              }
                              this.setState(() {
                                chcOnline = value;
                              });
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Local",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Checkbox(
                            value: chcLocal,
                            onChanged: (value) {
                              if (value) {
                                chcOnline = false;
                              } else {
                                chcOnline = true;
                              }
                              this.setState(() {
                                chcLocal = value;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Text(
                "This setting is not working for now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
