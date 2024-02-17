import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart' as csv;
import 'package:ssis/misc/scope.dart';
import 'package:ssis/models/Course.dart';

class FileHandler{ 

    late final Directory dir;

    FileHandler(){
        dir = Directory.fromUri(Uri.directory('userdata'));
    }
    
    String getDirectory(){
      return dir.absolute.path;
    }

    //in progress
    Future<List<List>> readFile(String file_name) async{
        File csvFile = File('${dir}$file_name.csv');
        return await csvToList(csvFile);
    }

    //ni gana na
    void init(List<List> data, String filename) async{

        String directory = '${dir.absolute.path}$filename.csv';
        print('This is your file directory: $directory');
        await File(directory).create(recursive: true).then((File file){
        });

        appendCsv(data, filename);
    }  

    void appendCsv(List<List> data, String filename)async{

        print("appedCsv Start\n");
        File csvFile = File('${dir.absolute.path}$filename.csv');
        List<List> csvList = await csvToList(csvFile);

        

        print('1: $csvList');

        for(int i = 0; i < data.length; i++){
            csvList.add(data[i]);
        }
    
        print('2: $csvList');
        String csv = await listToCsv(csvList);
        print('3: $csv');

        saveCsvFile(csv, csvFile);
        print("appendCsv end");
    }

    saveCsvFile(String data, File csvFile){
        csvFile.writeAsStringSync(data);
    }

    //ni gana na
    Future<String> listToCsv(List<List> listToConvert) async{
        csv.ListToCsvConverter c = const csv.ListToCsvConverter(); 
        return await c.convert(listToConvert, fieldDelimiter: ','); //default field delimiter is ','
    }

    //ni gana na 
    Future<List<List>> csvToList(File myCsvFile)async{

        csv.CsvToListConverter c = 
            const csv.CsvToListConverter(eol: "\r\n", fieldDelimiter: ",");
        print(myCsvFile.readAsStringSync());
        return await c.convert(myCsvFile.readAsStringSync());
    }
}

// void main(){

//     FileHandler handler = FileHandler();
//     handler.init('courses');

//     List<List> data =
//         [
//             ['course_name', 'course_code'],
//             ['Bachelor of Science in Computer Science', 'BSCS']
//         ];

//     handler.appendCsv(data, 'courses');
// }
