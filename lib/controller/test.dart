import 'package:flutter/material.dart';

class StatefullWidgetDemo extends StatefulWidget {
  @override
  _StatefulWidgetDemoState createState() {
    return new _StatefulWidgetDemoState();
  }
}

class _StatefulWidgetDemoState extends State<StatefullWidgetDemo> {
  String _textFromFile = "";

  _StatefulWidgetDemoState() {
    getTextFromFile().then((val) => setState(() {
          _textFromFile = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text('Stateful Demo'),
      ),
      body:  SingleChildScrollView(
        padding:  EdgeInsets.all(8.0),
        child:  Text(
          _textFromFile,
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }

  Future<String> getFileData(String path) async {
    return "your data from file";
  }

  Future<String> getTextFromFile() async {
    return await getFileData("test.txt");
  }
}