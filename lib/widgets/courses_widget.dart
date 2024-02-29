import 'package:flutter/material.dart';
import 'package:ssis/respository/course_repo.dart';

class CoursesWidget extends StatefulWidget{
  const CoursesWidget({super.key});

  @override
  State<CoursesWidget> createState() => _CoursesWidget();
}

class _CoursesWidget extends State<CoursesWidget>{
  
  CourseRepo cRepo = CourseRepo();
  late Future<List<List>> data;
    
  List<TableRow> buildTable(List<List> data){
    
    List<TableRow> rows = [];

    for(int i = 1; i < data.length; i++){
      rows.add(
        TableRow(
          children: [
            Center(child: Text(data[i][0].toString())),
            Center(child: Text(data[i][1].toString())),
          ],
        ),
      );
    }
    return rows;
  }


  @override
  Widget build(BuildContext context){

    data = cRepo.getList();

    return FutureBuilder<List<List<dynamic>>>(
      future: data,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left:8.0),
            // padding: const EdgeInsets.all(20.0),
            // color: Colors.orange,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(150),
                    1: FixedColumnWidth(322),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      
                      children: [
                        Center(child: Text(snapshot.data?[0][0])),
                        Center(child: Text(snapshot.data?[0][1]))
                      ]
                    )
                  ],
                ),
                Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(150),
                  1: FixedColumnWidth(322),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: buildTable(snapshot.data!)
                )
              ],
            )
          );
        }
      }
    );
  }
}