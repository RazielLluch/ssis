import 'package:flutter/material.dart';
import 'package:ssis/views/parent_widget.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async{
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Student Information System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple Student Information System'),
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
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // CourseRepo();
    // StudentRepo();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ParentWidget(title: widget.title);
  } 
}
