import 'dart:io' as io;
import 'package:ssis/handlers/file_handler.dart';

class StudentRepo{

    late Future<void> _initializer;
    late FileHandler handler;
    static bool? exists = false;

    StudentRepo(){
        handler = FileHandler();
        _initializer = _init();
    }


    Future<void> _init() async{

        exists = await io.File('${handler.getDirectory()}students.csv').exists();
        // print('Student repository already exists: $exists');
        if(exists == false){  
          // print("Initializing student repository");

          await handler.init([["IDNum", "StudentName", "yearLvl", "gender", "Course"]],'students');

          // print("Student repository has been initialized");

        }else{

          // print("Student repository file has already been initialized");
 
        }
        
    }

    void updateCsv(List<List> data){
        FileHandler handler = FileHandler();
        handler.appendCsv(data, 'students');
    }

    Future<List<List>> getList() async{
        FileHandler handler = FileHandler();
        return await handler.readFile('students');   
    }

}