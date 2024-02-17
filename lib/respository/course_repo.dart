import 'dart:io' as io;
import 'dart:convert';
import 'package:ssis/handlers/file_handler.dart';
import 'package:flutter/foundation.dart';

class CourseRepo{

    late FileHandler handler; 

    CourseRepo(){
        handler = FileHandler();
        _init();
    }

    void _init() async{

        bool exists = await io.File('${handler.getDirectory()}courses.csv').exists();
        print(exists);
        if(exists == false){  
          print("Initializing course repository");

          handler.init([["CourseName", "CourseCode"]],'courses');

          print("Course repository has been initialized");

        }else{

          print("Course repository has already been initialized");
        
        }
        
    }

    void updateCsv(List<List> data){
        // FileHandler handler = FileHandler();
        handler.appendCsv(data, 'courses');
    }

    Future<List<List>> getList() async{
        // FileHandler handler = FileHandler();
        return await handler.readFile('courses');   
    }

}
