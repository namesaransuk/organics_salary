import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/theme.dart';
import 'package:path/path.dart' as path;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentContractSectionPage extends StatefulWidget {
  const DocumentContractSectionPage({super.key});

  @override
  State<DocumentContractSectionPage> createState() => _DocumentContractSectionPageState();
}

class _DocumentContractSectionPageState extends State<DocumentContractSectionPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final List<dynamic> items = arguments['items']; // รับ 'items'
    final String header = arguments['header']; // รับ 'header' ที่เป็น String
    var baseUrl = dotenv.env['ASSET_URL'];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          'เอกสารและสัญญา',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.filePen,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            onPressed: () {
              Get.toNamed('request-document-contract');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length, // จำนวนรายการที่ส่งมา
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          header,
                          style: const TextStyle(
                            color: AppTheme.ognGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Column(
                            children: [
                              listDocumentContract(FontAwesomeIcons.fileContract, 'รายละเอียด', items[index].fileDetail),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidImage,
                                      size: 18,
                                      color: AppTheme.ognOrangeGold,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ไฟล์เอกสารและสัญญา',
                                      style: TextStyle(color: AppTheme.ognMdGreen),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const RangeMaintainingScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Builder(
                                          builder: (context) {
                                            String fileExtension = path.extension(items[index].filePath).toLowerCase();
                                            if (fileExtension == '.jpg' || fileExtension == '.png') {
                                              // แสดงรูปภาพ JPG หรือ PNG
                                              return Image.network(
                                                '$baseUrl/${items[index].filePath}',
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                  return Image.asset('assets/img/logo-error-thumbnail.jpeg');
                                                },
                                              );
                                            } else if (fileExtension == '.pdf') {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PDFScreen(filePath: '$baseUrl/${items[index].filePath}'),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 200,
                                                  color: Colors.grey[200],
                                                  child: const Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.picture_as_pdf,
                                                        size: 50,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        'กดเพื่อดูเอกสาร',
                                                        style: TextStyle(color: AppTheme.ognOrangeGold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              // กรณีอื่นๆ
                                              return Image.asset('assets/img/logo-error-thumbnail.jpeg');
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listDocumentContract(IconData icon, String prefix, String detail) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppTheme.ognOrangeGold,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                prefix,
                style: const TextStyle(color: AppTheme.ognMdGreen),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                detail,
                textAlign: TextAlign.right,
                style: const TextStyle(color: AppTheme.ognMdGreen),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? filePath;

  const PDFScreen({super.key, this.filePath});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print(widget.filePath);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData.fallback(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppTheme.ognOrangeGold,
          onPressed: () => Navigator.pop(context, false),
        ),
        title: const Text(
          'เอกสารและสัญญา',
          style: TextStyle(
            color: AppTheme.ognGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        widget.filePath.toString(),
        key: _pdfViewerKey,
      ),
    );
  }
}
