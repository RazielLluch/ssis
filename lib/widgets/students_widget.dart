// import 'package:flutter/material.dart';
// import 'package:ssis/respository/student_repo.dart';

// class StudentsWidget extends StatefulWidget{
//     const StudentsWidget({super.key, required this.title});
//     final String title;

//   @override
//   State<StudentsWidget> createState() => _StudentsWidget();
// }

// class _StudentsWidget extends State<StudentsWidget>{
  
//   StudentRepo sRepo = StudentRepo();

//   Table readDataTable(){
//     final Future<List> _sRepoList = sRepo.getList();
//     return 
//     Table(
//       border: TableBorder.all(),
//       columnWidths: const <int, TableColumnWidth>{
//         0: FixedColumnWidth(70),  //ID Number
//         1: FixedColumnWidth(200), //Student Name
//         2: FixedColumnWidth(30),  //Year level
//         3: FixedColumnWidth(80),  //Gender
//         4: FixedColumnWidth(100), //Course
//       }
//     );
//   }


//   @override
//   Widget build(BuildContext context){
    
//     return 
//     Table(
//       border: TableBorder.all(),
//       columnWidths: const <int, TableColumnWidth>{
//         0: FixedColumnWidth(100),
//         1: FixedColumnWidth(100),
//       },
//       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//       children: <TableRow>[
//         TableRow(
//           children: <Widget>[
//             FutureBuilder<List>(
//               future: _sRepoList,

//               builder: (BuildContext context, AsyncSnapshot<List> snapshot){

//                 List<Widget> children;
//                 if (snapshot.hasData) {
//                   children = <Widget>[
//                     Text('Result: ${snapshot.data}'),
//                   ];
//                 } else if (snapshot.hasError) {
//                   children = <Widget>[
//                     Text('Error: ${snapshot.error}'),
//                   ];
//                 } else {
//                   children = const <Widget>[
//                     Text('Awaiting result...'),
//                   ];
//                 }
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: children,
//                   ),
//                 );
                
//               }
//             ),
//           ],
//         ),
//       ],      
//     );
//   }
// }