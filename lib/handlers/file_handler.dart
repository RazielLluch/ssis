import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart' as csv;
import 'package:ssis/misc/scope.dart';
import 'package:ssis/models/Course.dart';
class FileHandler{

    late final Directory dir;

    FileHandler(String directoryName){
        dir = Directory.fromUri(Uri.directory('userdata'));
    }
    
    //in progress
    void readFile(List<List<String>> data, String file_name) async{
        String csvFile = const csv.ListToCsvConverter().convert(data);
        Directory dir = Directory.fromUri(Uri.directory('userdata'));
        File file = File(file_name);
        List<List<String>> something = [[]];
    }

    //ni gana na
    void init(String filename){
        Scope scope;
        if(filename == 'courses') scope = Scope.course;
        else scope = Scope.student;

        filename = '${dir.absolute.path}$filename.csv';
        print(filename);

        File(filename).create(recursive: true).then((File file){
            if(scope == Scope.student){
                List<List> data = [['course_name','course_code']];
                appendCsv(data, filename);
            }
        });
    }  

    void appendCsv(List<List> data, String filename){

        // print(filename);
        File csvFile = File('${dir.absolute.path}$filename');
        List<List> csvList = csvToList(csvFile);

        

        print(csvList);

        // csvList.add(data);
        for(int i = 0; i < data.length; i++){
            csvList.add(data[i]);
        }
    
        print(csvList);

        String csv = listToCsv(csvList);
        print(csv);

        saveCsvFile(csv, csvFile);

    }

    saveCsvFile(String data, File csvFile){
        csvFile.writeAsStringSync(data);
    }

    //ni gana na
    String listToCsv(List<List> listToConvert){
        csv.ListToCsvConverter c = const csv.ListToCsvConverter(); 
        return c.convert(listToConvert, fieldDelimiter: ','); //default field delimiter is ','
    }

    //ni gana na 
    List<List> csvToList(File myCsvFile){
        csv.CsvToListConverter c = 
            const csv.CsvToListConverter(eol: "\r\n", fieldDelimiter: ",");
        print(myCsvFile.readAsStringSync());
        return c.convert(myCsvFile.readAsStringSync());
    }
}

void main(){

    FileHandler handler = FileHandler('userdata');
    handler.init('courses');

    List<List> data =
        [
            ['course_name', 'course_code'],
            ['Bachelor of Science in Computer Science', 'BSCS']
        ];

    handler.appendCsv(data, 'courses.csv');
}
