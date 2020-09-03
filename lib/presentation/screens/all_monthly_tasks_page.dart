import 'package:flutter/material.dart';
import 'package:task_tool/presentation/screens/create_task_page.dart';

class AllMounthlyTasksPage extends StatefulWidget {
  @override
  _AllMounthlyTasksPageState createState() => _AllMounthlyTasksPageState();
}

class _AllMounthlyTasksPageState extends State<AllMounthlyTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mounthly Tasks",
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTaskPage(whichTaskType: "Weekly",),
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
