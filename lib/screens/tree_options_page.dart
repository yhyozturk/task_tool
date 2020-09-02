import 'package:flutter/material.dart';

class TreeOptionsPage extends StatefulWidget {
  @override
  _TreeOptionsPageState createState() => _TreeOptionsPageState();
}

class _TreeOptionsPageState extends State<TreeOptionsPage> {
  List<String> allTask;

  @override
  void initState() {
    super.initState();
    allTask = ["Daily", "Weekly", "Monthly"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Types",
        ),
      ),
      body: ListView.builder(
          itemCount: allTask.length,
          itemBuilder: (context, index) {
            return Container(
              child: Center(
                child: Text("Soon"),
              ),
            );
          }),
    );
  }
}
