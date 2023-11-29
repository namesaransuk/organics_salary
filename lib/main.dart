import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/pages/auth/login_page.dart';
import 'package:organics_salary/pages/auth/register_page.dart';
import 'package:organics_salary/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => GetConnect());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ThemeData _buildTheme(brightness) {
  //   var baseTheme = ThemeData(
  //     brightness: brightness,
  //     primaryColor: Color.fromRGBO(19, 110, 104, 1),
  //     useMaterial3: true,
  //   );

  //   return baseTheme.copyWith(
  //     textTheme: GoogleFonts.notoSansThaiTextTheme(baseTheme.textTheme),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Organics Salary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(19, 110, 104, 1),
          useMaterial3: true,
          textTheme: GoogleFonts.promptTextTheme(),
        ),
        // home: HomePage(),
        initialRoute: '/',
        defaultTransition: Transition.cupertino,
        getPages: [
          GetPage(name: '/', page: () => HomePage()),
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(name: '/register', page: () => const RegisterPage()),
        ]);
  }
}
