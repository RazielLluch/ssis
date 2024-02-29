import 'package:flutter/material.dart';
import 'package:ssis/respository/course_repo.dart';
import 'package:ssis/respository/student_repo.dart';
import 'package:ssis/widgets/students_widget.dart';
import 'package:ssis/widgets/courses_widget.dart';
import 'package:ssis/widgets/search_widget.dart';
import 'package:ssis/handlers/searching_handler.dart';
import 'package:ssis/misc/scope.dart';

class ParentWidget extends StatefulWidget{
  const ParentWidget({super.key, required this.title});
  final String title;

  @override
  State<ParentWidget> createState() => _ParentWidget();
}

class _ParentWidget extends State<ParentWidget>{

  //testing method
  void _addInfo() async{

    CourseRepo cRepo = CourseRepo();
    cRepo.updateCsv([["BSCS", "Bachelor of Science in Computer Science"]]);

    StudentRepo sRepo = StudentRepo();
    sRepo.updateCsv([["2022-0834", "Josiah Raziel S. Lluch", 2, "Male", "BSCS"]]);

    setState((){
    });
  }

  //testing method
  void _search() async{
    print("start search");
    
    SearchHandler sHandler = SearchHandler();
    
    List list = await sHandler.searchItem("BS", Scope.course);
    print(list);
    print("end");
  }

  @override
  build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          width: 1165,
          // decoration: const BoxDecoration(
          //   shape: BoxShape.rectangle,
          //   color: Colors.green,
          // ),
          margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          alignment: Alignment.center,
          child: Align(
            alignment: FractionalOffset.topCenter,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  // color: Colors.yellow,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                  'Search'
                  ),
                ),
                Container(
                  // color: Colors.blue,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black),
                  // ), 
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: studentsAndCourses(context),
                    ),
                  )
                )
              ],
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addInfo,
        tooltip: 'search',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> studentsAndCourses(context){
    return [
      StudentsWidget(),
      CoursesWidget()
    ];
  }
}