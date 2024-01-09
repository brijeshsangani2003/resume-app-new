import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resume/views/detail_screen.dart';
import 'package:resume/views/home_screen.dart';
import 'package:resume/views/resume_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home_screen(),
    );
  }
}
