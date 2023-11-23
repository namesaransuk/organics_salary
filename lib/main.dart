import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/pages/home/home_page.dart';

void main() {
  Get.lazyPut(() => GetConnect());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Organics Salary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(19, 110, 104, 1),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
