import 'dart:io' as io;
import 'dart:convert';
import 'package:ssis/handlers/file_handler.dart';
import 'package:flutter/foundation.dart';

class StudentRepo{

    late FileHandler handler;

    StudentRepo(){
        handler = FileHandler();
        _init();
    }

    void _init() async{

        bool exists = await io.File('${handler.getDirectory()}students.csv').exists();
        print(exists);
        if(exists == false){  
          print("Initializing student repository");

          handler.init([["IDNum", "StudentName", "yearLvl", "gender", "Course"]],'students');

          print("Student repository has been initialized");

        }else{

          print("Student repository has already been initialized");
 
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