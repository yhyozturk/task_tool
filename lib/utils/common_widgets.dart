import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_tool/models/task_model.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';
import 'package:task_tool/presentation/screens/all_daily_tasks_page.dart';
import 'package:task_tool/presentation/screens/all_monthly_tasks_page.dart';
import 'package:task_tool/presentation/screens/all_weekly_tasks_page.dart';
import 'package:task_tool/presentation/screens/task_operations.dart';
import 'package:task_tool/utils/alert_helper.dart';

class CommonWidgets {
  Widget taskDesignWidget(BuildContext context, List<TaskModel> allTasks,
      List<TaskModel> favTasks) {
    return SingleChildScrollView(
      child: Column(
        children: [
          (allTasks == null || allTasks.length <= 0) &&
                  (favTasks == null || favTasks.length <= 0)
              ? Container(
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
                )
              : Column(
                  children: [
                    favTasks.length > 0
                        ? ListView.builder(
                            padding: EdgeInsets.only(top: 15),
                            itemBuilder: (context, index) {
                              return _sampleWidget(
                                allTasks: favTasks,
                                index: index,
                                context: context,
                              );
                            },
                            itemCount: favTasks.length,
                            primary: false,
                            shrinkWrap: true,
                          )
                        : SizedBox(
                            height: 1,
                          ),
                    allTasks.length > 0
                        ? ListView.builder(
                            padding: EdgeInsets.only(top: 15),
                            itemBuilder: (context, index) {
                              return _sampleWidget(
                                allTasks: allTasks,
                                index: index,
                                context: context,
                              );
                            },
                            itemCount: allTasks.length,
                            primary: false,
                            shrinkWrap: true,
                          )
                        : SizedBox(
                            height: 1,
                          ),
                  ],
                )
        ],
      ),
    );
  }

  _sampleWidget({
    List<TaskModel> allTasks,
    int index,
    @required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 3, color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.all(5),
      child: ListTile(
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
                allTasks[index].taskContent.substring(0, 19) + "...",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskOperations(
                whichTaskType: allTasks[index].type,
                updateTask: allTasks[index],
              ),
            ),
          );
        },
        onLongPress: () {
          AlertHelper().yesNoAlertDraft(
              context, "Attention", "Are you sure you want to delete", () {
            String lokalType = allTasks[index].type;
            TaskSqFliteManager().deleteTask(allTasks[index].taskID);
            allTasks.removeAt(index);
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => _whichPage(lokalType),
              ),
            );
          }, () {
            Navigator.pop(context);
          });
        },
        trailing: Checkbox(
            value: allTasks[index].isDone == "Not" ? false : true,
            onChanged: (value) {
              allTasks[index].isDone = value ? "Done" : "Not";
              TaskSqFliteManager().updateTaskIsDoneOrNot(allTasks[index]);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => _whichPage(allTasks[index].type),
                ),
              );
            }),
        leading: GestureDetector(
          onTap: () {
            _importantTaskMethod(allTasks, index, context);
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.star,
                color: allTasks[index].isFavorite == "Yes"
                    ? Colors.yellow
                    : Colors.grey,
              ),
              onPressed: () {
                _importantTaskMethod(allTasks, index, context);
              },
            ),
          ),
        ),
      ),
    );
  }

  _whichPage(String whichPageType) {
    switch (whichPageType) {
      case "Daily":
        return AllDailyTasksPage();
        break;
      case "Weekly":
        return AllWeeklyTasksPage();
        break;
      case "Mounthly":
        return AllMounthlyTasksPage();
        break;
      default:
        break;
    }
  }

  void _importantTaskMethod(
    List<TaskModel> allTasks,
    int index,
    BuildContext context,
  ) {
    if (allTasks[index].isFavorite == "Yes") {
      allTasks[index].isFavorite = "No";
    } else {
      allTasks[index].isFavorite = "Yes";
    }
    TaskSqFliteManager().updateTaskIsFavorite(allTasks[index]);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _whichPage(allTasks[index].type),
      ),
    );
  }
}
