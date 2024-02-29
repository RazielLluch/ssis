import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:ssis/handlers/file_handler.dart';

class CourseRepo{
    late Future<void> _initializer;
    late FileHandler handler; 
    static bool? exists;

    CourseRepo(){
        handler = FileHandler();
        _initializer = _init();
    }

    Future<void> _init() async{

        exists = await io.File('${handler.getDirectory()}courses.csv').exists();
        // print('Course repository already exists: $exists');
        if(exists == false){  
          // print("Initializing course repository");

          await handler.init([["CourseCode", "CourseName"]],'courses');

          // print("Course repository has been initialized");

        }else{

          // print("Course repository file has already been initialized");
        
        }
        
    }

    void updateCsv(List<List> data){
        FileHandler handler = FileHandler();
        handler.appendCsv(data, 'courses');
    }

    Future<List<List>> getList() async{
        FileHandler handler = FileHandler();
        return await handler.readFile('courses');   
    }

}
