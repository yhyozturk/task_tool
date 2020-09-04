import 'package:flutter/material.dart';
import 'package:task_tool/models/task_model.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';
import 'package:task_tool/presentation/screens/task_operations.dart';
import 'package:task_tool/utils/common_widgets.dart';

class AllMounthlyTasksPage extends StatefulWidget {
  @override
  _AllMounthlyTasksPageState createState() => _AllMounthlyTasksPageState();
}

class _AllMounthlyTasksPageState extends State<AllMounthlyTasksPage> {
  List<TaskModel> allTasks;
  List<TaskModel> favTasks;

  _getMounthlyTasks() async {
    await TaskSqFliteManager().getTasks("Mounthly").then((value) {
      if (value != null) {
        for (var item in value) {
          if (item.isFavorite == "Yes") {
            favTasks.add(item);
          } else {
            allTasks.add(item);
          }
        }
      }
      this.setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    allTasks = List<TaskModel>();
    favTasks = List<TaskModel>();
    _getMounthlyTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue.shade500,
          elevation: 0,
          title: Text(
            "Mounthly Tasks",
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskOperations(
                      whichTaskType: "Mounthly",
                    ),
                  ),
                );
              },
              child: Text(
                "New Tasks",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: CommonWidgets().taskDesignWidget(context, allTasks, favTasks));
  }
}
