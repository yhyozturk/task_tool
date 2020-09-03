import 'package:flutter/material.dart';
import 'package:task_tool/presentation/screens/create_task_page.dart';

class AllWeeklyTasksPage extends StatefulWidget {
  @override
  _AllWeeklyTasksPageState createState() => _AllWeeklyTasksPageState();
}

class _AllWeeklyTasksPageState extends State<AllWeeklyTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weekly Tasks",
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTaskPage(whichTaskType: "Monthly",),
                ),
              );
            },
            child: Text(
              "New Tasks",
            ),
          ),
        ],
      ),
      body: Container(
        child: Text("Soon"),
      ),
    );
  }
}
