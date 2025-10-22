import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/controllers/request_doc_controller.dart';
import 'package:organics_salary/pages/request_doc/screen/history_view_screen.dart';
import 'package:organics_salary/pages/request_doc/screen/sent_request_screen.dart';
import 'package:organics_salary/theme.dart';

class RequestDocPage extends StatefulWidget {
  const RequestDocPage({super.key});

  @override
  State<RequestDocPage> createState() => _RequestDocPageState();
}

class _RequestDocPageState extends State<RequestDocPage> {
  final RequestDocController controller = Get.put(RequestDocController());

  final box = GetStorage();
  final baseUrl = dotenv.env['ASSET_URL'];

  Future<bool> _onWillPop() async {
  if (controller.inputCauseController.text.trim().isNotEmpty ||
      controller.salaryCert.value ||
      controller.workCert.value) {
    return await alertConfirmExit(
      'ยืนยันการออก',
      'กดยืนยันเพื่อออกจากหน้านี้',
    );
  }
  return true;
}


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData.fallback(),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppTheme.ognOrangeGold,
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop) {
                Navigator.of(context).pop();
              }
            },
          ),
          title: const Text(
            'ขอเอกสารรับรอง',
            style: TextStyle(
              color: AppTheme.ognGreen,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                constraints: const BoxConstraints.expand(height: 55),
                child: TabBar(
                    splashFactory: NoSplash.splashFactory,
                    dividerColor: const Color.fromARGB(255, 250, 250, 250),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade400,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.ognSmGreen,
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.folderOpen,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "ขอเอกสาร",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.scroll,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "ประวัติคำขอ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
              const Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SentRequestScreen(),
                    HistoryView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
