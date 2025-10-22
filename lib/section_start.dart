import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SectionStart extends StatefulWidget {
  const SectionStart({super.key});

  @override
  _SectionStartState createState() => _SectionStartState();
}

class _SectionStartState extends State<SectionStart> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    //
    init();
  }

  Future<void> init() async {}

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://organicscosme.com')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://organicscosme.com'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: InkWell(
              onTap: () {
                Get.offAllNamed('/login');
              },
              child: const Text(
                'เข้าสู่ระบบ',
                style: TextStyle(color: AppTheme.ognMdGreen),
              ),
            ),
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
