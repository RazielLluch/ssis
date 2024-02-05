import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';

class FileHandler{

    void writeFile(List<List<String>> data, String file_name) async{
        String csv = const ListToCsvConverter().convert(data);
        Directory dir = Directory.fromUri(Uri.directory('userdata'));
        File file = new File(file_name);
        List<List<String>> something = [[]];
        print(csv);
    }
}

void main(){
  FileHandler handler = new FileHandler();
  handler.writeFile([['course_code','course_name']], 'courses.csv');
}
