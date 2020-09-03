import 'package:flutter/material.dart';
import 'package:task_tool/models/taskModel.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';
import 'package:task_tool/presentation/screens/create_task_page.dart';

class AllDailyTasksPage extends StatefulWidget {
  @override
  _AllDailyTasksPageState createState() => _AllDailyTasksPageState();
}

class _AllDailyTasksPageState extends State<AllDailyTasksPage> {
  List<TaskModel> allTasks;

  _getTasks(String whichTypeOfTask) async {
    await TaskSqFliteManager().getTasks(whichTypeOfTask).then((value) {
      this.setState(() {
        allTasks = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getTasks("Daily");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily Tasks",
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTaskPage(
                    whichTaskType: "Daily",
                  ),
                ),
              );
            },
            child: Text(
              "New Tasks",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            allTasks != null && allTasks.length > 0
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return _sampleWidget(index);
                    },
                    itemCount: allTasks.length,
                    primary: false,
                    shrinkWrap: true,
                  )
                : Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "We can't find any recorded task",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _sampleWidget(int index) {
    return ListTile(
      title: Text(
        allTasks[index].taskTitle,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: allTasks[index].taskContent.length < 20
          ? Text(
              allTasks[index].taskContent,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            )
          : Text(
              allTasks[index].taskContent.substring(0, 19),
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
