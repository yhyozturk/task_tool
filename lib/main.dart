import 'package:flutter/material.dart';
import 'package:task_tool/presentation/screens/tree_options_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Tool App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TreeOptionsPage(),
    );
  }
}
