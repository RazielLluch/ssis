import 'package:flutter/material.dart';
import 'package:ssis/models/Student.dart';
import 'package:ssis/respository/course_repo.dart';
import 'package:ssis/respository/student_repo.dart';
import 'package:ssis/handlers/searching_handler.dart';
import 'package:ssis/widgets/search_widget.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:ssis/misc/scope.dart';
import 'package:ssis/widgets/students_widget.dart';
import 'package:ssis/widgets/courses_widget.dart';


void main() async{
  CourseRepo cRepo = CourseRepo();
  StudentRepo sRepo = StudentRepo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Student Information System',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SSIS Home Page'),
    );
  }

  //wala pa ni gana
  void setSize() async{
    Size windowSize = await DesktopWindow.getWindowSize();
    windowSize = Size(windowSize.width, windowSize.height);
    await DesktopWindow.setWindowSize(Size(windowSize.width, windowSize.height));
    await DesktopWindow.setMinWindowSize(Size(windowSize.width, windowSize.height));
    await DesktopWindow.setMaxWindowSize(Size(windowSize.width, windowSize.height));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //testing method
  void _addInfo() async{
    CourseRepo cRepo = CourseRepo();
    cRepo.updateCsv([["Bachelor of Science in Computer Science", "BSCS"]]);

    StudentRepo sRepo = StudentRepo();
    sRepo.updateCsv([["2022-0834", "Josiah Raziel S. Lluch", 2, "Male", "BSCS"]]);
  }

  //testing method
  void _search() async{
    print("start search");
    
    SearchHandler sHandler = SearchHandler();
    
    List list = await sHandler.searchItem("BA", Scope.student);
    print(list);
    print("end");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.green,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                color: Colors.yellow,
                child: const Text(
                'Search'
                ),
              ),
              Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: studentsAndCourses(context),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _search,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> studentsAndCourses(context){
    StudentRepo sRepo = StudentRepo();

    return [
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 15.0),
        padding: const EdgeInsets.all(20.0),
        color: Colors.red,
        child: studentsWidget(sRepo)
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left:15.0),
        padding: const EdgeInsets.all(20.0),
        color: Colors.orange,
        child: const CoursesWidget(title: "courses widget"),
      ),
    ];
  }

  Widget studentsWidget(StudentRepo sRepo){
    final Future<List> _sRepoList = sRepo.getList();
    return 
    Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(150),
        1: FixedColumnWidth(80),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            FutureBuilder<List>(
              future: _sRepoList,

              builder: (BuildContext context, AsyncSnapshot<List> snapshot){

                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    Text('Result: ${snapshot.data}'),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Text('Error: ${snapshot.error}'),
                  ];
                } else {
                  children = const <Widget>[
                    Text('Awaiting result...'),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
                
              }
            ),
          ],
        ),
      ],      
    );
  }
}
