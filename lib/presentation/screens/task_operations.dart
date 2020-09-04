import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_tool/models/task_model.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';

class TaskOperations extends StatefulWidget {
  final String whichTaskType;
  final TaskModel updateTask;
  TaskOperations({@required this.whichTaskType, this.updateTask});
  @override
  _TaskOperationsState createState() => _TaskOperationsState();
}

class _TaskOperationsState extends State<TaskOperations> {
  TextEditingController titleTextController;
  TextEditingController contentTextController;
  final formKey = GlobalKey<FormState>();
  TaskModel taskModel;
  bool chcPermanent = false;

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController(
        text: widget.updateTask != null ? widget.updateTask.taskTitle : "");
    contentTextController = TextEditingController(
        text: widget.updateTask != null ? widget.updateTask.taskContent : "");
    taskModel = TaskModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.updateTask != null ? "Update " : "Create ") +
              widget.whichTaskType +
              " Task",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 15),
                      child: TextFormField(
                        controller: titleTextController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.trim() != "") {
                            return null;
                          } else {
                            return "This is required";
                          }
                        },
                        onSaved: (value) {
                          taskModel.taskTitle = value;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: contentTextController,
                      decoration: InputDecoration(
                        labelText: "Content",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.trim() != "") {
                          return null;
                        } else {
                          return "This is required";
                        }
                      },
                      onSaved: (value) {
                        taskModel.taskContent = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Is it permanent",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Checkbox(
                    value: chcPermanent,
                    onChanged: (value) {
                      this.setState(() {
                        chcPermanent = value;
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              width: MediaQuery.of(context).size.width - 24,
              child: FlatButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    taskModel.type = widget.whichTaskType;
                    taskModel.isFavorite = "No";
                    taskModel.isDone = "Not";
                    taskModel.infinite = chcPermanent ? "Permanent" : "Timely";
                    if (widget.updateTask != null) {
                      _updateTaskMethod();
                    } else {
                      _createTaskMethod();
                    }

                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _updateTaskMethod() {
    taskModel.recDate = widget.updateTask.recDate;
    taskModel.sinceEpoch = widget.updateTask.sinceEpoch;
    taskModel.taskID = widget.updateTask.taskID;
    TaskSqFliteManager().updateTask(taskModel);
  }

  _createTaskMethod() {
    DateTime now = DateTime.now();
    taskModel.recDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    taskModel.sinceEpoch = now.millisecondsSinceEpoch.abs();
    //TODO: when firebase added...
    TaskSqFliteManager().handleCreateTask(taskModel);
  }
}
