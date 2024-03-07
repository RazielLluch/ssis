import 'package:flutter/material.dart';
import 'package:ssis/respository/student_repo.dart';
import 'package:ssis/views/add_button.dart';
import 'package:ssis/views/delete_button.dart';
import 'package:ssis/views/edit_button.dart';
import 'package:ssis/misc/scope.dart';

class StudentsWidget extends StatefulWidget{
  const StudentsWidget({super.key});

  @override
  State<StudentsWidget> createState() => _StudentsWidget();
}

class _StudentsWidget extends State<StudentsWidget>{

  int _selectedRowIndex = -1;
  
  StudentRepo sRepo = StudentRepo();
  late Future<List<List>> data;

  late List<List> tempData = [];

  void callback(){
    setState(() {
      
    });
  }

  void _handleRowTap(int index) {
    setState(() {
      print("preselected index is: $_selectedRowIndex");
      if(index == _selectedRowIndex) {
        _selectedRowIndex = -1;
      }
      else  {
        _selectedRowIndex = index;
      }
      print("postselected index is: $_selectedRowIndex");
    });
  }

  List<TableRow> buildTable(List<List> data){
                  
    List<TableRow> rows = [];

    for(int index = 1; index < data.length; index++){
      rows.add(
        TableRow(
          decoration: BoxDecoration(
            color: _selectedRowIndex == index
            ? Colors.lightBlue.withOpacity(0.5)
            : Colors.transparent,
          ),
          children: [
            GestureDetector(
              onTap: () {
                _handleRowTap(index);
              },
              child: TableCell(
                child: Container(
                  padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
                  child: Text(data[index][0].toString())
                )
              )
            ),
            GestureDetector(
              onTap: () {
                _handleRowTap(index);
              },
              child: TableCell(
                child: Container(
                  padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
                  child: Text(data[index][1].toString())
                )
              )
            ),
            GestureDetector(
              onTap: () {
                _handleRowTap(index);
              },
              child: TableCell(
                child: Container(
                  padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
                  child: Text(data[index][2].toString())
                )
              )
            ),
            GestureDetector(
              onTap: () {
                _handleRowTap(index);
              },
              child: TableCell(
                child: Container(
                  padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
                  child: Text(data[index][3].toString())
                )
              )
            ),
            GestureDetector(
              onTap: () {
                _handleRowTap(index);
              },
              child: TableCell(
                child: Container(
                  padding: const EdgeInsets.only(left: 7, top: 1, bottom: 1),
                  child: Text(data[index][4].toString())
                )
              )
            ),
          ],
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context){
    data = sRepo.getList();

    return FutureBuilder<List<List<dynamic>>>(
      future: data,
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
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
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setter){
                return Column(
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
                            children: buildTable(tempData)
                          ),
                        ]
                      )
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DeleteButton(index: _selectedRowIndex, scope: Scope.student, callback: callback)
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: EditButton(data: snapshot.data!, index: _selectedRowIndex, callback: callback, scope: Scope.student)
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: AddButton(callback: callback)
                          )
                        ]
                      )
                    )
                  ]
                );
              }
            )
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          tempData = snapshot.data!;
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
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setter){
                return Column(
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
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DeleteButton(index: _selectedRowIndex, scope: Scope.student, callback: callback)
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: EditButton(data: snapshot.data!, index: _selectedRowIndex, scope: Scope.student, callback: callback)
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: AddButton(callback: callback)
                          )
                        ]
                      )
                    )
                  ]
                );
              }
            )
          );
        }
      }
    );
  }
}