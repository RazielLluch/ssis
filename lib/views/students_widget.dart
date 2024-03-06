import 'package:flutter/material.dart';
import 'package:ssis/respository/student_repo.dart';
import 'package:ssis/respository/course_repo.dart';
import 'package:ssis/views/add_button.dart';
import 'package:ssis/views/edit_button.dart';

class StudentsWidget extends StatefulWidget{
  const StudentsWidget({super.key});

  @override
  State<StudentsWidget> createState() => _StudentsWidget();
}

class _StudentsWidget extends State<StudentsWidget>{

  StudentRepo sRepo = StudentRepo();
  late Future<List<List>> data;

  List<TableRow> buildTable(List<List> data){
    
    List<TableRow> rows = [];

    for(int i = 1; i < data.length; i++){
      rows.add(
        TableRow(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
              child: Text(data[i][0].toString())
            ),
            Container(
              padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
              child: Text(data[i][1].toString())
            ),
            Container(
              padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
              child: Text(data[i][2].toString())
            ),
            Container(
              padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
              child: Text(data[i][3].toString())
            ),
            Container(
              padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
              child: Text(data[i][4].toString())
            ),
          ],
        ),
      );
    }

    return rows;
  }

  void callback(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context){
    data = sRepo.getList();

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
            height: 500,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(right:6.0),
            // padding: const EdgeInsets.all(20.0),
            // color: Colors.orange,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 440,
                  child: Column(
                    children: [
                      Table(
                        border: const TableBorder(bottom: BorderSide(color: Colors.black)),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(100),
                          1: FixedColumnWidth(303),
                          2: FixedColumnWidth(70),
                          3: FixedColumnWidth(100),
                          4: FixedColumnWidth(100),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.black)
                                  )
                                ),
                                child: Text(snapshot.data?[0][0])
                                ),
                              Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.black)
                                  )
                                ),
                                child: Text(snapshot.data?[0][1])
                                ),
                              Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.black)
                                  )
                                ),
                                child: Text(snapshot.data?[0][2])
                                ),
                              Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.black)
                                  )
                                ),
                                child: Text(snapshot.data?[0][3])
                              ),
                              Center(child: Text(snapshot.data?[0][4])
                              )
                            ]
                          ),
                        ],
                      ),
                      Table(
                        // border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(100),
                          1: FixedColumnWidth(303),
                          2: FixedColumnWidth(70),
                          3: FixedColumnWidth(100),
                          4: FixedColumnWidth(100),
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: buildTable(snapshot.data!)
                      ),
                    ]
                  )
                ),
                Expanded(
                  child: Row(
                    children: [
                      const EditButton(),
                      AddButton(callback: callback)
                    ]
                  )
                )
              ]
            )
          );
        }
      }
    );
  }
}