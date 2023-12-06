import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/pages/auth/login_page.dart';
import 'package:organics_salary/pages/auth/register_page.dart';
import 'package:organics_salary/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('th', null);
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
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('th'),
          const Locale('en'),
          const Locale('us'),
        ],
        locale: Locale('th'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
           dividerTheme: DividerThemeData(
          color: Colors.black,
          // thickness: 2,
        ),
          dividerColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(0xFF136E68, {
              50: Color(0xFF136E68),
              100: Color(0xFF136E68),
              200: Color(0xFF136E68),
              300: Color(0xFF136E68),
              400: Color(0xFF136E68),
              500: Color(0xFF136E68),
              600: Color(0xFF136E68),
              700: Color(0xFF136E68),
              800: Color(0xFF136E68),
              900: Color(0xFF136E68),
            }),
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.promptTextTheme(),
        ),
        initialRoute: '/',
        defaultTransition: Transition.cupertino,
        getPages: [
          GetPage(name: '/', page: () => HomePage()),
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(name: '/register', page: () => const RegisterPage()),
        ]);
  }
}
