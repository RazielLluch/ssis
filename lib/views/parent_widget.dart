import 'package:flutter/material.dart';
import 'package:ssis/respository/course_repo.dart';
import 'package:ssis/respository/student_repo.dart';
import 'package:ssis/views/students_widget.dart';
import 'package:ssis/views/courses_widget.dart';
import 'package:ssis/views/search_widget.dart';
import 'package:ssis/handlers/searching_handler.dart';
import 'package:ssis/misc/scope.dart';

class ParentWidget extends StatefulWidget{
  const ParentWidget({super.key, required this.title});
  final String title;

  @override
  State<ParentWidget> createState() => _ParentWidget();
}

class _ParentWidget extends State<ParentWidget>{

  final cNameController = TextEditingController();
  final cCodeController = TextEditingController();
  final sIDController = TextEditingController();
  final sNameController = TextEditingController();
  final sYrController = TextEditingController();
  final sGenderController = TextEditingController();
  final sCourseController = TextEditingController();

  //testing method
  void _addInfo(List data, Scope scope){

    if(scope == Scope.course){
      CourseRepo cRepo = CourseRepo();
      cRepo.updateCsv([data]);
    }
    else if(scope == Scope.student){
      StudentRepo sRepo = StudentRepo();
      sRepo.updateCsv([data]);
    }

    // StudentRepo sRepo = StudentRepo();
    // sRepo.updateCsv([["2022-0834", "Josiah Raziel S. Lluch", 2, "Male", "BSCS"]]);

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
        centerTitle: true,
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
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Text(
                  'Search'
                  ),
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: studentsAndCourses(context),
                    ),
                  )
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  List<Widget> studentsAndCourses(context){
    return [
      const StudentsWidget(),
      const CoursesWidget()
    ];
  }
}