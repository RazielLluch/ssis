import 'Course.dart';

class Student{
    late String _studentName;
    late String _studentId;
    String? _yearLvl;
    late String _gender;
    String? _course;

    Student(){

    }

    void setStudentName(String name){
        _studentName = name;
    }

    void setStudentId(String id){
        _studentId = id;
    }

    void setYearLevel(String year){
        _yearLvl = year;
    }    

    void setGender(String gender){
        _gender = gender;
    }

    void setCourse(Course course){
        _course = course.getCourseCode();   
    }
}