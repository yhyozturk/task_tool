import 'package:flutter/material.dart';
import 'package:task_tool/models/task_model.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';
import 'package:task_tool/presentation/screens/task_operations.dart';
import 'package:task_tool/utils/common_widgets.dart';

class AllWeeklyTasksPage extends StatefulWidget {
  @override
  _AllWeeklyTasksPageState createState() => _AllWeeklyTasksPageState();
}

class _AllWeeklyTasksPageState extends State<AllWeeklyTasksPage> {
  List<TaskModel> allTasks;
  List<TaskModel> favTasks;

  _getWeeklyTasks() async {
    await TaskSqFliteManager().getTasks("Weekly").then((value) {
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
    _getWeeklyTasks();
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
            "Weekly Tasks",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskOperations(
                      whichTaskType: "Weekly",
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
