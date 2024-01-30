import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organics_salary/pages/auth/change_pass_page/change_pass_page.dart';
import 'package:organics_salary/pages/auth/login_page/login_page.dart';
import 'package:organics_salary/pages/auth/pin_page/confirm_pin_auth_page.dart';
import 'package:organics_salary/pages/auth/register_page.dart';
import 'package:organics_salary/pages/auth/reset_pass_page/reset_pass_page.dart';
import 'package:organics_salary/pages/coin/coin_page.dart';
import 'package:organics_salary/pages/coin/coin_scan_page.dart';
import 'package:organics_salary/pages/home/check_pin_page.dart';
import 'package:organics_salary/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:organics_salary/pages/auth/pin_page/pin_auth_page.dart';
import 'package:organics_salary/pages/setting/setting_page.dart';
import 'package:organics_salary/pages/time_history/time_history_month_screen.dart';
import 'package:organics_salary/pages/time_history/time_history_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GetConnect());
  // Get.lazyPut(() => GetConnect());
  await initializeDateFormatting('th', null);
  dotenv.load();
  await GetStorage.init();
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
    final box = GetStorage();
    var isLogged = box.read('isLogged') ?? false;
    var apppin = box.read('pin');

    return GetMaterialApp(
        initialBinding: MyBinding(),
        title: 'Organics Salary',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('th'),
          // const Locale('en'),
          // const Locale('us'),
        ],
        locale: Locale('th'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
          dividerTheme: const DividerThemeData(
            color: Colors.black45,
            // thickness: 2,
          ),
          dividerColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(0xFF136E68, {
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
        // initialRoute: '/login',
        initialRoute: !isLogged
            ? '/login'
            : apppin == 'null' || apppin == ''
                ? '/pinauth'
                : 'pin',
        defaultTransition: Transition.cupertino,
        getPages: [
          GetPage(
              name: '/pin',
              page: () => const CheckPinPage(),
              transition: Transition.noTransition),
          GetPage(name: '/', page: () => HomePage()),
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(name: '/register', page: () => const RegisterPage()),
          GetPage(name: '/pinauth', page: () => const PinAuthPage()),
          GetPage(
              name: '/confirm-pinauth', page: () => const ConfirmPinAuthpage()),
          GetPage(name: '/changepass', page: () => ChangePassPage()),
          GetPage(name: '/resetpass', page: () => ResetPasswordPage()),
          GetPage(name: '/setting', page: () => const SettingPage()),
          GetPage(name: '/coin', page: () => CoinPage()),
          GetPage(name: '/coin-scan', page: () => CoinScanPage()),
          GetPage(name: '/time-history', page: () => TimeHistoryPage()),
          GetPage(
              name: '/time-history-month', page: () => TimeHistoryMonthPage()),
        ]);
  }
}

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetConnect());
  }
}
