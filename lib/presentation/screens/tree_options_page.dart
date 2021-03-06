import 'package:flutter/material.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';
import 'package:task_tool/presentation/screens/all_daily_tasks_page.dart';
import 'package:task_tool/presentation/screens/all_monthly_tasks_page.dart';
import 'package:task_tool/presentation/screens/all_weekly_tasks_page.dart';
import 'package:task_tool/presentation/screens/settingsPage.dart';

class TreeOptionsPage extends StatefulWidget {
  @override
  _TreeOptionsPageState createState() => _TreeOptionsPageState();
}

class _TreeOptionsPageState extends State<TreeOptionsPage> {
  List<String> allTaskTypes;

  @override
  void initState() {
    super.initState();
    allTaskTypes = ["Daily", "Weekly", "Monthly"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Types",
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 5),
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allTaskTypes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              TaskSqFliteManager().deleteEpochLimitTasks(allTaskTypes[index]);
              chooseAPage(index);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.blueGrey,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              width: MediaQuery.of(context).size.width - 50,
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  chooseAnIcon(index),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      allTaskTypes[index],
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
        },
      ),
    );
  }

  chooseAnIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.timer);
        break;
      case 1:
        return Icon(Icons.today);
        break;
      case 2:
        return Icon(Icons.view_agenda);
        break;
      default:
        return Icon(Icons.timer);
    }
  }

  void chooseAPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllDailyTasksPage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllWeeklyTasksPage(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllMounthlyTasksPage(),
          ),
        );
        break;
      default:
    }
  }
}
