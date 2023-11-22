import 'package:flutter/material.dart';
import 'package:organics_salary/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organics Salary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(19, 110, 104, 0)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
