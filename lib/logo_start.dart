import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:organics_salary/controllers/token_controller.dart';

class LogoStart extends StatefulWidget {
  const LogoStart({super.key});

  @override
  _LogoStartState createState() => _LogoStartState();
}

class _LogoStartState extends State<LogoStart> {
  final box = GetStorage();
  final TokenController tokenController = Get.put(TokenController());

  @override
  void initState() {
    super.initState();
    //
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return; // ✅ ป้องกันการใช้ context หลัง unmount

    var baseUrl = dotenv.env['API_URL'];
    var token = dotenv.env['TOKEN'];
    var connect = Get.put(GetConnect());

    var apppin = box.read('pin');
    // var token = box.read('access_token');
    bool isLogged = box.read('isLogged') ?? false;

    finish(context);

    if (!isLogged) {
      Get.offAllNamed('/login');
      // Get.toNamed('/section-start');
      // MLWalkThroughScreen().launch(context);
    } else {
      // if (apppin == 'null' || apppin == '' || apppin == null) {
      //   Get.offAllNamed('/pinauth', arguments: 1);
      // } else {
      await tokenController.checkToken();
      // Get.offAllNamed('/pin');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image.asset('assets/img/logo.jpg',
              height: 150, width: 150, fit: BoxFit.fill)
          .center(),
    );
  }
}
