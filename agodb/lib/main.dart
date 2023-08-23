import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/annual_students_model.dart';
import 'models/annual_subjects_model.dart';
import 'models/class_model.dart';
import 'models/student_model.dart';
import 'models/subject_model.dart';
import 'models/term_model.dart';
import 'pages/home.dart';
import 'store/colors.dart';

const String classBox = "name";
const String schoolBox = "school";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ClassAdapter());
  Hive.registerAdapter(TermClassAdapter());
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(StudentAnnualAdapter());
  Hive.registerAdapter(SubjectAnnualAdapter());
  await Hive.openBox<Class>(classBox);
  await Hive.openBox<String>(schoolBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Results System',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 165,
        backgroundColor: appBackground,
        splash: Image.asset("assets/logo.png"),
        duration: 3000,
        nextScreen: const Home(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
