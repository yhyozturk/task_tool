import 'package:flutter/material.dart';
import 'package:task_tool/models/task_model.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';
import 'package:task_tool/presentation/screens/task_operations.dart';
import 'package:task_tool/utils/common_widgets.dart';

class AllDailyTasksPage extends StatefulWidget {
  @override
  _AllDailyTasksPageState createState() => _AllDailyTasksPageState();
}

class _AllDailyTasksPageState extends State<AllDailyTasksPage> {
  List<TaskModel> allTasks;
  List<TaskModel> favTasks;

  _getTasks(String whichTypeOfTask) async {
    await TaskSqFliteManager().getTasks(whichTypeOfTask).then((value) {
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
    _getTasks("Daily");
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
          "Daily Tasks",
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskOperations(
                    whichTaskType: "Daily",
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
      body: CommonWidgets().taskDesignWidget(context, allTasks, favTasks),
    );
  }
}
