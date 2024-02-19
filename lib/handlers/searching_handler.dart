import 'package:ssis/respository/course_repo.dart';
import 'package:ssis/respository/student_repo.dart';
import 'package:ssis/misc/scope.dart';

class SearchHandler{
    SearchHandler();

    Future<List<dynamic>> searchItem(var query, Scope scope)async{
        
        List<List> validSearches = [];
        List<List> rawSearches;
        if(scope == Scope.course){
            CourseRepo cRepo = CourseRepo();
            rawSearches = await cRepo.getList();
        } else{
            StudentRepo sRepo = StudentRepo();
            rawSearches = await sRepo.getList();
        }

        // print('raw searches: $rawSearches');

        for(int i = 1; i < rawSearches.length; i++){
            List temp = rawSearches[i];
            for(var val in temp){
                if(val.toString().toLowerCase().trim().contains(query.toLowerCase())){
                    validSearches.add(temp);
                }
            }
        }

        print('valid searches: $validSearches');

        return validSearches;
    }

    // Future<bool> containsValue(List data, var value) async{

    // }
}

void main()async{

    print("start");
    SearchHandler handler = SearchHandler();
    var results = await handler.searchItem("BSCS", Scope.student);

    print('results: $results');

}