import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_tool/models/taskModel.dart';
import 'package:task_tool/network/task_sqflite_manager.dart';

class CreateTaskPage extends StatefulWidget {
  final String whichTaskType;
  CreateTaskPage({@required this.whichTaskType});
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  TextEditingController titleTextController;
  TextEditingController contentTextController;
  final formKey = GlobalKey<FormState>();
  TaskModel taskModel;

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController();
    contentTextController = TextEditingController();
    taskModel = TaskModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create " + widget.whichTaskType + " Task"),
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
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              width: MediaQuery.of(context).size.width - 24,
              child: FlatButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    DateTime now = DateTime.now();
                    formKey.currentState.save();
                    taskModel.type = widget.whichTaskType;
                    taskModel.recDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                    taskModel.sinceEpoch = now.millisecondsSinceEpoch.abs();
                    //TODO: when firebase added...
                    TaskSqFliteManager().handleCreateTask(taskModel);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "SUBMIT",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
