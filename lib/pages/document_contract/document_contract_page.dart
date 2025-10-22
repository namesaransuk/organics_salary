import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:organics_salary/controllers/contract_controller.dart';
import 'package:organics_salary/theme.dart';

class DocumentContractPage extends StatefulWidget {
  const DocumentContractPage({super.key});

  @override
  State<DocumentContractPage> createState() => _DocumentContractPageState();
}

class _DocumentContractPageState extends State<DocumentContractPage> {
  final ContractController contractController = Get.put(ContractController());

  @override
  void initState() {
    super.initState();
    contractController.loadData();
  }

  @override
  void dispose() {
    Get.delete<ContractController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    children: [
                      _buildSection(
                        title: 'เอกสารและสัญญา',
                        icon: Icons.description,
                        items: [
                          _buildItemList(Icons.file_copy, 'สัญญาว่าจ้าง',
                              contractController.empContractList),
                          _buildItemList(Icons.file_copy, 'สัญญารักษาความลับ',
                              contractController.empConfidentialityList),
                          _buildItemList(Icons.file_copy, 'สัญญาแข่งขัน',
                              contractController.empCompetitionList),
                          _buildItemList(
                              Icons.file_copy,
                              'สัญญาอบรมที่มีค่าใช้จ่าย',
                              contractController.empPaidTrainingList),
                          _buildItemList(
                              Icons.file_copy,
                              'สัญญาการยืมทรัพย์สินของบริษัทฯ',
                              contractController.empAssetLoanList),
                          _buildItemList(Icons.file_copy, 'สัญญาเงินออม',
                              contractController.empSavingContractList),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _buildSection(
                        title: 'หลักฐานการสมัครสมาชิก และอื่น ๆ',
                        icon: Icons.folder_open,
                        items: [
                          _buildItemList(Icons.file_copy, 'ใบสมัคร',
                              contractController.empFormList),
                          _buildItemList(Icons.file_copy, 'สำเนาบัตรประชาชน',
                              contractController.empIdCardList),
                          _buildItemList(Icons.file_copy, 'สำเนาทะเบียนบ้าน',
                              contractController.empHouseList),
                          _buildItemList(
                              Icons.file_copy,
                              'วุฒิการศึกษา (หลักฐานการศึกษา)',
                              contractController.empEducationalList),
                          _buildItemList(
                              Icons.file_copy,
                              'หน้าบัญชีธนาคารสำหรับรับเงินเดือน',
                              contractController.empBookBankList),
                        ],
                      ),
                    ],
                  ),
                  // child: ListView(
                  //   children: [
                  //     const SizedBox(
                  //       height: 25,
                  //     ),
                  //     const Text(
                  //       'เอกสารและสัญญา',
                  //       style: TextStyle(
                  //         color: AppTheme.ognGreen,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     Obx(
                  //       () => Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 25),
                  //         child: Column(
                  //           children: contractController.contractList
                  //               .map(
                  //                 (element) => listDocumentContract(FontAwesomeIcons.fileContract, element.empContract!.first.fileDetail.toString(), element.empContract!.first.id.toString(), 'ดูข้อมูล'),
                  //               )
                  //               .toList(),
                  //           // listDocumentContract(FontAwesomeIcons.fileContract, 'หนังสือสัญญาจ้าง ', 'ไม่มีข้อมูล'),
                  //           // listDocumentContract(FontAwesomeIcons.fileSignature, 'หนังสือสัญญาการยืมทรัพย์สิน ', 'ไม่มีข้อมูล'),
                  //           // listDocumentContract(FontAwesomeIcons.fileShield, 'หนังสือสัญญารักษาความลับ', 'ไม่มีข้อมูล'),
                  //           // listDocumentContract(FontAwesomeIcons.userShield, 'หนังสือสัญญาการอนุญาติการเก็บรวมรวมนำไปใช้ และเปิดเผยข้อมูลส่วนบุคคล', 'ไม่มีข้อมูล'),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                )
              ],
            ),
          );
          // : SizedBox(
          //     width: double.infinity,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           'assets/img/document_contract/contract.png',
          //           width: MediaQuery.of(context).size.width * 0.25,
          //         ),
          //         const SizedBox(
          //           height: 20,
          //         ),
          //         Text(
          //           'ไม่มีเอกสารและสัญญาของคุณ',
          //           style: TextStyle(
          //             color: Colors.grey[400],
          //             fontSize: 16,
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
        }),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppTheme.ognGreen,
              size: 18,
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppTheme.ognGreen,
              ),
            ),
          ],
        ),
        const Divider(
          color: AppTheme.ognGreen,
          height: 18,
        ),
        const SizedBox(
          height: 8,
        ),
        ...items,
      ],
    );
  }

  Widget _buildItemList(IconData icon, String prefix, List<dynamic> items) {
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
              onTap: () {
                if (items.isNotEmpty) {
                  print('มีข้อมูล');
                  Get.toNamed(
                    'document-contract-section',
                    arguments: {'items': items, 'header': prefix},
                  );
                }
                // contractController.filteredContractList.value = contractController.contractList.where((element) => element.contractCategoryId == id).toList();
                // contractController.filteredContractList = contractController
                //     .contractList
                //     .where((element) => element.contractCategoryId == id)
                //     .map((contract) => contract.toJson())
                //     .toList()
                //     .cast<Map<String, dynamic>>()
                //     .obs;
                // Get.toNamed('document-contract-section');
              },
              child: Text(
                items.isNotEmpty ? 'ดูข้อมูล' : 'ไม่มีข้อมูล',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: items.isNotEmpty
                      ? AppTheme.ognMdGreen
                      : AppTheme.ognOrangeGold,
                  decoration:
                      items.isNotEmpty ? TextDecoration.underline : null,
                  decorationColor: items.isNotEmpty
                      ? AppTheme.ognMdGreen
                      : AppTheme.ognOrangeGold,
                ),
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
