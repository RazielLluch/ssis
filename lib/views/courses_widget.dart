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
  final courseIdController = TextEditingController();
  final courseNameController = TextEditingController();

  _resetControllers(){
    courseIdController.clear();
    courseNameController.clear();
  }

  void _addInfo(List data){
    cRepo = CourseRepo();
    cRepo.updateCsv([data]);

    setState((){
    });
  }
    
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
            height: 500,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left:6.0),
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
                          0: FixedColumnWidth(150),
                          1: FixedColumnWidth(322),
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
                              Center(child: Text(snapshot.data?[0][1]))
                            ]
                          )
                        ],
                      ),
                      Table(
                      // border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(150),
                        1: FixedColumnWidth(322),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: buildTable(snapshot.data!)
                      )
                    ]
                  )
                ),
                Expanded(
                  child: Row(
                    children: [
                      FloatingActionButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                child: Container(
                                  height: 450,
                                  width: 350,
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Edit Course"
                                      ),
                                      TextField(
                                        controller: courseIdController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Input New Course Code'
                                        ),
                                      ),
                                      TextField(
                                        controller: courseNameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Input New Course Name'
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          child: const Text("add"),
                                          onPressed: (){
                                            _addInfo([courseIdController.text, courseNameController.text]);
                                            _resetControllers();
                                            Navigator.pop(context);
                                          },
                                        )
                                      )
                                    ],
                                  )
                                )
                              );
                            }
                          );
                        },
                        tooltip: "Edit Course",
                        child: const Icon(Icons.edit)
                      ),
                      FloatingActionButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Dialog(
                                child: Container(
                                  height: 350,
                                  width: 350,
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Add new Course"),
                                      TextField(
                                        controller: courseIdController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Input Course Code'
                                        ),
                                      ),
                                      TextField(
                                        controller: courseNameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Input Course Name'
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          child: const Text("add"),
                                          onPressed: (){
                                            _addInfo([courseIdController.text,courseNameController.text]);
                                            _resetControllers();
                                            Navigator.pop(context);
                                          },
                                        )
                                      )
                                    ],
                                  )
                                )
                              );
                            }
                          );
                        },
                        tooltip: "Add Course",
                        child: const Icon(Icons.add)
                      )
                    ],
                  ),
                )
              ],
            )
          );
        }
      }
    );
  }
}