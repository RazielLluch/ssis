import 'dart:io' as io;
import 'package:ssis/handlers/file_handler.dart';

class StudentRepo{

    late FileHandler handler;

    StudentRepo(){
        handler = FileHandler();
        _init();
    }

    void _init() async{

        bool exists = await io.File('${handler.getDirectory()}students.csv').exists();
        print('Student repository already exists: $exists');
        if(exists == false){  
          print("Initializing student repository");

          handler.init([["IDNum", "StudentName", "yearLvl", "gender", "Course"]],'students');

          print("Student repository has been initialized");

        }else{

          print("Student repository file has already been initialized");
 
        }
        
    }

    void updateCsv(List<List> data){
        // FileHandler handler = FileHandler();
        handler.appendCsv(data, 'students');
    }

    Future<List<List>> getList() async{
        // FileHandler handler = FileHandler();
        return await handler.readFile('students');   
    }

}