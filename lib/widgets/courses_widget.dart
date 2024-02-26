import 'package:flutter/material.dart';
import 'package:ssis/respository/course_repo.dart';
import 'package:ssis/respository/student_repo.dart';

class CoursesWidget extends StatefulWidget{
  const CoursesWidget({super.key, required this.title});
  final String title;

  @override
  State<CoursesWidget> createState() => _CoursesWidget();
}

class _CoursesWidget extends State<CoursesWidget>{
  
  CourseRepo cRepo = CourseRepo();

  List<TableRow> readDataTable(){
    final Future<List> _cRepoList = cRepo.getList();
    List<TableRow> rows = [
      TableRow(
        children: [
          FutureBuilder( 
            future: _cRepoList,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Text('Result: ${snapshot.data?[0][0]}'),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Text('Error: ${snapshot.error}'),
                  ];
              } else {
                children = const <Widget>[
                  Text('Awaiting result...'),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }
          ),
          FutureBuilder( 
            future: _cRepoList,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  Text('Result: ${snapshot.data?[0][1]}'),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Text('Error: ${snapshot.error}'),
                  ];
              } else {
                children = const <Widget>[
                  Text('Awaiting result...'),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }
          ),
        ]//columns
      )
    ];

    //insert iterable code here to add the other rows

    return rows;
  }


  @override
  Widget build(BuildContext context){
    return 
    Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(100),
        1: FixedColumnWidth(100),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: readDataTable()  
    );
  }
}