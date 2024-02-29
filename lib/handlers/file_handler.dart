import 'dart:io';
import 'package:csv/csv.dart' as csv;
class FileHandler{ 

    late final Directory dir;

    FileHandler(){
        dir = Directory.fromUri(Uri.directory('userdata'));
    }
    
    String getDirectory(){
      return dir.absolute.path;
    }

    Future<List<List>> readFile(String filename) async{
        File csvFile = File('${getDirectory()}$filename.csv');
        return await csvToList(csvFile);
    }

    Future<void> init(List<List> data, String filename) async{

        String directory = '${getDirectory()}$filename.csv';
        // print('This is your file directory: $directory');
        await File(directory).create(recursive: true).then((File file){
        });

        await appendCsv(data, filename);
    }  

    Future<void> appendCsv(List<List> data, String filename)async{

        // print("appedCsv Start\n");

        File csvFile = File('${getDirectory()}$filename.csv');
        List<List> csvList = await csvToList(csvFile);

        // print('1: $csvList');

        for(int i = 0; i < data.length; i++){
            csvList.add(data[i]);
        }
    
        // print('2: $csvList');
        String csv = await listToCsv(csvList);
        // print('3: $csv');

        await saveCsvFile(csv, csvFile);
        // print("appendCsv end");
    }

    deleteFromCsv(){
      
    }

    saveCsvFile(String data, File csvFile)async{
      csvFile.writeAsStringSync(data);
    }

    Future<String> listToCsv(List<List> listToConvert) async{
        csv.ListToCsvConverter c = const csv.ListToCsvConverter(); 
        return await c.convert(listToConvert, fieldDelimiter: ','); //default field delimiter is ','
    }

    Future<List<List>> csvToList(File myCsvFile)async{

        csv.CsvToListConverter c = 
            const csv.CsvToListConverter(eol: "\r\n", fieldDelimiter: ",");
            
        // print('converting csv to list: ${myCsvFile.readAsStringSync()}');
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
